// dmb_clucre_inc - persistence for Creator-tool creatures in cluster areas
// ---
// Cluster member areas are static and never destroyed/recreated during a
// running session (area_save.nss:10 excludes them from the module's whole
// generic object-persistence pipeline, since that pipeline's keys are
// shared per coordinate and would cross-write between members). That means
// nothing a DM spawns into one via the Creator tool (conv_dm020.nss "Land
// creatures") survives a restart on its own - this file gives that a home,
// keyed per member-area TAG (not coordinate, for the same cross-write
// reason area_save.nss avoids clusters).
//
// Data model:
// - "CluCre_<memberTag>Tot" + "CluCre_<memberTag><n>" = one &A&..&R&
//   delimited creature record per saved creature (same Tot/N shape as
//   ClusterTot/Cluster<n> in dmb_inc.nss).
// - Record fields (18, matching what conv_dm020.nss's Land-creatures branch
//   itself sets - nothing invented): ResRef, Tag, Name, PosX, PosY, PosZ,
//   Facing, current HP, faction (1-4), Stop, Master, HitPoints (the DM
//   tool's own bookkeeping local, not live HP), Var, Hench, HenchNum, Camp,
//   Flee, NotFlee.
//
// Three call sites (none of them live in this file):
// - conv_dm020.nss calls DmbSaveCluCreature() right after landing a
//   Persistent creature in a cluster member area (snapshot-at-spawn floor).
// - mod_heartbeat.nss calls a per-member DmbResaveCluCreatures() for every
//   cluster member, right before the module's own scheduled reboot
//   (refreshes position/HP/etc for a graceful restart).
// - dmb_clucre_boot.nss (run from mod_load.nss, after dmb_cluster_boot.nss)
//   calls DmbRestoreCluCreatures() per member to recreate everything saved.

#include "aps_include"
#include "_string_utils"

// ---------------------------------------------------------------------------
// Keys
// ---------------------------------------------------------------------------

string DmbCluCreTotKey(string sMemberTag)
{
    return "CluCre_" + sMemberTag + "Tot";
}

string DmbCluCreKey(string sMemberTag, int n)
{
    return "CluCre_" + sMemberTag + IntToString(n);
}

// ---------------------------------------------------------------------------
// Encode
// ---------------------------------------------------------------------------

// Single source of truth for the record shape - called identically whether
// saving one freshly-landed creature or resaving everything live in a
// member area, so the two call sites can't drift apart.
string DmbEncodeCluCreature(object oCreature)
{
    int iFaction;
         if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oCreature) >= 90) { iFaction = 1; }
    else if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oCreature) >= 90) { iFaction = 2; }
    else if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oCreature) >= 90)  { iFaction = 3; }
    else                                                                               { iFaction = 4; }

    return GetResRef(oCreature) + "&A&" +
           GetTag(oCreature) + "&B&" +
           GetName(oCreature) + "&C&" +
           IntToString(FloatToInt(GetPosition(oCreature).x)) + "&D&" +
           IntToString(FloatToInt(GetPosition(oCreature).y)) + "&E&" +
           IntToString(FloatToInt(GetPosition(oCreature).z)) + "&F&" +
           IntToString(FloatToInt(GetFacing(oCreature))) + "&G&" +
           IntToString(GetCurrentHitPoints(oCreature)) + "&H&" +
           IntToString(iFaction) + "&I&" +
           IntToString(GetLocalInt(oCreature, "Stop")) + "&J&" +
           GetLocalString(oCreature, "Master") + "&K&" +
           IntToString(GetLocalInt(oCreature, "HitPoints")) + "&L&" +
           GetLocalString(oCreature, "Var") + "&M&" +
           IntToString(GetLocalInt(oCreature, "Hench")) + "&N&" +
           IntToString(GetLocalInt(oCreature, "HenchNum")) + "&O&" +
           IntToString(GetLocalInt(oCreature, "Camp")) + "&P&" +
           IntToString(GetLocalInt(oCreature, "Flee")) + "&Q&" +
           IntToString(GetLocalInt(oCreature, "NotFlee")) + "&R&";
}

// ---------------------------------------------------------------------------
// Save (trigger 1: snapshot-at-spawn floor)
// ---------------------------------------------------------------------------

void DmbSaveCluCreature(object oModule, object oCreature)
{
    string sMemberTag = GetTag(GetArea(oCreature));
    int iTot = GetPersistentInt(oModule, DmbCluCreTotKey(sMemberTag)) + 1;
    SetPersistentString(oModule, DmbCluCreKey(sMemberTag, iTot), DmbEncodeCluCreature(oCreature));
    SetPersistentInt(oModule, DmbCluCreTotKey(sMemberTag), iTot);
}

// ---------------------------------------------------------------------------
// Resave (trigger 2: pre-scheduled-reboot refresh)
// ---------------------------------------------------------------------------

