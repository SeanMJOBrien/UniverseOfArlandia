// sc_inc - ship combat prototype: grid, ship state, orders and round resolution.
// ---
// Ships are placeables that never move. Each ship keeps its cell and heading in
// local variables and is shown at that cell with a visual transform, as
// inc_shiparrive.nss does for airships. One battle runs at a time on the module
// object. A round has two phases: plotting (every ship records orders, the player
// through the sc_nui window, others by ScPlotAi) and resolution (all ships move
// together step by step, then fire together).
//
// Grid: 20 x 20 cells of 5 metres. Heading is 0-7 in 45 degree steps, 0 = east,
// counter-clockwise (the engine convention). Cells below SC_SEA_MIN_Y are shore.

const int SC_SHIPS = 3;                 // sc_ship_1 is the player's, 2 and 3 are hostile
const int SC_CELLS = 20;
const float SC_CELL = 5.0;
const int SC_SEA_MIN_Y = 4;
const int SC_PLOT_SECONDS = 30;
const float SC_STEP_SECONDS = 1.5;      // time one grid step takes on screen
const float SC_ROUND_PAUSE = 3.0;       // pause between the fire phase and the next plot phase
const int SC_RAM_DAMAGE = 6;            // d6 to each ship in a collision
const int SC_LOG_LINES = 9;

const string SC_SHIP_TAG = "sc_ship_";
const string SC_ACTIVE = "sc_active";
const string SC_PHASE = "sc_phase";      // 0 idle, 1 plotting, 2 resolving, 3 finished
const string SC_ROUND = "sc_round";
const string SC_GEN = "sc_gen";          // bumped to cancel pending timers
const string SC_TIME = "sc_time";        // seconds left to plot
const string SC_PC = "sc_pc";
const string SC_LOG = "sc_log";
const string SC_RESULT = "sc_result";

// ---------------------------------------------------------------------------
// Grid helpers

int ScDX(int nHead)
{
    if (nHead == 0 || nHead == 1 || nHead == 7) return 1;
    if (nHead == 3 || nHead == 4 || nHead == 5) return -1;
    return 0;
}

int ScDY(int nHead)
{
    if (nHead == 1 || nHead == 2 || nHead == 3) return 1;
    if (nHead == 5 || nHead == 6 || nHead == 7) return -1;
    return 0;
}

int ScWrap(int nHead)
{
    return ((nHead % 8) + 8) % 8;
}

// Shortest turn from nFrom to nTo in the range -4..3 (positive = to port).
int ScTurnDiff(int nFrom, int nTo)
{
    int nDiff = ScWrap(nTo - nFrom);
    if (nDiff > 3) nDiff -= 8;
    return nDiff;
}

vector ScCellPos(int nCX, int nCY)
{
    return Vector((nCX + 0.5) * SC_CELL, (nCY + 0.5) * SC_CELL, 0.0);
}

location ScCellLoc(object oArea, int nCX, int nCY, float fZ = 0.5)
{
    vector vPos = ScCellPos(nCX, nCY);
    return Location(oArea, Vector(vPos.x, vPos.y, fZ), 0.0);
}

int ScClamp(int nValue, int nLow, int nHigh)
{
    if (nValue < nLow) return nLow;
    if (nValue > nHigh) return nHigh;
    return nValue;
}

// ---------------------------------------------------------------------------
// Ship state

object ScShip(int nIndex)
{
    return GetObjectByTag(SC_SHIP_TAG + IntToString(nIndex));
}

int ScIsLive(object oShip)
{
    return GetIsObjectValid(oShip) && !GetLocalInt(oShip, "sc_sunk");
}

int ScSide(object oShip) { return GetLocalInt(oShip, "sc_side"); }
int ScCX(object oShip) { return GetLocalInt(oShip, "sc_cx"); }
int ScCY(object oShip) { return GetLocalInt(oShip, "sc_cy"); }
int ScHead(object oShip) { return GetLocalInt(oShip, "sc_f"); }
string ScName(object oShip) { return GetLocalString(oShip, "sc_name"); }

