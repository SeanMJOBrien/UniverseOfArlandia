#include "nw_inc_nui"
#include "_module"
// _shipname - player-named ships.
//
// A PC owns up to three ship tools - tool_ship (sea), tool_airship (sky),
// tool_starship (space). Each can carry a name the player chooses, stored as a
// local string on the tool item itself, so it travels with the character file
// and needs no pwdata row.
//
// area_enter.nss already turns a PC into a ship model on entering one of those
// environments (appearance 339 ocean / 342 clouds / 338 space). This renames
// them to match for as long as that lasts, and drops the override when they
// return to their own body. SetName(oObject,"") reverts an object to the name
// it had before any SetName call, so the real character name never has to be
// stashed anywhere.
//
// THE RENAME HALF IS OFF BY DEFAULT - see iShipNameRename in _module.nss.
// Naming, storage and the window all work; only the swap onto the PC is gated.
//
// Reason: this module uses GetName(oPC) as a DATABASE KEY in 96 places. The
// worst is area_exit.nss:19, which gates the whole area-save path on
// GetLocalInt(oModule, GetName(oPC)) - rename a pilot mid-flight and their
// areas silently stop saving. Domain ownership (cond_domain004/005/018/019),
// challenge progress, henchman Master strings and transitions2's
// GetName(oPC)+"Loc" pending-arrival key are all keyed the same way.
//
// Neither rename route avoids this. Base SetName() changes what GetName()
// returns, and NWNX_Rename_SetPCNameOverride does too - its own header says to
// use GetName(oPC, TRUE) for the true name. (That plugin isn't loaded anyway:
// ~/uoa/config/nwserver.env sets NWNX_CORE_SKIP_ALL=yes and has no
// NWNX_RENAME_SKIP=no line.)
//
// The fix is to convert those 96 call sites to GetName(oPC, TRUE), which is
// identical in behaviour while no override is active and so is safe to do
// ahead of time. That audit is TASK-33; flip iShipNameRename to 1 once it's
// done and confirmed.

const string SHIPNAME_VAR     = "ShipName";      // local string on the tool item
const string SHIPNAME_WINDOW  = "shipname";
const string SHIPNAME_EVENT   = "shipname_event";
const string SHIPNAME_BIND    = "shipname";      // text-edit bind id
const string SHIPNAME_SAVE    = "save";
const string SHIPNAME_CLEAR   = "clear";
const string SHIPNAME_PCTOOL  = "ShipNameTool";  // PC local: tool the window edits
const int    SHIPNAME_MAXLEN  = 40;

// Which ship tool governs a given area, or "" if the area isn't one a ship
// carries you through. Mirrors the tag prefixes area_enter.nss switches its
// appearance swap on, and the tool/area pairing cond_ship001.nss already gates
// the flight dialog with.
string ShipToolForArea(string sAreaTag)
{
    if (GetStringLeft(sAreaTag, 5) == "ocean")  { return "tool_ship"; }
    if (GetStringLeft(sAreaTag, 6) == "clouds") { return "tool_airship"; }
    if (GetStringLeft(sAreaTag, 5) == "space")  { return "tool_starship"; }
    return "";
}

// Human-readable kind, for window titles and feedback.
string ShipKindLabel(string sToolTag)
{
    if (sToolTag == "tool_ship")     { return "sea ship"; }
    if (sToolTag == "tool_airship")  { return "airship"; }
    if (sToolTag == "tool_starship") { return "starship"; }
    return "ship";
}

// The name stored on oPC's tool of this kind, or "" when unnamed / not owned.
string ShipNameOf(object oPC, string sToolTag)
{
    object oTool = GetItemPossessedBy(oPC, sToolTag);
    if (!GetIsObjectValid(oTool)) { return ""; }
    return GetLocalString(oTool, SHIPNAME_VAR);
}

