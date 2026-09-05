#include "aps_include"
#include "_domainuser"
// Gates the "Rent the house." reply.
//
// Two tests, both required:
//   1. The slot itself is free - nobody is already renting it (unchanged).
//   2. This character isn't already renting somewhere else. Nothing enforced
//      that before, so one character could hold every unrented house in every
//      domain at once. Governed by iDomainOneRental in _module.nss; set it to 0
//      to restore the old unlimited behaviour.
//
// DomainMayRent verifies the character's existing tenancy still exists and
// still names them, clearing a stale marker if not - so demolishing a tenant's
// house never locks them out of renting again.
int StartingConditional()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    //
    object oArea = GetArea(OBJECT_SELF);
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = GetLocalString(oArea, "Area");
    int iSlot = GetLocalInt(OBJECT_SELF, "Slot");
    string sRent = GetPersistentString(oModule, sPlanet + "&" + sArea + "&Domain&" + IntToString(iSlot));

    if (sRent != "") { return FALSE; }
    return DomainMayRent(oPC);
}