// Distance in cells between two ships (straight line).
float ScDist(object oA, object oB)
{
    float fDX = IntToFloat(ScCX(oA) - ScCX(oB));
    float fDY = IntToFloat(ScCY(oA) - ScCY(oB));
    return sqrt(fDX * fDX + fDY * fDY);
}

// Bearing from oA to oB as a heading index 0-7.
int ScBearing(object oA, object oB)
{
    vector vDelta = Vector(IntToFloat(ScCX(oB) - ScCX(oA)), IntToFloat(ScCY(oB) - ScCY(oA)), 0.0);
    float fAngle = VectorToAngle(vDelta);
    return ScWrap(FloatToInt(fAngle / 45.0 + 0.5));
}

// Where oTarget lies relative to oShip's heading, -180..180 degrees
// (positive = port side, negative = starboard).
int ScRelAngle(object oShip, object oTarget)
{
    vector vDelta = Vector(IntToFloat(ScCX(oTarget) - ScCX(oShip)), IntToFloat(ScCY(oTarget) - ScCY(oShip)), 0.0);
    int nAngle = FloatToInt(VectorToAngle(vDelta)) - ScHead(oShip) * 45;
    while (nAngle > 180) nAngle -= 360;
    while (nAngle <= -180) nAngle += 360;
    return nAngle;
}

// nSide 1 = port guns, 2 = starboard guns. Each covers 90 degrees abeam.
int ScInArc(object oShip, object oTarget, int nSide)
{
    int nAngle = ScRelAngle(oShip, oTarget);
    if (nSide == 1) return nAngle >= 45 && nAngle <= 135;
    return nAngle <= -45 && nAngle >= -135;
}

int ScCanReach(object oShip, object oTarget, int nSide)
{
    if (!ScIsLive(oTarget) || ScSide(oTarget) == ScSide(oShip)) return FALSE;
    if (ScDist(oShip, oTarget) > IntToFloat(GetLocalInt(oShip, "sc_range")) + 0.01) return FALSE;
    return ScInArc(oShip, oTarget, nSide);
}

object ScNearestFoe(object oShip)
{
    object oBest = OBJECT_INVALID;
    float fBest = 999.0;
    int i;
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oOther = ScShip(i);
        if (!ScIsLive(oOther) || ScSide(oOther) == ScSide(oShip)) continue;
        float fDist = ScDist(oShip, oOther);
        if (fDist < fBest) { fBest = fDist; oBest = oOther; }
    }
    return oBest;
}

int ScCellTaken(int nCX, int nCY, object oExcept)
{
    int i;
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oOther = ScShip(i);
        if (oOther == oExcept || !ScIsLive(oOther)) continue;
        if (ScCX(oOther) == nCX && ScCY(oOther) == nCY) return TRUE;
    }
    return FALSE;
}

int ScLiveCount(int nSide)
{
    int nCount = 0;
    int i;
    for (i = 1; i <= SC_SHIPS; i++)
        if (ScIsLive(ScShip(i)) && ScSide(ScShip(i)) == nSide) nCount++;
    return nCount;
}

// ---------------------------------------------------------------------------
// Log and display

void ScLog(string sLine)
{
    object oMod = GetModule();
    string sLog = GetLocalString(oMod, SC_LOG);
    if (sLog != "") sLog += "\n";
    sLog += sLine;
    // keep the last SC_LOG_LINES lines
    int nLines = 1;
    int iPos = FindSubString(sLog, "\n");
    string sRest = sLog;
    while (iPos != -1)
    {
        nLines++;
        sRest = GetStringRight(sRest, GetStringLength(sRest) - iPos - 1);
        iPos = FindSubString(sRest, "\n");
    }
    while (nLines > SC_LOG_LINES)
    {
        iPos = FindSubString(sLog, "\n");
        sLog = GetStringRight(sLog, GetStringLength(sLog) - iPos - 1);
        nLines--;
    }
    SetLocalString(oMod, SC_LOG, sLog);
    object oPC = GetLocalObject(oMod, SC_PC);
    if (GetIsObjectValid(oPC)) SendMessageToPC(oPC, sLine);
}

