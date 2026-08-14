// dmb_clucre_save - resave every cluster member's Creator-tool creatures
// ---
// Called from mod_heartbeat.nss right before the module's own scheduled
// self-reboot, so a graceful restart reflects each creature's latest
// position/HP instead of only what was captured at spawn time. Idempotent
// (full rescan per member, see DmbResaveCluCreatures) - safe to run more
// than once if the reboot condition stays true across a heartbeat or two
// while shutdown is in flight. Same ClusterTot/Cluster<n> enumeration as
// dmb_cluster_boot.nss/dmb_clucre_boot.nss.
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
            if (GetIsObjectValid(oMember)) DmbResaveCluCreatures(oModule, oMember);
        }
    }
}
