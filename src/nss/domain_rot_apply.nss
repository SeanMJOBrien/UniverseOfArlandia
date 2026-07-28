#include "aps_include"
#include "_string_utils"
// Does the actual destroy+rebuild+client-refresh work for
// DomainSetRotation (_string_utils.nss), which hands off here via
// DelayCommand(0.0,ExecuteScript("domain_rot_apply",oArea)) instead of
// doing this inline on the structure's own flag object - see the long
// comment on DomainSetRotation for why: destroying the flag as part of
// clearing the slot's old pieces, when that flag was also this script's
// own OBJECT_SELF, silently cancelled every DelayCommand scheduled
// afterward. Running here with OBJECT_SELF=oArea (never destroyed by the
// loop below - only objects *inside* the area are) sidesteps that.
void main()
{
    object oArea = OBJECT_SELF;
    int iSlot = GetLocalInt(oArea, "RotApplySlot");
    int iStructure = GetLocalInt(oArea, "RotApplyStructure");
    string sMaster = GetLocalString(oArea, "RotApplyMaster");
    object oPC = GetLocalObject(oArea, "RotApplyPC");
    DeleteLocalInt(oArea, "RotApplySlot");
    DeleteLocalInt(oArea, "RotApplyStructure");
    DeleteLocalString(oArea, "RotApplyMaster");
    DeleteLocalObject(oArea, "RotApplyPC");

    // Destroy this slot's existing pieces (matched on Slot+Master), the
    // structureflag included this time - before rebuilding, otherwise
    // domains.nss would stack a second, differently-rotated copy on top
    // instead of replacing it.
    object oNext;
    object oPiece = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oPiece))
    {
        oNext = GetNextObjectInArea(oArea);
        if ((GetLocalInt(oPiece, "Slot") == iSlot) && (GetLocalString(oPiece, "Master") == sMaster)) { DestroyObject(oPiece); }
        oPiece = oNext;
    }

    // Rebuild via the same single-slot loop entry point Build already uses
    // (domains.nss's iChoice2!=0 case) with Domain_Ini=1 so it takes the
    // "just re-render existing state" path instead of the interactive
    // purchase/payment path.
    SetLocalString(oArea, "Domain_Build", IntToString(iSlot) + "_+_" + IntToString(iStructure));
    SetLocalInt(oArea, "Domain_Ini", 1);
    SetLocalObject(oArea, "PC", oPC);
    DelayCommand(0.1, ExecuteScript("domains", oArea));
    FloatingTextStringOnCreature("Structure rotated", oPC);

    // NOT calling ForceAreaRefresh(oPC) here (see _string_utils.nss) - the
    // jump-out-and-back trick fundamentally can't work for a domain area,
    // since a domain's area is a per-coordinate CopyArea() clone (TASK-22)
    // and the player rotating a solo structure is typically alone in it:
    // the jump-out empties the area, area_exit.nss schedules area_save.nss
    // 0.3s later, which destroys such clones - so the captured "jump back
    // here" location's own area is gone by the time the jump-back tries to
    // use it, no matter how carefully the jump-back itself is scheduled
    // (confirmed by testing - fixing the scheduling just moved the failure
    // from "cancelled" to "target location invalid", never actually
    // returning the player). Now that domain_rot_apply.nss's rebuild
    // itself works correctly (this was blocked entirely before by the
    // self-destruction bug fixed above - every earlier test of this
    // feature likely never got this far), the original "stays showing the
    // old orientation" symptom may simply have been a side effect of the
    // rebuild silently never running at all, not a real client-side
    // static-object rendering quirk - worth confirming before reintroducing
    // any area-transition trick for this.
}