void ScRefreshUi()
{
    object oPC = GetLocalObject(GetModule(), SC_PC);
    if (GetIsObjectValid(oPC)) ExecuteScript("sc_ui_refresh", oPC);
}

float ScYawOffset()
{
    return IntToFloat(GetLocalInt(GetModule(), "ship_yaw_offset"));
}

float ScScale()
{
    int nPct = GetLocalInt(GetModule(), "ship_scale_pct");
    if (nPct <= 0) nPct = 100;
    return nPct / 100.0;
}

// Show oShip at a cell and heading. fSeconds 0.0 jumps, otherwise it glides.
void ScShowAt(object oShip, int nCX, int nCY, int nHead, float fSeconds)
{
    if (!GetIsObjectValid(oShip)) return;
    vector vReal = GetPosition(oShip);
    vector vCell = ScCellPos(nCX, nCY);
    int nLerp = OBJECT_VISUAL_TRANSFORM_LERP_NONE;
    if (fSeconds > 0.0) nLerp = OBJECT_VISUAL_TRANSFORM_LERP_LINEAR;
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_X, vCell.x - vReal.x, nLerp, fSeconds);
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Y, vCell.y - vReal.y, nLerp, fSeconds);
    AssignCommand(oShip, SetFacing(nHead * 45.0 + ScYawOffset()));
}

// ---------------------------------------------------------------------------
// Ship set-up. n = 1 player's schooner, 2 sailboat, 3 galley.

void ScInitShip(object oShip, int nIndex)
{
    if (!GetIsObjectValid(oShip)) return;
    vector vPos = GetPosition(oShip);
    int nHead = ScWrap(FloatToInt(GetFacing(oShip) / 45.0 + 0.5));
    if (!GetLocalInt(oShip, "sc_home_set"))
    {
        SetLocalInt(oShip, "sc_home_set", 1);
        SetLocalInt(oShip, "sc_hx", FloatToInt(vPos.x / SC_CELL));
        SetLocalInt(oShip, "sc_hy", FloatToInt(vPos.y / SC_CELL));
        SetLocalInt(oShip, "sc_hf", nHead);
    }
    int nHull = 25; int nSpeed = 4; int nTurn = 2; int nGuns = 1; int nRange = 5; int nAr = 13; int nAtk = 3;
    string sName = "Raider";
    int nSide = 2;
    if (nIndex == 1) { nHull = 40; nSpeed = 3; nTurn = 2; nGuns = 2; nRange = 6; nAr = 12; nAtk = 4; sName = "Gull"; nSide = 1; }
    if (nIndex == 3) { nHull = 45; nSpeed = 2; nTurn = 1; nGuns = 3; nRange = 6; nAr = 11; nAtk = 3; sName = "Reaver"; }
    if (nIndex == 2) { sName = "Skiff"; }
    SetLocalInt(oShip, "sc_side", nSide);
    SetLocalString(oShip, "sc_name", sName);
    SetLocalInt(oShip, "sc_hullmax", nHull);
    SetLocalInt(oShip, "sc_hull", nHull);
    SetLocalInt(oShip, "sc_speed", nSpeed);
    SetLocalInt(oShip, "sc_turn", nTurn);
    SetLocalInt(oShip, "sc_guns", nGuns);
    SetLocalInt(oShip, "sc_range", nRange);
    SetLocalInt(oShip, "sc_ar", nAr);
    SetLocalInt(oShip, "sc_atk", nAtk);
    SetLocalInt(oShip, "sc_cx", GetLocalInt(oShip, "sc_hx"));
    SetLocalInt(oShip, "sc_cy", GetLocalInt(oShip, "sc_hy"));
    SetLocalInt(oShip, "sc_f", GetLocalInt(oShip, "sc_hf"));
    DeleteLocalInt(oShip, "sc_sunk");
    DeleteLocalInt(oShip, "sc_reload1");
    DeleteLocalInt(oShip, "sc_reload2");
    SetLocalInt(oShip, "sc_o_speed", 0);
    SetLocalInt(oShip, "sc_o_turn", 0);
    SetLocalInt(oShip, "sc_o_f1", 0);
    SetLocalInt(oShip, "sc_o_f2", 0);
    DeleteLocalObject(oShip, "sc_o_tgt");
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_SCALE, ScScale());
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 0.0);
    ScShowAt(oShip, GetLocalInt(oShip, "sc_cx"), GetLocalInt(oShip, "sc_cy"), GetLocalInt(oShip, "sc_f"), 0.0);
}

