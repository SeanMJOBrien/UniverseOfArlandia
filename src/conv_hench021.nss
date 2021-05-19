void main()
{
object oPC = GetPCSpeaker();
object oHenchs = GetHenchman(oPC);

while(GetIsObjectValid(oHenchs))
 {
SetLocalObject(oPC,"Hench",oHenchs);
SetLocalInt(oPC,"HenchAction",3);

ExecuteScript("henchs",oPC);
oHenchs = GetHenchman(oPC);
 }
}
