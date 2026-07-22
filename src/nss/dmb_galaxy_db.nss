// dmb_galaxy_db - register DM-created planets from the database at boot.
// ---
// The DM website (www/planetCreator.php) stores planets/moons/asteroids in
// pwdata as:
//   "DMPlanetsTot"  (int)   number of records
//   "DMPlanet<n>"   (string) "<System>#<planet record>"
// where <planet record> is the exact &001&..&030& blob _galaxy.nss builds
// for its hardcoded planets (name, place, size, type, show, tiles 1-5 +
// probabilities, creatures, resources, ambiance, interest probabilities,
// level, description).
//
// Executed from _galaxy.nss BETWEEN the hardcoded planet definitions and
// the Systems regen loop, so a DB planet is appended to its system's
// "<Sys>Planet<i>"/"<Sys>Planets" module locals and then flows through the
// exact same downstream machinery as a hardcoded one: area generation, the
// "Galaxy" index, the "Space<place>" record, and the destroyed-planet
// cleanup (a record deleted on the website is simply not registered next
// boot, so _galaxy's existing cleanup pass wipes its variables).
//
// Records that fail validation are skipped with a server-log line - a bad
// website write must never abort galaxy generation.

#include "aps_include"
#include "_module"
#include "_string_utils"

// TRUE if sName is already registered as a planet in any system's module
// locals (hardcoded planets and DB planets appended before this one).
int DmbPlanetNameTaken(object oModule, string sName)
{
    int j = StringToInt(GetLocalString(oModule, "Systems"));
    while (j > 0)
    {
        string sSystem = GetLocalString(oModule, "System" + IntToString(j));
        int i = StringToInt(GetLocalString(oModule, sSystem + "Planets"));
        while (i > 0)
        {
            if (EncodedField(GetLocalString(oModule, sSystem + "Planet" + IntToString(i)), 1) == sName) return TRUE;
            i--;
        }
        j--;
    }
    return FALSE;
}

// TRUE if another registered planet already sits at galaxy position sPlace.
int DmbPlanetPlaceTaken(object oModule, string sPlace)
{
    int j = StringToInt(GetLocalString(oModule, "Systems"));
    while (j > 0)
    {
        string sSystem = GetLocalString(oModule, "System" + IntToString(j));
        int i = StringToInt(GetLocalString(oModule, sSystem + "Planets"));
        while (i > 0)
        {
            if (EncodedField(GetLocalString(oModule, sSystem + "Planet" + IntToString(i)), 2) == sPlace) return TRUE;
            i--;
        }
        j--;
    }
    return FALSE;
}

// Module-local slot index (1-based) of system sSystem; 0 if unknown.
int DmbSystemIndex(object oModule, string sSystem)
{
    int j = StringToInt(GetLocalString(oModule, "Systems"));
    while (j > 0)
    {
        if (GetLocalString(oModule, "System" + IntToString(j)) == sSystem) return j;
        j--;
    }
    return 0;
}

void main()
{
    object oModule = GetModule();
    int iTot = GetPersistentInt(oModule, "DMPlanetsTot");
    int n;
    for (n = 1; n <= iTot; n++)
    {
        string sKey = "DMPlanet" + IntToString(n);
        string sRecord = GetPersistentString(oModule, sKey);
        if (sRecord == "") continue;

        int iSep = FindSubString(sRecord, "#");
        if (iSep <= 0)
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " skipped: no system separator");
            continue;
        }
        string sSystem = GetStringLeft(sRecord, iSep);
        string sTot = GetStringRight(sRecord, GetStringLength(sRecord) - iSep - 1);

        string sName = EncodedField(sTot, 1);
        string sPlace = EncodedField(sTot, 2);
        int iSize = StringToInt(EncodedField(sTot, 3));
        string sType = EncodedField(sTot, 4);
        int iLevel = StringToInt(EncodedField(sTot, 29));

        if (DmbSystemIndex(oModule, sSystem) == 0)
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " skipped: unknown system '" + sSystem + "'");
            continue;
        }
        if ((sName == "") || (FindSubString(sName, "&") != -1) || (FindSubString(sName, "#") != -1))
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " skipped: bad name '" + sName + "'");
            continue;
        }
        if ((iSize < 4) || (iSize > iPlanetsMaxSize))
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " ('" + sName + "') skipped: bad size " + IntToString(iSize));
            continue;
        }
        if (GetStringLength(sType) != 3)
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " ('" + sName + "') skipped: bad type '" + sType + "'");
            continue;
        }
        if ((iLevel < 1) || (iLevel > 9))
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " ('" + sName + "') skipped: bad level " + IntToString(iLevel));
            continue;
        }
        if (DmbPlanetNameTaken(oModule, sName))
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " skipped: planet '" + sName + "' already exists");
            continue;
        }
        if ((sPlace == "") || (DmbPlanetPlaceTaken(oModule, sPlace)))
        {
            WriteTimestampedLogEntry("[dmb_galaxy_db] " + sKey + " ('" + sName + "') skipped: place '" + sPlace + "' empty or taken");
            continue;
        }

        int iNext = StringToInt(GetLocalString(oModule, sSystem + "Planets")) + 1;
        SetLocalString(oModule, sSystem + "Planet" + IntToString(iNext), sTot);
        SetLocalString(oModule, sSystem + "Planets", IntToString(iNext));
        WriteTimestampedLogEntry("[dmb_galaxy_db] registered '" + sName + "' (" + sType + ", size " + IntToString(iSize) + ", level " + IntToString(iLevel) + ") at " + sPlace + " in system " + sSystem);
    }
}
