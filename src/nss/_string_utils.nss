////////////////////////////////////////////////////////////////////////////////
// Universe of Arlandia - String Parsing Utilities
//
// Provides Between() and field-extraction helpers to replace the verbose
// nested GetStringLeft/GetStringRight/FindSubString chains used throughout
// the codebase.
//
// Usage:
//   #include "_string_utils"
//
//   string sName  = Between(sRecord, FIELD_A, FIELD_B);
//   string sPlace = EncodedField(sPlanetData, 2);  // value between &001& and &002&
//   string sHench = LetterField(sHenchData, 3);    // value between &B& and &C&
//
// All three functions mirror the PHP helpers in helpers.php on the web side.
////////////////////////////////////////////////////////////////////////////////
#include "_constants"

// ---------------------------------------------------------------------------
// Between(sData, sAfter, sBefore)
//
// Returns the substring of sData that lies after sAfter and before sBefore.
//   sAfter  = ""  ->  start from the beginning of sData
//   sBefore = ""  ->  read to the end of sData
// Returns "" if a non-empty delimiter is not found.
//
// Replaces patterns like:
//   GetStringRight(GetStringLeft(s,FindSubString(s,"&002&")),
//     GetStringLength(GetStringLeft(s,FindSubString(s,"&002&")))
//     -FindSubString(s,"&001&")-5)
// with:
//   Between(s, "&001&", "&002&")
// ---------------------------------------------------------------------------
string Between(string sData, string sAfter, string sBefore)
{
    int iStart;

    if (sBefore != "") {
        int iEnd = FindSubString(sData, sBefore);
        if (iEnd == -1) return "";
        sData = GetStringLeft(sData, iEnd);
    }

    if (sAfter == "") return sData;

    iStart = FindSubString(sData, sAfter);
    if (iStart == -1) return "";
    return GetStringRight(sData, GetStringLength(sData) - iStart - GetStringLength(sAfter));
}

// ---------------------------------------------------------------------------
// PadInt3(n)
// Returns n as a zero-padded 3-digit string: 7 -> "007", 12 -> "012".
// Used internally by EncodedField().
// ---------------------------------------------------------------------------
string PadInt3(int n)
{
    string s = IntToString(n);
    int iLen = GetStringLength(s);
    if (iLen == 1) return "00" + s;
    if (iLen == 2) return "0" + s;
    return s;
}

// ---------------------------------------------------------------------------
// EncodedField(sData, n)
//
// Extracts the nth field from a &001&-delimited string (1-indexed).
// Mirrors the PHP encoded_field() helper in helpers.php.
//
// Example:
//   EncodedField(sPlanet, 1)  ->  value before &001&
//   EncodedField(sPlanet, 2)  ->  value between &001& and &002&
//   EncodedField(sPlanet, 9)  ->  value between &008& and &009&
// ---------------------------------------------------------------------------
string EncodedField(string sData, int n)
{
    string sCurr = "&" + PadInt3(n) + "&";
    string sPrev = (n > 1) ? "&" + PadInt3(n - 1) + "&" : "";
    return Between(sData, sPrev, sCurr);
}

// ---------------------------------------------------------------------------
// LetterField(sData, n)
//
// Extracts the nth field from an &A&-delimited string (1-indexed, A=1, B=2…).
//
// Example:
//   LetterField(sHench, 1)  ->  value before &A&
//   LetterField(sHench, 2)  ->  value between &A& and &B&
//   LetterField(sHench, 3)  ->  value between &B& and &C&
// ---------------------------------------------------------------------------
string LetterField(string sData, int n)
{
    string sCurr = "&" + GetSubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ", n - 1, 1) + "&";
    string sPrev = (n > 1) ? "&" + GetSubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ", n - 2, 1) + "&" : "";
    return Between(sData, sPrev, sCurr);
}

// ---------------------------------------------------------------------------
// Area tile column helpers
//
// Planet area grids are stored one X-column per pwdata key
// (<Planet>AreasX<iX>). Each column string encodes terrain codes using
// signed, zero-padded Y-coordinate delimiters: &+05&, &-03&, etc.
// Discovery is flagged by appending "*" to the terrain code (e.g. "04*").
//
// These helpers replace the repeated sCount1/sCount2 blobs scattered across
// transitions.nss, _galaxy.nss, conv_dm015.nss, and conv_dm042.nss.
// They mirror PHP's tile_key() helper in helpers.php.
// ---------------------------------------------------------------------------

// Format a Y coordinate as the &±YY& tile column delimiter.
// Mirrors PHP tile_key() in helpers.php.
string AreaTileKey(int iY)
{
    if (iY <= -10) return "&-" + IntToString(-iY) + "&";
    if (iY <    0) return "&-0" + IntToString(-iY) + "&";
    if (iY <   10) return "&+0" + IntToString(iY)  + "&";
    return "&+" + IntToString(iY) + "&";
}

// Return the raw entry (terrain code, possibly ending in "*") at row iY in
// a column string. Returns "" if iY is not found.
string _GetRawTile(string sCol, int iY)
{
    string sKey  = AreaTileKey(iY);
    string sPrev = AreaTileKey(iY - 1);
    // If the previous key doesn't exist we are at the bottom of the column.
    if (FindSubString(sCol, sPrev) == -1)
        return GetStringLeft(sCol, FindSubString(sCol, sKey));
    return Between(sCol, sPrev, sKey);
}

