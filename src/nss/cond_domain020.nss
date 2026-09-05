#include "_domainuser"
// Gates the "Structure menu :" rent entry (domain.dlg.json EntryList[0]) on a
// House structure flag - rent it, enter it, pay rent, leave it.
//
// This is the non-owner path: StartingList evaluates cond_domain004 and
// cond_domain005 first, so a domain's owner always gets the build/destroy menu
// instead and never reaches this entry.
//
// It used to return TRUE for ANY player at any House flag, in any domain, so
// renting someone else's house was open to the whole server. It is now the
// owner's per-slot grant that opens it (TASK-35): granting a character the
// House slot IS designating that house for them, after which the existing rent
// path already makes them the interior's Master - which is what
// mod_unacquire.nss:36 checks before letting them place furniture. So claiming
// and furnishing a room needs no new mechanism, only this permission.
//
// The character currently renting the slot is always let through, whether or
// not they hold a grant. Otherwise revoking a grant - or this change landing on
// a live server - would strand a sitting tenant with no way to pay rent, reach
// their belongings, or move out.
int StartingConditional()
{
    if (GetTag(OBJECT_SELF) != "structureflag") { return FALSE; }
    if (GetLocalInt(OBJECT_SELF, "Structure") != 11) { return FALSE; }

    object oPC = GetPCSpeaker();
    if (!GetIsObjectValid(oPC)) { return FALSE; }

    if (DomainCanUseHere(oPC, OBJECT_SELF)) { return TRUE; }

    // Sitting tenant: same test cond_domain019 uses for the rent replies.
    object oArea = GetArea(OBJECT_SELF);
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = DomainAreaOf(oArea);
    int iSlot = GetLocalInt(OBJECT_SELF, "Slot");
    string sRenter = GetPersistentString(GetModule(), sPlanet + "&" + sArea + "&Domain&" + IntToString(iSlot));
    return ((sRenter != "") && (sRenter == GetName(oPC)));
}
