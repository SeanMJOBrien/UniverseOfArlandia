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

const string FLIGHT_OWNER     = "FlightOwner";    // object, set on both ship areas
const string FLIGHT_CABIN     = "FlightCabin";    // object, set on the follower
const string FLIGHT_BOARD_LOC = "FlightBoardLoc"; // location, set on the follower
const string FLIGHT_DECK      = "FlightDeck";     // object, set on the cabin: its deck
const string FLIGHT_CABIN_OF  = "FlightCabinOf";  // object, set on the deck: its cabin

// A starship flies as two areas of its own, neither shared with ticketed
// travel: pcshipcabin, the cramped control room that holds the helm, and
// pcshipdeck, the open area everyone else rides in. Both are ordinary module
// areas, so they can be opened and decorated in the toolset. Passengers walk
// between them through the helm placeable that stands in each. An airship has
// no such pair: its cabin is already its deck.
const string FLIGHT_PCSHIP_CABIN = "pcshipcabin";
const string FLIGHT_PCSHIP_DECK  = "pcshipdeck";

// The cabin half of a ship, given either half. An area that is neither (a space
// tile, say) answers for itself, so callers need no separate check.
object FlightCabinOf(object oArea)
{
    object oCabin = GetLocalObject(oArea,FLIGHT_CABIN_OF);
    return GetIsObjectValid(oCabin) ? oCabin : oArea;
}

// The other half of the ship from oArea, or OBJECT_INVALID for a ship that has
// only one (and for anywhere that is not a ship at all).
object FlightOtherHalf(object oArea)
{
    object oCabin = GetLocalObject(oArea,FLIGHT_CABIN_OF);
    if(GetIsObjectValid(oCabin)){return oCabin;}
    object oDeck = GetLocalObject(oArea,FLIGHT_DECK);
    return GetIsObjectValid(oDeck) ? oDeck : OBJECT_INVALID;
}

// The pilot's own record of the cabin flying with them, so that going below
// joins the party's cabin instead of cloning a second one alongside it. One
// local per ship kind - an airship cabin must never answer for a starship.
string FlightCabinVar(int iType) { return (iType==2) ? "OwnCabinStar" : "OwnCabinAir"; }

// The pilot's cabin of this kind, or OBJECT_INVALID once it has been destroyed
// (the clone goes away when the last passenger leaves, leaving this dangling).
object FlightOwnerCabin(object oOwner,int iType)
{
    object oCabin = GetLocalObject(oOwner,FlightCabinVar(iType));
    if(!GetIsObjectValid(oCabin)){DeleteLocalObject(oOwner,FlightCabinVar(iType));return OBJECT_INVALID;}
    return oCabin;
}

// Tie a cabin and its pilot together. Both halves are needed: the cabin names
// its owner for the hatch and the helm, and the owner names its cabin so a
// second one is never cloned.
void FlightSetOwnerCabin(object oOwner,int iType,object oCabin)
{
    SetLocalObject(oOwner,FlightCabinVar(iType),oCabin);
    SetLocalObject(oCabin,FLIGHT_OWNER,oOwner);
    // The deck answers the same questions the cabin does - who owns this ship,
    // may this PC take the helm - so it carries the owner too.
    object oDeck = GetLocalObject(oCabin,FLIGHT_DECK);
    if(GetIsObjectValid(oDeck)){SetLocalObject(oDeck,FLIGHT_OWNER,oOwner);}
}

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

// Where someone arriving in oArea should be put down. Each area carries one
// arrival waypoint; which tag it is depends on which template it came from. The
// two PC-ship areas share one tag, so neither half needs telling apart.
string FlightArrivalWP(object oArea)
{
    if(GetStringLeft(GetTag(oArea),6)=="pcship"){return "WP_pcship";}
    return (GetStringLeft(GetTag(oArea),10)=="cabin_star") ? "WP_cabin_star" : "WP_cabin_air";
}

// The location to put them down at, falling back to anything at all in the area
// rather than dropping them at its origin.
location FlightArrivalLoc(object oArea)
{
    object oWP = FlightWaypointIn(oArea,FlightArrivalWP(oArea));
    return GetIsObjectValid(oWP) ? GetLocation(oWP) : GetLocation(GetFirstObjectInArea(oArea));
}

// Move oPC into oArea, at its arrival point.
void FlightMoveTo(object oPC,object oArea)
{
    if(!GetIsObjectValid(oArea)){return;}
    location lTo = FlightArrivalLoc(oArea);
    AssignCommand(oPC,ClearAllActions(TRUE));
    AssignCommand(oPC,ActionJumpToLocation(lTo));
}

