#include "_string_utils"
// Airship/spaceship arrival sequencing (TASK-15) and free-form flight paths
// (TASK-26).
//
// Everything here is a client-side visual transform. A ship placeable's REAL
// position is always its landing spot; a "flight" is a lerped visual offset
// from that spot, so there is no server-side movement, no pathfinding, and no
// walkmesh/collision change mid-flight. Placeables can't use creature movement
// actions anyway.
//
// Only the hull ever animates. The mooring ropes and boarding ladder/ramp are
// separate placeables at fixed real positions; the caller staggers them in with
// DelayCommand once the hull has settled, rather than descending together.
//
// Flights are single-axis by design: a leg shares one coordinate between its
// start and end point, so the hull flies straight down a fixed longitude or
// latitude. A diagonal approach cuts across the middle of the area and is far
// more likely to clip through scenery between the entry point and the dock.
// ShipEdgePoint() preserves that property for all four edges.
//
// Tunables are literal defaults on each function - NWScript requires default
// arguments to be compile-time literals, so they can't be pulled from
// _module.nss: altitude 200.0m, leg duration 20.0s, edge pad 40.0m, hull view
// distance 1000.0m.
//
// Requires "aps_include" to be included BEFORE this file (via _string_utils,
// which this uses for RotateOffset90/RotateFacing90).

// Edge indices for ShipEdgePoint/ShipEdgeApproachFacing/ShipPickEdge. N/E/S/W
// ordering matches the compass ordering the cluster system uses in dmb_inc.nss.
int SHIP_EDGE_NORTH = 0;
int SHIP_EDGE_EAST  = 1;
int SHIP_EDGE_SOUTH = 2;
int SHIP_EDGE_WEST  = 3;

// A point fPad metres beyond oArea's nEdge edge, at fAlt metres altitude,
// sharing vLand's other axis so a leg between the two is a straight
// single-axis run (see the file header on why diagonals are avoided).
vector ShipEdgePoint(object oArea, vector vLand, int nEdge, float fAlt=200.0, float fPad=40.0)
{
    float fWidth  = IntToFloat(GetAreaSize(AREA_WIDTH,  oArea)*10);
    float fHeight = IntToFloat(GetAreaSize(AREA_HEIGHT, oArea)*10);
    if (nEdge == SHIP_EDGE_NORTH) { return Vector(vLand.x, fHeight+fPad, fAlt); }
    if (nEdge == SHIP_EDGE_EAST)  { return Vector(fWidth+fPad, vLand.y, fAlt); }
    if (nEdge == SHIP_EDGE_SOUTH) { return Vector(vLand.x, -fPad, fAlt); }
    return Vector(-fPad, vLand.y, fAlt);
}

// The facing a hull travelling INWARD from nEdge points along, in the engine's
// DIRECTION_* convention (East=0, counterclockwise). A ship crossing the north
// edge is flying south, and so on.
float ShipEdgeApproachFacing(int nEdge)
{
    if (nEdge == SHIP_EDGE_NORTH) { return DIRECTION_SOUTH; }
    if (nEdge == SHIP_EDGE_EAST)  { return DIRECTION_WEST; }
    if (nEdge == SHIP_EDGE_SOUTH) { return DIRECTION_NORTH; }
    return DIRECTION_EAST;
}

// A random edge index. Pass the arrival edge as nExclude when picking a
// departure edge, so a ship never leaves the way it came in.
int ShipPickEdge(int nExclude=-1)
{
    if ((nExclude < 0) || (nExclude > 3)) { return Random(4); }
    return (nExclude+1+Random(3))%4;
}

// One leg of a flight. vLand is the hull's REAL position (its landing spot);
// vFrom/vTo are the world points it should appear to travel between. The hull
// is snapped to vFrom instantly, then lerped to vTo over fDuration.
//
// fRotFrom/fRotTo are hull yaw offsets in degrees relative to its real facing,
// lerped alongside the translation so the ship banks into its docked
// orientation as it arrives (or out of it as it leaves). NOT yet confirmed
// in-game that ROTATE_Z takes degrees rather than radians - check this before
// trusting a non-zero rotation, the translation half is the proven part.
void ShipFlyLeg(object oShip, vector vLand, vector vFrom, vector vTo, float fDuration, int nLerp, float fRotFrom=0.0, float fRotTo=0.0)
{
    if (!GetIsObjectValid(oShip)) { return; }

    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_X, vFrom.x-vLand.x, OBJECT_VISUAL_TRANSFORM_LERP_NONE);
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Y, vFrom.y-vLand.y, OBJECT_VISUAL_TRANSFORM_LERP_NONE);
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, vFrom.z-vLand.z, OBJECT_VISUAL_TRANSFORM_LERP_NONE);
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_ROTATE_Z,    fRotFrom,        OBJECT_VISUAL_TRANSFORM_LERP_NONE);

    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_X, vTo.x-vLand.x, nLerp, fDuration);
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Y, vTo.y-vLand.y, nLerp, fDuration);
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, vTo.z-vLand.z, nLerp, fDuration);
    SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_ROTATE_Z,    fRotTo,        nLerp, fDuration);

    SetObjectVisibleDistance(oShip, 1000.0);
}

