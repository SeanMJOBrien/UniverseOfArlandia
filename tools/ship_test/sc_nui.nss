// sc_nui - "Ship Orders" window for the ship combat prototype.
// ---
// A map of the bay (drawn from the ships' cells), the player's controls and a
// battle log. The window only writes orders onto the ship; sc_inc resolves
// them. Events are handled by sc_nui_event.

#include "nw_inc_nui"
#include "sc_inc"

const string SCNUI_WINDOW = "sc_orders";
const string SCNUI_EVENT = "sc_nui_event";
const string SCNUI_MAP = "scmap";
const string SCNUI_STATUS = "scstatus";
const string SCNUI_LOG = "sclog";
const string SCNUI_PILOT = "scpilot";
const string SCNUI_SPEED = "scspeed";
const string SCNUI_TURN = "scturn";
const string SCNUI_FIRE1 = "scfire1";
const string SCNUI_FIRE2 = "scfire2";
const string SCNUI_TARGET = "sctarget";
const string SCNUI_READY = "scready";
const string SCNUI_END = "scend";
const string SCNUI_PARTY = "sc_pm_";     // PC locals: party member by combo value

const float SCNUI_MAP_SIZE = 300.0;      // pixels; the map is square
const float SCNUI_CONTROL_WIDTH = 270.0;
const float SCNUI_ROW_HEIGHT = 30.0;

// Map

float ScRad(float fDegrees)
{
    return fDegrees * 0.0174533;
}

json ScUiRect(json jList, int nR, int nG, int nB, float fX, float fY, float fW, float fH)
{
    json jPoints = JsonArray();
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX));      jPoints = JsonArrayInsert(jPoints, JsonFloat(fY));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX + fW)); jPoints = JsonArrayInsert(jPoints, JsonFloat(fY));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX + fW)); jPoints = JsonArrayInsert(jPoints, JsonFloat(fY + fH));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX));      jPoints = JsonArrayInsert(jPoints, JsonFloat(fY + fH));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX));      jPoints = JsonArrayInsert(jPoints, JsonFloat(fY));
    return JsonArrayInsert(jList, NuiDrawListPolyLine(JsonBool(TRUE), NuiColor(nR, nG, nB), JsonBool(TRUE), JsonFloat(1.0), jPoints));
}

json ScUiGridLine(json jList, float fX1, float fY1, float fX2, float fY2)
{
    return JsonArrayInsert(jList, NuiDrawListLine(JsonBool(TRUE), NuiColor(120, 150, 175, 90), JsonFloat(1.0),
        NuiVec(fX1, fY1), NuiVec(fX2, fY2)));
}

// Screen position of a cell centre.
float ScUiX(int nCX) { float fCell = SCNUI_MAP_SIZE / SC_CELLS; return (nCX + 0.5) * fCell; }
float ScUiY(int nCY) { float fCell = SCNUI_MAP_SIZE / SC_CELLS; return SCNUI_MAP_SIZE - (nCY + 0.5) * fCell; }

// The draw list itself cannot be bound, so the map is a fixed list: static items for
// the sea, shore and grid, and for each ship a hull outline, a label and a target line
// whose points, colour, rectangle and text are bound and pushed by ScUiPushMap.
string ScUiBind(string sName, int nShip)
{
    return "sc" + sName + IntToString(nShip);
}

