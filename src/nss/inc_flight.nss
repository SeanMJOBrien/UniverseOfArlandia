// inc_flight - Personal-flight party cabins.
//
// When a PC pilots their OWN airship (iType==1) or starship (iType==2), party
// PCs standing within a boarding radius are moved into a freshly-cloned cabin
// area (template cabin_air000 / cabin_star000). The pilot keeps flying alone in
// the clouds/space area exactly as before; the followers ride the cabin.
//
// Reunion is hatch-only: the cabin's hatch placeable (cabin_hatch, OnUsed ->
// FlightHatchToOwner) teleports a follower to the pilot's CURRENT location -
// still aloft, or already landed. If the pilot logs out mid-flight, the hatch
// instead returns the follower to the spot they boarded from. A cabin clone
// self-destroys once the last follower has left.
//
// Each cabin is a fresh CopyArea() clone (its tag stays the template's, but a
// distinct tag from the ticketed airship001/starship001 pool, so transports.nss
// and conv_trans006.nss never touch it), so simultaneous personal flights never
// collide or exhaust a pool.

const string FLIGHT_OWNER     = "FlightOwner";    // object, set on the cabin area
const string FLIGHT_CABIN     = "FlightCabin";    // object, set on the follower
const string FLIGHT_BOARD_LOC = "FlightBoardLoc"; // location, set on the follower

// Find a waypoint tagged sTag INSIDE oArea specifically (not the module-wide
// GetWaypointByTag, which on a clone would return the template's copy).
object FlightWaypointIn(object oArea, string sTag)
{
    object oObj = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObj))
    {
        if((GetObjectType(oObj)==OBJECT_TYPE_WAYPOINT)&&(GetTag(oObj)==sTag)){return oObj;}
        oObj = GetNextObjectInArea(oArea);
    }
    return OBJECT_INVALID;
}

// Clone the cabin template for iType. Returns OBJECT_INVALID if it's missing.
object FlightCloneCabin(int iType)
{
    object oTemplate = GetObjectByTag((iType==2) ? "cabin_star000" : "cabin_air000");
    if(!GetIsObjectValid(oTemplate)){return OBJECT_INVALID;}
    object oCabin = CopyArea(oTemplate);
    SetLocalInt(oCabin,"IsCopy",1);
    return oCabin;
}

// Destroy an empty cabin clone (no PC still aboard).
void FlightDestroyCabinIfEmpty(object oCabin)
{
    if(!GetIsObjectValid(oCabin)){return;}
    object oObj = GetFirstObjectInArea(oCabin);
    while(GetIsObjectValid(oObj))
    {
        if(GetIsPC(oObj)){return;}
        oObj = GetNextObjectInArea(oCabin);
    }
    if(GetLocalInt(oCabin,"IsCopy")==1){DestroyArea(oCabin);}
}

// Board party PCs near oOwner into a freshly-cloned cabin (1 air / 2 star).
void FlightBoardParty(object oOwner, int iType, float fRadius)
{
    object oOriginArea = GetArea(oOwner);
    string sWP = (iType==2) ? "WP_cabin_star" : "WP_cabin_air";
    object oCabin = OBJECT_INVALID;
    location lBoard;

    object oMember = GetFirstFactionMember(oOwner,TRUE);
    while(GetIsObjectValid(oMember))
    {
        if((oMember!=oOwner)
           &&(GetArea(oMember)==oOriginArea)
           &&(GetDistanceBetween(oOwner,oMember)<=fRadius)
           &&(!GetIsObjectValid(GetLocalObject(oMember,FLIGHT_CABIN))))
        {
            // First qualifying follower: spin up the cabin and its board point.
            if(!GetIsObjectValid(oCabin))
            {
                oCabin = FlightCloneCabin(iType);
                if(!GetIsObjectValid(oCabin)){return;} // template missing - bail
                SetLocalObject(oCabin,FLIGHT_OWNER,oOwner);
                object oWP = FlightWaypointIn(oCabin,sWP);
                if(GetIsObjectValid(oWP)){lBoard = GetLocation(oWP);}
                else{lBoard = GetLocation(GetFirstObjectInArea(oCabin));}
            }
            // Remember where this PC boarded (logout-fallback), then embark.
            SetLocalLocation(oMember,FLIGHT_BOARD_LOC,GetLocation(oMember));
            SetLocalObject(oMember,FLIGHT_CABIN,oCabin);
            AssignCommand(oMember,ClearAllActions(TRUE));
            AssignCommand(oMember,ActionJumpToLocation(lBoard));
        }
        oMember = GetNextFactionMember(oOwner,TRUE);
    }
}

// Hatch action: send oUser to the flight owner's current location, or (owner
// gone) back to where oUser boarded. Then clean up an emptied cabin.
void FlightHatchToOwner(object oUser)
{
    object oCabin = GetArea(oUser);
    object oOwner = GetLocalObject(oCabin,FLIGHT_OWNER);
    location lDest;
    if(GetIsObjectValid(oOwner)){lDest = GetLocation(oOwner);}
    else{lDest = GetLocalLocation(oUser,FLIGHT_BOARD_LOC);}

    DeleteLocalObject(oUser,FLIGHT_CABIN);
    DeleteLocalLocation(oUser,FLIGHT_BOARD_LOC);
    AssignCommand(oUser,ClearAllActions(TRUE));
    AssignCommand(oUser,ActionJumpToLocation(lDest));
    DelayCommand(6.0,FlightDestroyCabinIfEmpty(oCabin));
}
