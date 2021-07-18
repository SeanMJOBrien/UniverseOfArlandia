void main()
{
object oPC = GetPCSpeaker();
object oBoard = GetNearestObjectByTag("domaincontrol",oPC);

AssignCommand(oPC,ActionInteractObject(oBoard));
}
