void main()
{
object oPC = GetPCSpeaker();
int iHorseHorde = GetLocalInt(oPC,"Horse Horde Unactivated");

if(iHorseHorde==1)
 {
DeleteLocalInt(oPC,"Horse Horde Unactivated");
SendMessageToPC(oPC,"Horse Horde activated");
 }
else
 {
SetLocalInt(oPC,"Horse Horde Unactivated",1);
SendMessageToPC(oPC,"Horse Horde unactivated");
 }
}
