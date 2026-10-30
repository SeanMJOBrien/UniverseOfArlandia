#include "_domaintransfer"
// Offers the purchase of an abandoned domain (domain.dlg.json, "for sale" entry).
// Shown at the domain's sign to anyone who is not its owner or a DM, once the
// owner has been away for iDomainAbandonedDays. See _domaintransfer.nss.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(OBJECT_SELF);
    if (GetTag(OBJECT_SELF) != "domaincontrol") return FALSE;
    if (GetIsDM(oPC)) return FALSE;
    string sOwner = DomainOwnerName(oArea);
    if ((sOwner == "") || (sOwner == GetName(oPC))) return FALSE;
    if (!DomainIsAbandoned(oArea)) return FALSE;
    SetCustomToken(10630, sOwner);
    SetCustomToken(10631, IntToString(DomainDaysAway(sOwner)));
    SetCustomToken(10632, IntToString(iDomainAbandonedGP));
    return TRUE;
}
