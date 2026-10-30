#include "_domaintransfer"
// Action for "Buy this domain." in domain.dlg.json. Checks everything again,
// because the dialog may have been open for a while, then takes the gold and
// hands the domain over. Access grants are cleared; renters keep their tenancy.
void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(OBJECT_SELF);
    string sOwner = DomainOwnerName(oArea);
    if ((GetTag(OBJECT_SELF) != "domaincontrol") || GetIsDM(oPC) || (sOwner == GetName(oPC)) || !DomainIsAbandoned(oArea))
    {
        FloatingTextStringOnCreature("This domain is no longer for sale.", oPC, FALSE);
        return;
    }
    if (GetGold(oPC) < iDomainAbandonedGP)
    {
        FloatingTextStringOnCreature("You need " + IntToString(iDomainAbandonedGP) + " GP.", oPC, FALSE);
        return;
    }
    TakeGoldFromCreature(iDomainAbandonedGP, oPC, TRUE);
    DomainTransferOwner(oArea, GetName(oPC), TRUE);
    SetName(OBJECT_SELF, GetName(oPC) + "'s Domain");
    FloatingTextStringOnCreature("The domain is now yours.", oPC, FALSE);
    WriteTimestampedLogEntry(GetName(oPC) + " bought the abandoned domain of " + sOwner + " for " + IntToString(iDomainAbandonedGP) + " GP.");
}