// Apply the right ship name for the area oPC just entered, or clear the
// override when they're back in a normal area. Called from area_enter.nss
// beside the appearance swap, so the name tracks the model exactly.
//
// Deliberately keyed off the area tag rather than area_enter's iCheck flag:
// that flag is also set for underwater and for airship/starship interiors,
// none of which put the PC in a ship model.
void ShipApplyNameForArea(object oPC, string sAreaTag)
{
    if (iShipNameRename != 1) { return; }   // see the header, and TASK-33
    string sToolTag = ShipToolForArea(sAreaTag);
    if (sToolTag == "")
    {
        // Only clear if we were the ones who set it, so this never fights
        // another system that renamed the PC for its own reasons.
        if (GetLocalInt(oPC, SHIPNAME_VAR) == 1)
        {
            DeleteLocalInt(oPC, SHIPNAME_VAR);
            SetName(oPC, "");
        }
        return;
    }
    string sName = ShipNameOf(oPC, sToolTag);
    if (sName == "") { return; }
    SetName(oPC, sName);
    SetLocalInt(oPC, SHIPNAME_VAR, 1);
}

// The window body: what this ship is, what it's called, and a field to rename
// it. Rebuilt on every refresh through the "_window_" group root.
json ShipNamePage(object oPC)
{
    object oTool = GetLocalObject(oPC, SHIPNAME_PCTOOL);
    string sToolTag = GetTag(oTool);
    string sKind = ShipKindLabel(sToolTag);
    string sName = GetLocalString(oTool, SHIPNAME_VAR);
    string sShown = (sName == "") ? "(unnamed)" : sName;

    json jList = JsonArray();
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiLabel(JsonString("Your " + sKind), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), 360.0), 32.0));
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiLabel(JsonString("Currently: " + sShown), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), 360.0), 28.0));
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiText(JsonString("While you are at the helm this name replaces your own, so other players see the ship rather than you. It travels with the ship, not with the character."), FALSE, NUI_SCROLLBARS_NONE), 360.0), 64.0));
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiTextEdit(JsonString("Name your " + sKind), NuiBind(SHIPNAME_BIND), SHIPNAME_MAXLEN, FALSE), 360.0), 34.0));

    json jButtons = JsonArray();
    jButtons = JsonArrayInsert(jButtons, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Save name")), SHIPNAME_SAVE), 120.0), 32.0));
    jButtons = JsonArrayInsert(jButtons, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Clear name")), SHIPNAME_CLEAR), 120.0), 32.0));
    jList = JsonArrayInsert(jList, NuiHeight(NuiRow(jButtons), 40.0));

    return NuiCol(jList);
}

// Open the rename window for one of oPC's ship tools.
void ShipNameOpen(object oPC, object oTool)
{
    if (!GetIsObjectValid(oTool)) { return; }
    SetLocalObject(oPC, SHIPNAME_PCTOOL, oTool);

    string sKind = ShipKindLabel(GetTag(oTool));
    json jWin = NuiWindow(ShipNamePage(oPC), JsonString("Ship - " + sKind), NuiRect(-1.0, -1.0, 400.0, 300.0), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    int nTok = NuiCreate(oPC, jWin, SHIPNAME_WINDOW, SHIPNAME_EVENT);
    // Prefill the field with the current name so editing beats retyping.
    NuiSetBind(oPC, nTok, SHIPNAME_BIND, JsonString(GetLocalString(oTool, SHIPNAME_VAR)));
}

// Commit whatever is in the field. sNewName=="" clears the ship's name.
// Returns TRUE if anything changed, so the caller can refresh the page.
int ShipNameCommit(object oPC, string sNewName)
{
    object oTool = GetLocalObject(oPC, SHIPNAME_PCTOOL);
    if (!GetIsObjectValid(oTool)) { return FALSE; }

    if (sNewName == "")
    {
        DeleteLocalString(oTool, SHIPNAME_VAR);
        FloatingTextStringOnCreature("Your " + ShipKindLabel(GetTag(oTool)) + " is unnamed again.", oPC, FALSE);
    }
    else
    {
        SetLocalString(oTool, SHIPNAME_VAR, sNewName);
        FloatingTextStringOnCreature("Your " + ShipKindLabel(GetTag(oTool)) + " is now the " + sNewName + ".", oPC, FALSE);
    }

    // If the player is already in this ship's element, show the change at once
    // rather than waiting for them to leave and come back.
    ShipApplyNameForArea(oPC, GetTag(GetArea(oPC)));
    return TRUE;
}
