void main()
{
object oPC = GetPCSpeaker();
object oBoard = GetNearestObjectByTag("messageboard",oPC);

AssignCommand(oPC,ActionInteractObject(oBoard));
}