json ScUiMapList()
{
    float fCell = SCNUI_MAP_SIZE / SC_CELLS;
    json jList = JsonArray();
    jList = ScUiRect(jList, 24, 52, 84, 0.0, 0.0, SCNUI_MAP_SIZE, SCNUI_MAP_SIZE);                              // sea
    jList = ScUiRect(jList, 96, 86, 50, 0.0, SCNUI_MAP_SIZE - SC_SEA_MIN_Y * fCell, SCNUI_MAP_SIZE, SC_SEA_MIN_Y * fCell); // shore
    int i;
    for (i = 0; i <= SC_CELLS; i += 2)
    {
        jList = ScUiGridLine(jList, i * fCell, 0.0, i * fCell, SCNUI_MAP_SIZE);
        jList = ScUiGridLine(jList, 0.0, i * fCell, SCNUI_MAP_SIZE, i * fCell);
    }
    jList = JsonArrayInsert(jList, NuiDrawListLine(NuiBind("sctle"), NuiColor(255, 220, 90, 160), JsonFloat(1.0),
        NuiBind("scta"), NuiBind("sctb")));
    for (i = 1; i <= SC_SHIPS; i++)
    {
        jList = JsonArrayInsert(jList, NuiDrawListPolyLine(JsonBool(TRUE), NuiBind(ScUiBind("col", i)), JsonBool(TRUE),
            JsonFloat(2.0), NuiBind(ScUiBind("pts", i))));
        jList = JsonArrayInsert(jList, NuiDrawListText(JsonBool(TRUE), NuiColor(240, 240, 240),
            NuiBind(ScUiBind("lr", i)), NuiBind(ScUiBind("lt", i))));
    }
    return jList;
}

void ScUiPushShip(object oPC, int nToken, int nShip)
{
    object oShip = ScShip(nShip);
    float fCell = SCNUI_MAP_SIZE / SC_CELLS;
    float fX = ScUiX(ScCX(oShip));
    float fY = ScUiY(ScCY(oShip));
    float fAngle = ScHead(oShip) * 45.0;
    int nR = 70; int nG = 130; int nB = 230;
    if (ScSide(oShip) == 2) { nR = 220; nG = 70; nB = 60; }
    if (!ScIsLive(oShip)) { nR = 110; nG = 110; nB = 110; }
    float fTipA = ScRad(fAngle);
    float fLeftA = ScRad(fAngle + 140.0);
    float fRightA = ScRad(fAngle - 140.0);
    json jPoints = JsonArray();
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX + 0.75 * fCell * cos(fTipA)));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fY - 0.75 * fCell * sin(fTipA)));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX + 0.55 * fCell * cos(fLeftA)));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fY - 0.55 * fCell * sin(fLeftA)));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX + 0.55 * fCell * cos(fRightA)));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fY - 0.55 * fCell * sin(fRightA)));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fX + 0.75 * fCell * cos(fTipA)));
    jPoints = JsonArrayInsert(jPoints, JsonFloat(fY - 0.75 * fCell * sin(fTipA)));
    NuiSetBind(oPC, nToken, ScUiBind("pts", nShip), jPoints);
    NuiSetBind(oPC, nToken, ScUiBind("col", nShip), NuiColor(nR, nG, nB));
    NuiSetBind(oPC, nToken, ScUiBind("lr", nShip), NuiRect(fX - 22.0, fY + 0.8 * fCell, 90.0, 16.0));
    NuiSetBind(oPC, nToken, ScUiBind("lt", nShip), JsonString(ScName(oShip) + " " + IntToString(ScClamp(GetLocalInt(oShip, "sc_hull"), 0, 999))));
}

void ScUiPushMap(object oPC, int nToken)
{
    int i;
    for (i = 1; i <= SC_SHIPS; i++) ScUiPushShip(oPC, nToken, i);
    object oPlayer = ScShip(1);
    object oTarget = GetLocalObject(oPlayer, "sc_o_tgt");
    int bLine = ScIsLive(oPlayer) && ScIsLive(oTarget);
    NuiSetBind(oPC, nToken, "sctle", JsonBool(bLine));
    if (bLine)
    {
        NuiSetBind(oPC, nToken, "scta", NuiVec(ScUiX(ScCX(oPlayer)), ScUiY(ScCY(oPlayer))));
        NuiSetBind(oPC, nToken, "sctb", NuiVec(ScUiX(ScCX(oTarget)), ScUiY(ScCY(oTarget))));
    }
}

// Window layout