// Full rescan of oMember, not an incremental diff - a creature that died or
// was removed since the last save simply drops out, no deletion-tracking
// needed. Only creatures the DM explicitly marked Persistent are eligible,
// matching what the generic (non-cluster) pipeline treats as save-worthy.
void DmbResaveCluCreatures(object oModule, object oMember)
{
    string sMemberTag = GetTag(oMember);
    int iOldTot = GetPersistentInt(oModule, DmbCluCreTotKey(sMemberTag));
    int iNewTot;
    object oObject = GetFirstObjectInArea(oMember);
    while (GetIsObjectValid(oObject))
    {
        if ((GetObjectType(oObject) == OBJECT_TYPE_CREATURE) && (GetLocalInt(oObject, "Persistent") == 1))
        {
            iNewTot++;
            SetPersistentString(oModule, DmbCluCreKey(sMemberTag, iNewTot), DmbEncodeCluCreature(oObject));
        }
        oObject = GetNextObjectInArea(oMember);
    }
    int i = iNewTot + 1;
    while (i <= iOldTot)
    {
        DeletePersistentVariable(oModule, DmbCluCreKey(sMemberTag, i));
        i++;
    }
    SetPersistentInt(oModule, DmbCluCreTotKey(sMemberTag), iNewTot);
}

// ---------------------------------------------------------------------------
// Restore (trigger 3: boot)
// ---------------------------------------------------------------------------

// Recreate one saved creature. DontSave=1 keeps area_recall.nss's once-per-
// boot "Permanent toolset object" pass (area_recall.nss:45, which runs on
// this same member area's first arrival, after we've already run) from
// silently sweeping it up as plot-immune toolset content.
void DmbSpawnCluCreature(object oMember, string sRecord)
{
    string sBP = LetterField(sRecord, 1);
    string sTag = LetterField(sRecord, 2);
    string sName = LetterField(sRecord, 3);
    float fX = IntToFloat(StringToInt(LetterField(sRecord, 4)));
    float fY = IntToFloat(StringToInt(LetterField(sRecord, 5)));
    float fZ = IntToFloat(StringToInt(LetterField(sRecord, 6)));
    float fFacing = IntToFloat(StringToInt(LetterField(sRecord, 7)));
    int iHP = StringToInt(LetterField(sRecord, 8));
    int iFaction = StringToInt(LetterField(sRecord, 9));
    int iStop = StringToInt(LetterField(sRecord, 10));
    string sMaster = LetterField(sRecord, 11);
    int iHitPoints = StringToInt(LetterField(sRecord, 12));
    string sVar = LetterField(sRecord, 13);
    int iHench = StringToInt(LetterField(sRecord, 14));
    int iHenchNum = StringToInt(LetterField(sRecord, 15));
    int iCamp = StringToInt(LetterField(sRecord, 16));
    int iFlee = StringToInt(LetterField(sRecord, 17));
    int iNotFlee = StringToInt(LetterField(sRecord, 18));

    object oNew = CreateObject(OBJECT_TYPE_CREATURE, sBP, Location(oMember, Vector(fX, fY, fZ), fFacing), FALSE, sTag);
    if (!GetIsObjectValid(oNew)) return;

    if (GetName(oNew) != sName) { SetName(oNew, sName); }
    SetLocalInt(oNew, "Persistent", 1);
    SetLocalInt(oNew, "DontSave", 1);
    SetLocalInt(oNew, "Stop", iStop);
    SetLocalString(oNew, "Master", sMaster);
    SetLocalInt(oNew, "HitPoints", iHitPoints);
    SetLocalString(oNew, "Var", sVar);
    SetLocalInt(oNew, "Hench", iHench);
    SetLocalInt(oNew, "HenchNum", iHenchNum);
    SetLocalInt(oNew, "Camp", iCamp);
    SetLocalInt(oNew, "Flee", iFlee);
    SetLocalInt(oNew, "NotFlee", iNotFlee);

         if (iFaction == 1) { ChangeToStandardFaction(oNew, STANDARD_FACTION_COMMONER); }
    else if (iFaction == 2) { ChangeToStandardFaction(oNew, STANDARD_FACTION_DEFENDER); }
    else if (iFaction == 3) { ChangeToStandardFaction(oNew, STANDARD_FACTION_HOSTILE); }
    else                    { ChangeToStandardFaction(oNew, STANDARD_FACTION_MERCHANT); }

    // Same dead-creature handling area_recall.nss:114 already uses for every
    // other restored creature type - no new convention invented.
    if (iHP < 1)
    {
        SetLocalInt(oNew, "Dead", 1);
        AssignCommand(oNew, SetIsDestroyable(FALSE, FALSE, FALSE));
        object oItem = GetFirstItemInInventory(oNew);
        while (GetIsObjectValid(oItem)) { DestroyObject(oItem); oItem = GetNextItemInInventory(oNew); }
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints(oNew)), oNew);
    }
}

void DmbRestoreCluCreatures(object oMember)
{
    object oModule = GetModule();
    string sMemberTag = GetTag(oMember);
    int iTot = GetPersistentInt(oModule, DmbCluCreTotKey(sMemberTag));
    int i;
    for (i = 1; i <= iTot; i++)
    {
        string sRecord = GetPersistentString(oModule, DmbCluCreKey(sMemberTag, i));
        if (sRecord != "") DmbSpawnCluCreature(oMember, sRecord);
    }
}
