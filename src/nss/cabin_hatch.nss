// cabin_hatch - OnUsed for the personal-flight cabin hatch placeable.
// Opens the hatch menu (cabin_hatch.dlg): rejoin the pilot, or drop back to
// where you boarded. See inc_flight.nss and cabin_join.nss / cabin_disemb.nss.
void main()
{
    object oPC = GetLastUsedBy();
    if(!GetIsObjectValid(oPC)){return;}
    AssignCommand(oPC,ClearAllActions(TRUE));
    AssignCommand(oPC,ActionStartConversation(OBJECT_SELF,"cabin_hatch",TRUE,FALSE));
}
