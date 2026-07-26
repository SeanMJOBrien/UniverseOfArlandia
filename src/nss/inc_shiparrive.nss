// Airship/spaceship arrival sequencing (TASK-15).
//
// Only the hull eases in visually from above; the mooring ropes and
// boarding ladder/ramp appear afterward (staggered via DelayCommand in
// the caller), not simultaneously with the hull's descent.

// Instantly offsets oPla 20m up (visual only - oPla's real position is
// already its final landing spot) then eases that offset back to 0 over
// fDurationSeconds, i.e. the hull appears to descend into place. Also
// raises view distance to 200m (matches area_pop_inc.nss's static-scenery
// value; ship placeables aren't covered by that pass since they're
// spawned dynamically here, not part of an area's pre-placed content).
//
// TEMPORARILY DISABLED (2026-07-25): reports of the ship not appearing at
// all after this went live. Root cause not yet confirmed - suspects are
// either a sign/axis assumption error (TRANSLATE_Z positive might not
// mean "up" the way this assumed) or the two SetObjectVisualTransform
// calls firing in the same script tick not behaving as documented. Keep
// only the visibility-distance bump (safe, unrelated) until this is
// verified in-game in isolation before re-enabling the transform.
void EaseShipHullIn(object oPla, float fDescentMeters=20.0, float fDurationSeconds=3.0)
{
    if (!GetIsObjectValid(oPla)) { return; }
    //SetObjectVisualTransform(oPla, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, fDescentMeters, OBJECT_VISUAL_TRANSFORM_LERP_NONE);
    //SetObjectVisualTransform(oPla, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, 0.0, OBJECT_VISUAL_TRANSFORM_LERP_EASE_OUT, fDurationSeconds);
    SetObjectVisibleDistance(oPla, 200.0);
}

// Spawns the 4 mooring-rope pieces at the given ship anchor (fPX,fPY,fPZ -
// same anchor convention transports.nss already used inline). Same
// per-piece offsets as the original inline CreateObject calls.
// fDestroyDelay>0 schedules DestroyObject that many seconds after this
// piece's own creation (the transport-arrival flourish only).
void SpawnShipRopes(object oArea, float fPX, float fPY, float fPZ, string sTagSuffix, float fDestroyDelay=0.0)
{
    string sBP = "pla_rope";
    float fX;float fY;float fZ;float fF;location lLoc;object oPla;

    fX=6.0;fY=-1.8;fZ=-5.0;fF=180.0;lLoc=Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla=CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,sTagSuffix);SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);SetObjectVisibleDistance(oPla,200.0);if(fDestroyDelay>0.0){DestroyObject(oPla,fDestroyDelay);}
    fX=6.0;fY=1.8;fZ=-5.0;fF=180.0;lLoc=Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla=CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,sTagSuffix);SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);SetObjectVisibleDistance(oPla,200.0);if(fDestroyDelay>0.0){DestroyObject(oPla,fDestroyDelay);}
    fX=-3.0;fY=-2.2;fZ=-5.0;fF=180.0;lLoc=Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla=CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,sTagSuffix);SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);SetObjectVisibleDistance(oPla,200.0);if(fDestroyDelay>0.0){DestroyObject(oPla,fDestroyDelay);}
    fX=-3.0;fY=2.2;fZ=-5.0;fF=180.0;lLoc=Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla=CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,sTagSuffix);SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);SetObjectVisibleDistance(oPla,200.0);if(fDestroyDelay>0.0){DestroyObject(oPla,fDestroyDelay);}
}

// Spawns the 2 ramp/ladder pieces. sShipName!="" marks the first piece
// useable and names it (the docked-transport case, boardable by PCs);
// sShipName=="" leaves both non-useable (the transport-arrival flourish,
// a visual-only ship that self-destructs, matching the original inline
// behaviour). fDestroyDelay same as SpawnShipRopes.
void SpawnShipLadder(object oArea, float fPX, float fPY, float fPZ, string sTagSuffix, string sShipName="", float fDestroyDelay=0.0)
{
    string sBP = "pla_ramp";
    float fX;float fY;float fZ;float fF;location lLoc;object oPla;

    fX=0.0;fY=-2.0;fZ=0.0;fF=270.0;lLoc=Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla=CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,sTagSuffix);SetLocalInt(oPla,"DontSave",1);SetObjectVisibleDistance(oPla,200.0);
    if(sShipName!=""){SetUseableFlag(oPla,TRUE);SetName(oPla,sShipName);}else{SetUseableFlag(oPla,FALSE);}
    if(fDestroyDelay>0.0){DestroyObject(oPla,fDestroyDelay);}

    fX=0.0;fY=-0.25;fZ=4.5;fF=270.0;lLoc=Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla=CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,sTagSuffix);SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);SetObjectVisibleDistance(oPla,200.0);if(fDestroyDelay>0.0){DestroyObject(oPla,fDestroyDelay);}
}
