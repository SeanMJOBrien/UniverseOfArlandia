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
    string sOldEmail = DomainEmailFor(sOwner);
    DomainTransferOwner(oArea, GetName(oPC), TRUE);
    MailQueue(sOldEmail, "Your Universe of Arlandia domain was sold",
        "Hello,\n\nThe domain of " + sOwner + " at " + GetLocalString(oArea, "Planet") + " " + GetLocalString(oArea, "Area") + " was bought by another player after " + sOwner + " had been away for more than " + IntToString(DomainSaleAfterDays()) + " days.\n\nIf you think this is a mistake, ask a DM.\n\nTo stop these messages, type .email off in game.\n");
    SetName(OBJECT_SELF, GetName(oPC) + "'s Domain");
    FloatingTextStringOnCreature("The domain is now yours.", oPC, FALSE);
    WriteTimestampedLogEntry(GetName(oPC) + " bought the abandoned domain of " + sOwner + " for " + IntToString(iDomainAbandonedGP) + " GP.");
}