// Clone the cabin template for iType, and for a starship the deck that goes
// with it. Returns OBJECT_INVALID if the cabin template is missing; a missing
// deck template is survivable, leaving a one-area ship.
object FlightCloneCabin(int iType)
{
    object oTemplate = GetObjectByTag((iType==2) ? FLIGHT_PCSHIP_CABIN : "cabin_air000");
    if(!GetIsObjectValid(oTemplate)){return OBJECT_INVALID;}
    object oCabin = CopyArea(oTemplate);
    SetLocalInt(oCabin,"IsCopy",1);
    if(iType==2)
    {
        object oDeckTemplate = GetObjectByTag(FLIGHT_PCSHIP_DECK);
        if(GetIsObjectValid(oDeckTemplate))
        {
            object oDeck = CopyArea(oDeckTemplate);
            SetLocalInt(oDeck,"IsCopy",1);
            SetLocalObject(oCabin,FLIGHT_DECK,oDeck);
            SetLocalObject(oDeck,FLIGHT_CABIN_OF,oCabin);
            SetLocalInt(oDeck,"NeedHelm",1);
        }
        // Both PC-ship areas carry the helm in their own .git, so this flag is
        // only a backstop: SpaceDeckSpawnControl places one at runtime if the
        // area has none, which covers a ship area edited in the toolset before
        // the helm was ever added to it. Named by string to keep this file free
        // of a _spacenav include, which would be circular - _spacenav already
        // includes this one. Airship cabins get none: there is nowhere in the
        // sky to set a course for.
        SetLocalInt(oCabin,"NeedHelm",1);
    }
    return oCabin;
}

int FlightAreaHasPC(object oArea)
{
    object oObj = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObj))
    {
        if(GetIsPC(oObj)){return TRUE;}
        oObj = GetNextObjectInArea(oArea);
    }
    return FALSE;
}

// Destroy an empty ship clone - both halves, and only once neither holds a PC.
// Takes either half, so a caller that has the deck need not resolve the cabin.
void FlightDestroyCabinIfEmpty(object oShipArea)
{
    if(!GetIsObjectValid(oShipArea)){return;}
    object oCabin = FlightCabinOf(oShipArea);
    object oDeck = GetLocalObject(oCabin,FLIGHT_DECK);
    if(FlightAreaHasPC(oCabin)){return;}
    if(GetIsObjectValid(oDeck)&&FlightAreaHasPC(oDeck)){return;}
    if(GetLocalInt(oDeck,"IsCopy")==1){DestroyArea(oDeck);}
    if(GetLocalInt(oCabin,"IsCopy")==1){DestroyArea(oCabin);}
}

// Board party PCs near oOwner into a freshly-cloned cabin (1 air / 2 star).
void FlightBoardParty(object oOwner, int iType, float fRadius)
{
    object oOriginArea = GetArea(oOwner);
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
                FlightSetOwnerCabin(oOwner,iType,oCabin);
                // Passengers ride the deck, which is the room built for them.
                // A ship with no deck boards them in the cabin as before.
                object oBoardArea = GetLocalObject(oCabin,FLIGHT_DECK);
                if(!GetIsObjectValid(oBoardArea)){oBoardArea = oCabin;}
                lBoard = FlightArrivalLoc(oBoardArea);
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

// Shared hatch exit: clear oUser's flight locals, send them to lDest, and
// destroy the cabin clone once the last PC has left. Read any location off
// oUser (FLIGHT_BOARD_LOC) BEFORE calling this - it wipes those locals.
void FlightExitTo(object oUser, location lDest)
{
    object oCabin = GetArea(oUser);
    DeleteLocalObject(oUser,FLIGHT_CABIN);
    DeleteLocalLocation(oUser,FLIGHT_BOARD_LOC);
    AssignCommand(oUser,ClearAllActions(TRUE));
    AssignCommand(oUser,ActionJumpToLocation(lDest));
    DelayCommand(6.0,FlightDestroyCabinIfEmpty(oCabin));
}

// Hatch option 1: rejoin the flight owner at their CURRENT location (aloft or
// already landed). If the owner has logged out, fall back to oUser's boarding
// spot so they are never stranded.
//
// Refused outright while the owner is inside a conflict (TASK-30): the battle
// is entered through its own shaft, which brings the whole cabin along at once,
// and a hatch jump would drop a lone follower into a live fight by a side door.
// "ConflictActive" is inc_conflict.nss's flag, read by name rather than by
// including that file, which would make the include order circular.
void FlightHatchJoinOwner(object oUser)
{
    object oOwner = GetLocalObject(GetArea(oUser),FLIGHT_OWNER);
    if(GetIsObjectValid(oOwner)&&(GetLocalInt(oOwner,"ConflictActive")==1))
    {
        FloatingTextStringOnCreature("The pilot is under attack - you cannot climb up right now.",oUser);
        return;
    }
    location lDest = GetIsObjectValid(oOwner)
                     ? GetLocation(oOwner)
                     : GetLocalLocation(oUser,FLIGHT_BOARD_LOC);
    FlightExitTo(oUser,lDest);
}

// Hatch option 2: leave the flight and drop back to where oUser boarded, even
// while the owner is still piloting (TASK-24).
void FlightHatchToBoarding(object oUser)
{
    FlightExitTo(oUser,GetLocalLocation(oUser,FLIGHT_BOARD_LOC));
}