// Flies oShip in from nEdge down to its own real position, decelerating into
// the dock (EASE_OUT). The hull enters nose-first and rotates to its docked
// facing as it settles. Generalises EaseShipHullIn to any of the four edges.
void ShipArriveFromEdge(object oShip, int nEdge, float fDurationSeconds=20.0, float fAltitude=200.0)
{
    if (!GetIsObjectValid(oShip)) { return; }
    vector vLand = GetPosition(oShip);
    vector vFrom = ShipEdgePoint(GetArea(oShip), vLand, nEdge, fAltitude);
    float fRot = ShipEdgeApproachFacing(nEdge)-GetFacing(oShip);
    ShipFlyLeg(oShip, vLand, vFrom, vLand, fDurationSeconds, OBJECT_VISUAL_TRANSFORM_LERP_EASE_OUT, fRot, 0.0);
}

// Departure mirror: the hull lifts from its docked position and accelerates out
// over nEdge (EASE_IN), rotating out of its docked facing into the direction of
// travel. Leaving over nEdge means flying the way an arrival from the OPPOSITE
// edge flies, hence the +2.
void ShipDepartToEdge(object oShip, int nEdge, float fDurationSeconds=20.0, float fAltitude=200.0)
{
    if (!GetIsObjectValid(oShip)) { return; }
    vector vLand = GetPosition(oShip);
    vector vTo = ShipEdgePoint(GetArea(oShip), vLand, nEdge, fAltitude);
    float fRot = ShipEdgeApproachFacing((nEdge+2)%4)-GetFacing(oShip);
    ShipFlyLeg(oShip, vLand, vLand, vTo, fDurationSeconds, OBJECT_VISUAL_TRANSFORM_LERP_EASE_IN, 0.0, fRot);
}

// Rotation index (0-3, for RotateOffset90/RotateFacing90) that turns a dock so
// its boarding ramp ends up on the side vPC is standing. SpawnShipRopes/
// SpawnShipLadder author their offsets in world axes for a hull docked at
// facing 180 with the ramp on its -Y side, so rotation is limited to 90-degree
// steps - the same constraint, and the same helpers, domains.nss uses for
// structures.
//
// The index-to-compass mapping is derived from those offsets, not yet confirmed
// in-game (same caveat TASK-17 carried for domain rotation): rotation 0 leaves
// the ramp on -Y (south), 1 puts it on +X, 2 on +Y, 3 on -X.
int ShipDockRotationToward(vector vLand, vector vPC)
{
    float fDX = vPC.x-vLand.x;
    float fDY = vPC.y-vLand.y;
    if (fabs(fDX) >= fabs(fDY)) { if (fDX >= 0.0) { return 1; } return 3; }
    if (fDY >= 0.0) { return 2; }
    return 0;
}

// Instantly offsets oPla so it visually sits at (its own true landing X,
// fStartY, fStartAltitude) - oPla's real position is already its final landing
// spot, this is purely a client-side visual offset from that true position -
// then eases Y and Z back to 0 over fDurationSeconds, i.e. the hull appears to
// fly straight in along a fixed longitude (X never changes, starting from the
// edge of the area) and descend. Kept as the original fixed-longitude entry
// point for transports.nss's scheduled airship/starship arrivals; new callers
// that want a random or chosen approach should use ShipArriveFromEdge instead.
void EaseShipHullIn(object oPla, float fStartY=240.0, float fStartAltitude=200.0, float fDurationSeconds=20.0)
{
    if (!GetIsObjectValid(oPla)) { return; }
    vector vLand = GetPosition(oPla);
    ShipFlyLeg(oPla, vLand, Vector(vLand.x, fStartY, fStartAltitude), vLand, fDurationSeconds, OBJECT_VISUAL_TRANSFORM_LERP_EASE_OUT);
}