void ScInitAll()
{
    int i;
    for (i = 1; i <= SC_SHIPS; i++) ScInitShip(ScShip(i), i);
}

// ---------------------------------------------------------------------------
// Orders

// Computer-plotted orders for a hostile ship, or the player's ship when an NPC pilots it.
// bMovement FALSE leaves speed and turn alone.
void ScPlotAi(object oShip, int bMovement = TRUE, int bGuns = TRUE)
{
    object oFoe = ScNearestFoe(oShip);
    if (!GetIsObjectValid(oFoe))
    {
        SetLocalInt(oShip, "sc_o_speed", 0);
        SetLocalInt(oShip, "sc_o_turn", 0);
        return;
    }
    if (bMovement)
    {
        int nHead = ScHead(oShip);
        int nBearing = ScBearing(oShip, oFoe);
        int nWant = nBearing;
        int nRange = GetLocalInt(oShip, "sc_range");
        float fDist = ScDist(oShip, oFoe);
        if (fDist <= IntToFloat(nRange))
        {
            // in range: come alongside, whichever broadside is nearer
            int nPort = ScWrap(nBearing - 2);
            int nStbd = ScWrap(nBearing + 2);
            if (abs(ScTurnDiff(nHead, nPort)) <= abs(ScTurnDiff(nHead, nStbd))) nWant = nPort;
            else nWant = nStbd;
        }
        int nTurn = ScClamp(ScTurnDiff(nHead, nWant), -GetLocalInt(oShip, "sc_turn"), GetLocalInt(oShip, "sc_turn"));
        int nSpeed = GetLocalInt(oShip, "sc_speed");
        if (fDist <= IntToFloat(nRange)) nSpeed = 1;
        SetLocalInt(oShip, "sc_o_turn", nTurn);
        SetLocalInt(oShip, "sc_o_speed", nSpeed);
    }
    if (bGuns)
    {
        SetLocalInt(oShip, "sc_o_f1", 1);
        SetLocalInt(oShip, "sc_o_f2", 1);
        SetLocalObject(oShip, "sc_o_tgt", oFoe);
    }
}

// ---------------------------------------------------------------------------
// Resolution

// Records a ship's position after step nStep, for the animation.
void ScSnap(object oShip, int nStep)
{
    string sKey = IntToString(nStep);
    SetLocalInt(oShip, "sc_s_cx" + sKey, ScCX(oShip));
    SetLocalInt(oShip, "sc_s_cy" + sKey, ScCY(oShip));
    SetLocalInt(oShip, "sc_s_f" + sKey, ScHead(oShip));
}

void ScAnimStep(object oShip, int nStep)
{
    string sKey = IntToString(nStep);
    ScShowAt(oShip, GetLocalInt(oShip, "sc_s_cx" + sKey), GetLocalInt(oShip, "sc_s_cy" + sKey),
             GetLocalInt(oShip, "sc_s_f" + sKey), SC_STEP_SECONDS);
}

void ScEndBattle(int nResult);
void ScBeginRound();

void ScSink(object oShip)
{
    SetLocalInt(oShip, "sc_sunk", 1);
    ScLog(ScName(oShip) + " sinks.");
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, -4.0, OBJECT_VISUAL_TRANSFORM_LERP_LINEAR, 4.0);
}