json ScUiRow(string sLabel, json jElement)
{
    json jRow = JsonArray();
    jRow = JsonArrayInsert(jRow, NuiWidth(NuiLabel(JsonString(sLabel), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 70.0));
    jRow = JsonArrayInsert(jRow, jElement);
    return NuiHeight(NuiRow(jRow), SCNUI_ROW_HEIGHT);
}

json ScUiPartyEntries(object oPC)
{
    json jEntries = JsonArray();
    int nCount = 0;
    SetLocalObject(oPC, SCNUI_PARTY + "0", oPC);
    jEntries = JsonArrayInsert(jEntries, NuiComboEntry(GetName(oPC) + " (you)", 0));
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        SetLocalObject(oPC, SCNUI_PARTY + IntToString(i), oHench);
        jEntries = JsonArrayInsert(jEntries, NuiComboEntry(GetName(oHench), i));
        i++;
        oHench = GetHenchman(oPC, i);
    }
    return jEntries;
}

json ScUiLayout(object oPC)
{
    json jSpeed = JsonArray();
    jSpeed = JsonArrayInsert(jSpeed, NuiComboEntry("Hold position", 0));
    jSpeed = JsonArrayInsert(jSpeed, NuiComboEntry("1 square", 1));
    jSpeed = JsonArrayInsert(jSpeed, NuiComboEntry("2 squares", 2));
    jSpeed = JsonArrayInsert(jSpeed, NuiComboEntry("3 squares", 3));
    jSpeed = JsonArrayInsert(jSpeed, NuiComboEntry("4 squares", 4));
    json jTurn = JsonArray();
    jTurn = JsonArrayInsert(jTurn, NuiComboEntry("Turn 90 degrees to starboard", 0));
    jTurn = JsonArrayInsert(jTurn, NuiComboEntry("Turn 45 degrees to starboard", 1));
    jTurn = JsonArrayInsert(jTurn, NuiComboEntry("Hold course", 2));
    jTurn = JsonArrayInsert(jTurn, NuiComboEntry("Turn 45 degrees to port", 3));
    jTurn = JsonArrayInsert(jTurn, NuiComboEntry("Turn 90 degrees to port", 4));
    json jTarget = JsonArray();
    jTarget = JsonArrayInsert(jTarget, NuiComboEntry("Skiff", 2));
    jTarget = JsonArrayInsert(jTarget, NuiComboEntry("Reaver", 3));

    json jControls = JsonArray();
    jControls = JsonArrayInsert(jControls, NuiHeight(NuiText(NuiBind(SCNUI_STATUS), TRUE, NUI_SCROLLBARS_NONE), 96.0));
    jControls = JsonArrayInsert(jControls, ScUiRow("Pilot", NuiCombo(ScUiPartyEntries(oPC), NuiBind(SCNUI_PILOT))));
    jControls = JsonArrayInsert(jControls, ScUiRow("Move", NuiCombo(jSpeed, NuiBind(SCNUI_SPEED))));
    jControls = JsonArrayInsert(jControls, ScUiRow("Turn", NuiCombo(jTurn, NuiBind(SCNUI_TURN))));
    jControls = JsonArrayInsert(jControls, ScUiRow("Target", NuiCombo(jTarget, NuiBind(SCNUI_TARGET))));
    jControls = JsonArrayInsert(jControls, NuiHeight(NuiCheck(JsonString("Fire port guns"), NuiBind(SCNUI_FIRE1)), SCNUI_ROW_HEIGHT));
    jControls = JsonArrayInsert(jControls, NuiHeight(NuiCheck(JsonString("Fire starboard guns"), NuiBind(SCNUI_FIRE2)), SCNUI_ROW_HEIGHT));
    json jButtons = JsonArray();
    jButtons = JsonArrayInsert(jButtons, NuiId(NuiButton(JsonString("Ready")), SCNUI_READY));
    jButtons = JsonArrayInsert(jButtons, NuiId(NuiButton(JsonString("End battle")), SCNUI_END));
    jControls = JsonArrayInsert(jControls, NuiHeight(NuiRow(jButtons), 36.0));

    json jMap = NuiDrawList(NuiSpacer(), JsonInt(1), ScUiMapList());
    jMap = NuiWidth(NuiHeight(jMap, SCNUI_MAP_SIZE), SCNUI_MAP_SIZE);

    json jTop = JsonArray();
    jTop = JsonArrayInsert(jTop, jMap);
    jTop = JsonArrayInsert(jTop, NuiWidth(NuiCol(jControls), SCNUI_CONTROL_WIDTH));

    json jCol = JsonArray();
    jCol = JsonArrayInsert(jCol, NuiHeight(NuiRow(jTop), SCNUI_MAP_SIZE + 6.0));
    jCol = JsonArrayInsert(jCol, NuiHeight(NuiText(NuiBind(SCNUI_LOG), TRUE, NUI_SCROLLBARS_AUTO), 150.0));
    return NuiCol(jCol);
}