// Departure mirror of EaseShipHullIn. The departing hull is already sitting at
// its true (docked) position, so the ease begins right where the ship currently
// is and translates Y/Z out to (fEndY, fEndAltitude) along the same
// fixed-longitude path arrival used. Same 20s duration, but EASE_IN
// (accelerating away) instead of EASE_OUT (decelerating to a stop).
void EaseShipHullOut(object oPla, float fEndY=240.0, float fEndAltitude=200.0, float fDurationSeconds=20.0)
{
    if (!GetIsObjectValid(oPla)) { return; }
    vector vLand = GetPosition(oPla);
    ShipFlyLeg(oPla, vLand, vLand, Vector(vLand.x, fEndY, fEndAltitude), fDurationSeconds, OBJECT_VISUAL_TRANSFORM_LERP_EASE_IN);
}

// One rope/ramp piece. The (fX,fY,fZ) offset and fF facing are authored for a
// hull docked at facing 180; iRotation90 turns position and facing together
// around the anchor so a ship docked at any 90-degree step keeps its ropes and
// ramp in the right place relative to the hull.
object ShipPieceAt(object oArea, string sBP, float fPX, float fPY, float fPZ, float fX, float fY, float fZ, float fF, int iRotation90, string sTagSuffix, float fDestroyDelay)
{
    vector vOff = RotateOffset90(fX, fY, iRotation90);
    location lLoc = Location(oArea, Vector(fPX+vOff.x, fPY+vOff.y, fPZ+fZ), RotateFacing90(fF, iRotation90));
    object oPla = CreateObject(OBJECT_TYPE_PLACEABLE, sBP, lLoc, FALSE, sTagSuffix);
    SetLocalInt(oPla, "DontSave", 1);
    SetObjectVisibleDistance(oPla, 1000.0);
    if (fDestroyDelay > 0.0) { DestroyObject(oPla, fDestroyDelay); }
    return oPla;
}

// Spawns the 4 mooring-rope pieces at the given ship anchor (fPX,fPY,fPZ -
// same anchor convention transports.nss already used inline).
// fDestroyDelay>0 schedules DestroyObject that many seconds after this piece's
// own creation (the transport-arrival flourish only). iRotation90 turns the
// whole set with the dock; 0 is the original hardcoded layout.
void SpawnShipRopes(object oArea, float fPX, float fPY, float fPZ, string sTagSuffix, float fDestroyDelay=0.0, int iRotation90=0)
{
    string sBP = "pla_rope";
    SetUseableFlag(ShipPieceAt(oArea,sBP,fPX,fPY,fPZ, 6.0,-1.8,-5.0,180.0,iRotation90,sTagSuffix,fDestroyDelay),FALSE);
    SetUseableFlag(ShipPieceAt(oArea,sBP,fPX,fPY,fPZ, 6.0, 1.8,-5.0,180.0,iRotation90,sTagSuffix,fDestroyDelay),FALSE);
    SetUseableFlag(ShipPieceAt(oArea,sBP,fPX,fPY,fPZ,-3.0,-2.2,-5.0,180.0,iRotation90,sTagSuffix,fDestroyDelay),FALSE);
    SetUseableFlag(ShipPieceAt(oArea,sBP,fPX,fPY,fPZ,-3.0, 2.2,-5.0,180.0,iRotation90,sTagSuffix,fDestroyDelay),FALSE);
}

// Spawns the 2 ramp/ladder pieces. sShipName!="" marks the first piece useable
// and names it (the docked-transport case, boardable by PCs); sShipName==""
// leaves both non-useable (the transport-arrival flourish, a visual-only ship
// that self-destructs). fDestroyDelay and iRotation90 as SpawnShipRopes.
void SpawnShipLadder(object oArea, float fPX, float fPY, float fPZ, string sTagSuffix, string sShipName="", float fDestroyDelay=0.0, int iRotation90=0)
{
    string sBP = "pla_ramp";
    object oPla = ShipPieceAt(oArea,sBP,fPX,fPY,fPZ,0.0,-2.00,0.0,270.0,iRotation90,sTagSuffix,fDestroyDelay);
    if (sShipName != "") { SetUseableFlag(oPla,TRUE); SetName(oPla,sShipName); } else { SetUseableFlag(oPla,FALSE); }
    SetUseableFlag(ShipPieceAt(oArea,sBP,fPX,fPY,fPZ,0.0,-0.25,4.5,270.0,iRotation90,sTagSuffix,fDestroyDelay),FALSE);
}
