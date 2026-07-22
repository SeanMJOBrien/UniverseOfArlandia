// dmb_cluster_boot - rebuild DM cluster runtime state at module load.
// ---
// Cluster records persist in pwdata but everything runtime is volatile:
// the module-local record cache ("CluRec_..."), the member reverse lookups
// ("CluMember_<tag>", set inside DmbStampMember), and the member areas'
// Planet/Area/IsClusterMember locals. Walk the ClusterTot/Cluster<n> index
// and restore all of it so edge triggers and arrivals work immediately -
// even for a character logging back in inside a member area.
//
// Run from mod_load.nss AFTER _galaxy (the tile columns must exist; a
// cluster tile is always discovered, so _galaxy preserves its code).

#include "dmb_inc"

void main()
{
    object oModule = GetModule();
    int iTot = GetPersistentInt(oModule, "ClusterTot");
    int i;
    for (i = 1; i <= iTot; i++)
    {
        string sEntry = GetPersistentString(oModule, "Cluster" + IntToString(i));
        if (sEntry == "") continue;
        string sPlanet = Between(sEntry, "", "&");
        string sCoord = Between(sEntry, "&", "");
        string sRecord = GetPersistentString(oModule, DmbClusterKey(sPlanet, sCoord));
        if (sRecord == "") continue;
        SetLocalString(oModule, "CluRec_" + sPlanet + "_" + sCoord, sRecord);
        DmbStampAllMembers(sPlanet, sCoord, sRecord);
    }
}