void ScHitEffect(object oShip, int nVfx)
{
    object oArea = GetArea(oShip);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(nVfx), ScCellLoc(oArea, ScCX(oShip), ScCY(oShip)));
}

// Fire phase: all broadsides are worked out first, then damage is applied together.
void ScFirePhase()
{
    int i;
    int nSide;
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oShip = ScShip(i);
        DeleteLocalInt(oShip, "sc_dmg");
    }
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oShip = ScShip(i);
        if (!ScIsLive(oShip)) continue;
        for (nSide = 1; nSide <= 2; nSide++)
        {
            string sSide = IntToString(nSide);
            int nWanted = GetLocalInt(oShip, "sc_o_f" + sSide);
            int nLoaded = !GetLocalInt(oShip, "sc_reload" + sSide);
            DeleteLocalInt(oShip, "sc_reload" + sSide);
            if (!nWanted || !nLoaded) continue;

            object oTarget = GetLocalObject(oShip, "sc_o_tgt");
            if (!ScCanReach(oShip, oTarget, nSide))
            {
                // fall back to the nearest foe the guns can reach
                oTarget = OBJECT_INVALID;
                float fBest = 999.0;
                int j;
                for (j = 1; j <= SC_SHIPS; j++)
                {
                    object oOther = ScShip(j);
                    if (!ScCanReach(oShip, oOther, nSide)) continue;
                    if (ScDist(oShip, oOther) < fBest) { fBest = ScDist(oShip, oOther); oTarget = oOther; }
                }
            }
            if (!GetIsObjectValid(oTarget)) continue;

            SetLocalInt(oShip, "sc_reload" + sSide, 1);
            string sSideName = "port";
            if (nSide == 2) sSideName = "starboard";
            ScHitEffect(oShip, VFX_FNF_SMOKE_PUFF);
            int nHits = 0;
            int nTotal = 0;
            int nGun;
            for (nGun = 0; nGun < GetLocalInt(oShip, "sc_guns"); nGun++)
            {
                int nRoll = d20();
                if (nRoll == 1) continue;
                if (nRoll == 20 || nRoll + GetLocalInt(oShip, "sc_atk") >= GetLocalInt(oTarget, "sc_ar"))
                {
                    int nDmg = d6() + 2;
                    if (nRoll == 20) nDmg *= 2;
                    nHits++;
                    nTotal += nDmg;
                }
            }
            SetLocalInt(oTarget, "sc_dmg", GetLocalInt(oTarget, "sc_dmg") + nTotal);
            ScLog(ScName(oShip) + " fires " + sSideName + " at " + ScName(oTarget) + ": " + IntToString(nHits) + " of "
                  + IntToString(GetLocalInt(oShip, "sc_guns")) + " hit, " + IntToString(nTotal) + " damage.");
            if (nHits > 0) ScHitEffect(oTarget, VFX_IMP_FLAME_M);
            else ScHitEffect(oTarget, VFX_IMP_HEAD_ACID);
        }
    }
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oShip = ScShip(i);
        int nDmg = GetLocalInt(oShip, "sc_dmg");
        DeleteLocalInt(oShip, "sc_dmg");
        if (!ScIsLive(oShip) || nDmg <= 0) continue;
        SetLocalInt(oShip, "sc_hull", GetLocalInt(oShip, "sc_hull") - nDmg);
        if (GetLocalInt(oShip, "sc_hull") <= 0) ScSink(oShip);
    }
    ScRefreshUi();

    if (!ScIsLive(ScShip(1))) { DelayCommand(2.0, ScEndBattle(-1)); return; }
    if (ScLiveCount(2) == 0) { DelayCommand(2.0, ScEndBattle(1)); return; }
    DelayCommand(SC_ROUND_PAUSE, ScBeginRound());
}

