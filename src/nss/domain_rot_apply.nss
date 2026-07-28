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

    // The rebuilt pieces can stay showing their old orientation to oPC
    // specifically (they were already standing nearby, not freshly arriving)
    // until they leave and re-enter the area - the client doesn't reliably
    // redraw objects marked static (area_pop_inc.nss's
    // NWNX_Object_SetPlaceableIsStatic, see TASK-18) after an ad-hoc runtime
    // destroy+recreate cycle like this one. 0.5s gives the 0.1s-delayed
    // rebuild above time to finish before the refresh jump fires.
    DelayCommand(0.5, ForceAreaRefresh(oPC));
}