// Status text and binds

string ScUiStatus()
{
    object oMod = GetModule();
    object oPlayer = ScShip(1);
    string sText;
    int nPhase = GetLocalInt(oMod, SC_PHASE);
    if (nPhase == 1) sText = "Round " + IntToString(GetLocalInt(oMod, SC_ROUND)) + ": plot orders, " + IntToString(GetLocalInt(oMod, SC_TIME)) + " s left";
    else if (nPhase == 2) sText = "Round " + IntToString(GetLocalInt(oMod, SC_ROUND)) + ": ships are moving and firing";
    else if (nPhase == 3) sText = "The battle is over";
    else sText = "No battle";
    sText += "\n" + ScName(oPlayer) + ": hull " + IntToString(GetLocalInt(oPlayer, "sc_hull")) + "/" + IntToString(GetLocalInt(oPlayer, "sc_hullmax"))
           + ", up to " + IntToString(GetLocalInt(oPlayer, "sc_speed")) + " squares, turn " + IntToString(GetLocalInt(oPlayer, "sc_turn") * 45) + " degrees";
    sText += "\nGuns " + IntToString(GetLocalInt(oPlayer, "sc_guns")) + " a side, range " + IntToString(GetLocalInt(oPlayer, "sc_range"));
    if (GetLocalInt(oPlayer, "sc_reload1")) sText += "; port guns reloading";
    if (GetLocalInt(oPlayer, "sc_reload2")) sText += "; starboard guns reloading";
    object oPilot = GetLocalObject(oPlayer, "sc_pilot");
    if (GetIsObjectValid(oPilot) && !GetIsPC(oPilot)) sText += "\n" + GetName(oPilot) + " pilots the ship.";
    return sText;
}

void ScUiPush(object oPC, int nToken)
{
    object oPlayer = ScShip(1);
    ScUiPushMap(oPC, nToken);
    NuiSetBind(oPC, nToken, SCNUI_STATUS, JsonString(ScUiStatus()));
    NuiSetBind(oPC, nToken, SCNUI_LOG, JsonString(GetLocalString(GetModule(), SC_LOG)));
    NuiSetBind(oPC, nToken, SCNUI_SPEED, JsonInt(GetLocalInt(oPlayer, "sc_o_speed")));
    NuiSetBind(oPC, nToken, SCNUI_TURN, JsonInt(GetLocalInt(oPlayer, "sc_o_turn") + 2));
    NuiSetBind(oPC, nToken, SCNUI_FIRE1, JsonBool(GetLocalInt(oPlayer, "sc_o_f1")));
    NuiSetBind(oPC, nToken, SCNUI_FIRE2, JsonBool(GetLocalInt(oPlayer, "sc_o_f2")));
    object oTarget = GetLocalObject(oPlayer, "sc_o_tgt");
    int nTarget = 2;
    if (oTarget == ScShip(3)) nTarget = 3;
    NuiSetBind(oPC, nToken, SCNUI_TARGET, JsonInt(nTarget));
}