// Movement phase: works out every ship's path, then schedules the animation and the fire phase.
void ScResolve()
{
    object oMod = GetModule();
    if (GetLocalInt(oMod, SC_PHASE) != 1) return;
    SetLocalInt(oMod, SC_PHASE, 2);
    SetLocalInt(oMod, SC_GEN, GetLocalInt(oMod, SC_GEN) + 1);
    ScLog("Round " + IntToString(GetLocalInt(oMod, SC_ROUND)) + ": ships move.");

    int nMaxSteps = 0;
    int i;
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oShip = ScShip(i);
        if (!ScIsLive(oShip)) continue;
        // turn first, within the ship's turn rate
        int nTurn = ScClamp(GetLocalInt(oShip, "sc_o_turn"), -GetLocalInt(oShip, "sc_turn"), GetLocalInt(oShip, "sc_turn"));
        SetLocalInt(oShip, "sc_f", ScWrap(ScHead(oShip) + nTurn));
        int nSpeed = ScClamp(GetLocalInt(oShip, "sc_o_speed"), 0, GetLocalInt(oShip, "sc_speed"));
        SetLocalInt(oShip, "sc_steps", nSpeed);
        if (nSpeed > nMaxSteps) nMaxSteps = nSpeed;
        ScSnap(oShip, 0);
    }
    // the order ships move in rotates each round, so no ship always gets the gap
    int nStart = GetLocalInt(oMod, SC_ROUND) % SC_SHIPS;
    int nStep;
    int nTurnOrder;
    for (nStep = 1; nStep <= nMaxSteps; nStep++)
    {
        for (nTurnOrder = 0; nTurnOrder < SC_SHIPS; nTurnOrder++)
        {
            object oShip = ScShip(1 + (nStart + nTurnOrder) % SC_SHIPS);
            if (!ScIsLive(oShip)) continue;
            if (nStep <= GetLocalInt(oShip, "sc_steps"))
            {
                int nNX = ScCX(oShip) + ScDX(ScHead(oShip));
                int nNY = ScCY(oShip) + ScDY(ScHead(oShip));
                if (nNX < 0 || nNX >= SC_CELLS || nNY < SC_SEA_MIN_Y || nNY >= SC_CELLS)
                {
                    SetLocalInt(oShip, "sc_steps", 0);
                    ScLog(ScName(oShip) + " turns back at the edge of the bay.");
                }
                else if (ScCellTaken(nNX, nNY, oShip))
                {
                    SetLocalInt(oShip, "sc_steps", 0);
                    int j;
                    for (j = 1; j <= SC_SHIPS; j++)
                    {
                        object oOther = ScShip(j);
                        if (ScIsLive(oOther) && ScCX(oOther) == nNX && ScCY(oOther) == nNY)
                        {
                            SetLocalInt(oShip, "sc_dmg_ram", GetLocalInt(oShip, "sc_dmg_ram") + d6());
                            SetLocalInt(oOther, "sc_dmg_ram", GetLocalInt(oOther, "sc_dmg_ram") + d6());
                            ScLog(ScName(oShip) + " collides with " + ScName(oOther) + ".");
                        }
                    }
                }
                else
                {
                    SetLocalInt(oShip, "sc_cx", nNX);
                    SetLocalInt(oShip, "sc_cy", nNY);
                }
            }
        }
        for (i = 1; i <= SC_SHIPS; i++)
            if (ScIsLive(ScShip(i))) ScSnap(ScShip(i), nStep);
    }
    // collisions
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oShip = ScShip(i);
        int nRam = GetLocalInt(oShip, "sc_dmg_ram");
        DeleteLocalInt(oShip, "sc_dmg_ram");
        if (nRam > 0 && ScIsLive(oShip))
        {
            SetLocalInt(oShip, "sc_hull", GetLocalInt(oShip, "sc_hull") - nRam);
            if (GetLocalInt(oShip, "sc_hull") <= 0) ScSink(oShip);
        }
    }
    // animation: step 0 is the turn, steps 1.. are the moves
    for (nStep = 0; nStep <= nMaxSteps; nStep++)
        for (i = 1; i <= SC_SHIPS; i++)
            if (ScIsLive(ScShip(i))) DelayCommand(nStep * SC_STEP_SECONDS, ScAnimStep(ScShip(i), nStep));
    ScRefreshUi();
    DelayCommand((nMaxSteps + 1) * SC_STEP_SECONDS, ScFirePhase());
}

