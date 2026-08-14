// dmb_clucre_boot - restore Creator-tool cluster creatures at module load
// ---
// Run from mod_load.nss right after dmb_cluster_boot.nss, which has by then
// already stamped Planet/Area/IsClusterMember on every member area - so
// GetObjectByTag resolution and DmbRestoreCluCreatures() below both work.
// Same ClusterTot/Cluster<n> enumeration dmb_cluster_boot.nss uses, since
// there's no other way to list every registered cluster member area.
#include "dmb_inc"
#include "dmb_clucre_inc"

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

        string sDir;
        int j;
        for (j = 1; j <= 4; j++)
        {
            if (j == 1) sDir = "North"; else if (j == 2) sDir = "East";
            else if (j == 3) sDir = "South"; else sDir = "West";
            string sTag = DmbClusterDirTag(sRecord, sDir);
            if (sTag == "") continue;
            object oMember = GetObjectByTag(sTag);
            if (GetIsObjectValid(oMember)) DmbRestoreCluCreatures(oMember);
        }
    }
}