// Return the terrain code at (iX, iY) on sPlanet, stripping "*" if present.
string GetAreaTile(object oModule, string sPlanet, int iX, int iY)
{
    string sCol = GetPersistentString(oModule, sPlanet + "AreasX" + IntToString(iX));
    string sRaw = _GetRawTile(sCol, iY);
    if (GetStringRight(sRaw, 1) == "*")
        return GetStringLeft(sRaw, GetStringLength(sRaw) - 1);
    return sRaw;
}

// Return TRUE if the tile at (iX, iY) on sPlanet has been discovered.
int IsAreaTileDiscovered(object oModule, string sPlanet, int iX, int iY)
{
    string sCol = GetPersistentString(oModule, sPlanet + "AreasX" + IntToString(iX));
    return (GetStringRight(_GetRawTile(sCol, iY), 1) == "*");
}

// Return sCol with the discovery marker at iY set (iDiscovered=TRUE) or
// cleared (iDiscovered=FALSE). Caller writes result back with SetPersistentString.
string SetColTileDiscovered(string sCol, int iY, int iDiscovered)
{
    string sKey = AreaTileKey(iY);
    string sRaw = _GetRawTile(sCol, iY);
    int bHas = (GetStringRight(sRaw, 1) == "*");
    if (iDiscovered == bHas) return sCol; // already correct
    string sBase = bHas ? GetStringLeft(sRaw, GetStringLength(sRaw) - 1) : sRaw;
    string sNew  = iDiscovered ? (sBase + "*") : sBase;
    int iPos = FindSubString(sCol, sKey) - GetStringLength(sRaw);
    return GetStringLeft(sCol, iPos) + sNew + GetStringRight(sCol, GetStringLength(sCol) - iPos - GetStringLength(sRaw));
}

// Return sCol with the terrain code at iY replaced by sCode (preserves "*").
// Caller writes result back with SetPersistentString.
string SetColTile(string sCol, int iY, string sCode)
{
    string sKey = AreaTileKey(iY);
    string sRaw = _GetRawTile(sCol, iY);
    int bDiscovered = (GetStringRight(sRaw, 1) == "*");
    string sNew = bDiscovered ? (sCode + "*") : sCode;
    int iPos = FindSubString(sCol, sKey) - GetStringLength(sRaw);
    return GetStringLeft(sCol, iPos) + sNew + GetStringRight(sCol, GetStringLength(sCol) - iPos - GetStringLength(sRaw));
}

// ---------------------------------------------------------------------------
// GetPlanetLevel(oModule, sPlanetName)
//
// Returns the iPlanetLevel (1-9) of the named planet, by scanning the
// "System<j>" / "<sSystem>Planets" / "<sSystem>Planet<i>" module-local
// records that _galaxy.nss rebuilds at every mod_load (see _galaxy.nss:112
// and the sTot encoding at _galaxy.nss:138, where the planet name is field 1
// and iPlanetLevel is field 29 of the &NNN&-delimited record). Returns 1 if
// no matching planet is found (e.g. a planet added after the last _galaxy
// rebuild), so callers always get a sane minimum difficulty.
//
// Systems and planets per system are few (galaxy-sized, not world-sized), so
// this brute-force scan is cheap enough to call from area_recall.nss.
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// StripWearSuffix(sName)
//
// Removes a trailing " NN%" wear-percentage suffix previously appended by
// SetWearName(), if present. Leaves sName untouched if it doesn't end in a
// plain "<space><digits>%" token (e.g. a fresh item, or a name ending in an
// unrelated "%" that isn't preceded by digits+space).
// ---------------------------------------------------------------------------
string StripWearSuffix(string sName)
{
    int iLen = GetStringLength(sName);
    if (iLen == 0 || GetStringRight(sName, 1) != "%") return sName;

    int i = iLen - 2;
    int iDigits = 0;
    while (i >= 0)
    {
        string sChar = GetSubString(sName, i, 1);
        if (sChar == " ") break;
        if (FindSubString("0123456789", sChar) == -1) return sName;
        iDigits++;
        i--;
    }
    if (iDigits == 0 || i < 0) return sName;
    return GetStringLeft(sName, i);
}

// ---------------------------------------------------------------------------
// SetWearName(oItem, iWearPct)
//
// Appends the item's remaining condition (100% = unworn, 0% = about to
// break) to the end of its displayed name, e.g. "Longsword 98%". Replaces
// any wear suffix left by a previous call, so calling this every heartbeat
// tick doesn't keep stacking percentages onto the name.
// ---------------------------------------------------------------------------
void SetWearName(object oItem, int iWearPct)
{
    string sBase = StripWearSuffix(GetName(oItem));
    SetName(oItem, sBase + " " + IntToString(iWearPct) + "%");
}

int GetPlanetLevel(object oModule, string sPlanetName)
{
    int iSystems = StringToInt(GetLocalString(oModule, "Systems"));
    int j;
    for (j = 1; j <= iSystems; j++)
    {
        string sSystem = GetLocalString(oModule, "System" + IntToString(j));
        int iPlanets = StringToInt(GetLocalString(oModule, sSystem + "Planets"));
        int i;
        for (i = 1; i <= iPlanets; i++)
        {
            string sRecord = GetLocalString(oModule, sSystem + "Planet" + IntToString(i));
            if (EncodedField(sRecord, 1) == sPlanetName)
            {
                return StringToInt(EncodedField(sRecord, 29));
            }
        }
    }
    return 1;
}