void ScUiOpen(object oPC)
{
    int nOld = NuiFindWindow(oPC, SCNUI_WINDOW);
    if (nOld) NuiDestroy(oPC, nOld);
    json jWin = NuiWindow(ScUiLayout(oPC), JsonString("Ship Orders"),
        NuiRect(-1.0, -1.0, 620.0, 520.0), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    int nToken = NuiCreate(oPC, jWin, SCNUI_WINDOW, SCNUI_EVENT);
    NuiSetBind(oPC, nToken, SCNUI_PILOT, JsonInt(0));
    ScUiPush(oPC, nToken);
    NuiSetBindWatch(oPC, nToken, SCNUI_PILOT, TRUE);
    NuiSetBindWatch(oPC, nToken, SCNUI_SPEED, TRUE);
    NuiSetBindWatch(oPC, nToken, SCNUI_TURN, TRUE);
    NuiSetBindWatch(oPC, nToken, SCNUI_TARGET, TRUE);
    NuiSetBindWatch(oPC, nToken, SCNUI_FIRE1, TRUE);
    NuiSetBindWatch(oPC, nToken, SCNUI_FIRE2, TRUE);
}

void ScUiRefresh(object oPC)
{
    int nToken = NuiFindWindow(oPC, SCNUI_WINDOW);
    if (nToken) ScUiPush(oPC, nToken);
}

// Orders from the window

void ScUiReadOrders(object oPC, int nToken)
{
    if (GetLocalInt(GetModule(), SC_PHASE) != 1) return;
    object oPlayer = ScShip(1);
    int bChanged = FALSE;
    object oPilot = GetLocalObject(oPC, SCNUI_PARTY + IntToString(JsonGetInt(NuiGetBind(oPC, nToken, SCNUI_PILOT))));
    if (!GetIsObjectValid(oPilot)) oPilot = oPC;
    if (oPilot != GetLocalObject(oPlayer, "sc_pilot"))
    {
        SetLocalObject(oPlayer, "sc_pilot", oPilot);
        ScLog(GetName(oPilot) + " takes the helm.");
        if (!GetIsPC(oPilot)) ScPlotAi(oPlayer, TRUE, FALSE);
        bChanged = TRUE;
    }
    else if (GetIsPC(oPilot))
    {
        int nSpeed = JsonGetInt(NuiGetBind(oPC, nToken, SCNUI_SPEED));
        int nTurn = JsonGetInt(NuiGetBind(oPC, nToken, SCNUI_TURN)) - 2;
        if (nSpeed != GetLocalInt(oPlayer, "sc_o_speed") || nTurn != GetLocalInt(oPlayer, "sc_o_turn")) bChanged = TRUE;
        SetLocalInt(oPlayer, "sc_o_speed", nSpeed);
        SetLocalInt(oPlayer, "sc_o_turn", nTurn);
    }
    int nFire1 = JsonGetInt(NuiGetBind(oPC, nToken, SCNUI_FIRE1));
    int nFire2 = JsonGetInt(NuiGetBind(oPC, nToken, SCNUI_FIRE2));
    object oTarget = ScShip(JsonGetInt(NuiGetBind(oPC, nToken, SCNUI_TARGET)));
    if (nFire1 != GetLocalInt(oPlayer, "sc_o_f1") || nFire2 != GetLocalInt(oPlayer, "sc_o_f2")
        || oTarget != GetLocalObject(oPlayer, "sc_o_tgt")) bChanged = TRUE;
    SetLocalInt(oPlayer, "sc_o_f1", nFire1);
    SetLocalInt(oPlayer, "sc_o_f2", nFire2);
    SetLocalObject(oPlayer, "sc_o_tgt", oTarget);
    if (bChanged) ScRefreshUi();
}