// ---------------------------------------------------------------------------
// Round control

void ScTick(int nGen, int nLeft)
{
    object oMod = GetModule();
    if (nGen != GetLocalInt(oMod, SC_GEN) || GetLocalInt(oMod, SC_PHASE) != 1) return;
    SetLocalInt(oMod, SC_TIME, nLeft);
    ScRefreshUi();
    if (nLeft <= 0) { ScResolve(); return; }
    DelayCommand(1.0, ScTick(nGen, nLeft - 1));
}

void ScBeginRound()
{
    object oMod = GetModule();
    if (!GetLocalInt(oMod, SC_ACTIVE)) return;
    SetLocalInt(oMod, SC_ROUND, GetLocalInt(oMod, SC_ROUND) + 1);
    SetLocalInt(oMod, SC_PHASE, 1);
    SetLocalInt(oMod, SC_GEN, GetLocalInt(oMod, SC_GEN) + 1);
    int i;
    for (i = 1; i <= SC_SHIPS; i++)
    {
        object oShip = ScShip(i);
        if (!ScIsLive(oShip)) continue;
        SetLocalInt(oShip, "sc_o_turn", 0);
        SetLocalInt(oShip, "sc_o_f1", 0);
        SetLocalInt(oShip, "sc_o_f2", 0);
        if (i != 1) ScPlotAi(oShip);
    }
    // an NPC pilot steers the player's ship; the guns stay with the player
    object oPilot = GetLocalObject(ScShip(1), "sc_pilot");
    if (GetIsObjectValid(oPilot) && !GetIsPC(oPilot)) ScPlotAi(ScShip(1), TRUE, FALSE);
    ScLog("Round " + IntToString(GetLocalInt(oMod, SC_ROUND)) + ": plot your orders.");
    ScTick(GetLocalInt(oMod, SC_GEN), SC_PLOT_SECONDS);
}

// Camera back on the player and the player back on the shore start point.
void ScReturnToShore(object oPC)
{
    AttachCamera(oPC, oPC);
    location lShore = Location(GetArea(oPC), Vector(50.0, 6.0, 0.0), 90.0);
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lShore));
}

void ScEndBattle(int nResult)
{
    object oMod = GetModule();
    SetLocalInt(oMod, SC_ACTIVE, 0);
    SetLocalInt(oMod, SC_PHASE, 3);
    SetLocalInt(oMod, SC_GEN, GetLocalInt(oMod, SC_GEN) + 1);
    SetLocalInt(oMod, SC_RESULT, nResult);
    if (nResult > 0) ScLog("Victory. The hostile ships are sunk.");
    else if (nResult < 0) ScLog("Defeat. The Gull is sunk.");
    else ScLog("Battle ended.");
    ScRefreshUi();
    // ships return to their moorings a few seconds later so the result can be read
    DelayCommand(6.0, ScInitAll());
    object oPC = GetLocalObject(oMod, SC_PC);
    if (GetIsObjectValid(oPC)) DelayCommand(6.0, AttachCamera(oPC, oPC));
}

void ScStartBattle(object oPC)
{
    object oMod = GetModule();
    if (GetLocalInt(oMod, SC_ACTIVE))
    {
        SendMessageToPC(oPC, "A battle is already under way.");
        return;
    }
    ScInitAll();
    SetLocalInt(oMod, SC_ACTIVE, 1);
    SetLocalInt(oMod, SC_ROUND, 0);
    SetLocalInt(oMod, SC_RESULT, 0);
    SetLocalObject(oMod, SC_PC, oPC);
    SetLocalString(oMod, SC_LOG, "");
    SetLocalObject(ScShip(1), "sc_pilot", oPC);
    ExecuteScript("sc_ui_open", oPC);
    AttachCamera(oPC, ScShip(1));
    ScBeginRound();
}
