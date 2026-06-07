void main()
{
object oPC = GetPCSpeaker();
int iAreaMode = GetLocalInt(oPC,"AreaMode");

if(iAreaMode==1)
 {
DeleteLocalInt(oPC,"AreaMode");
 }
else
 {
SetLocalInt(oPC,"AreaMode",1);
 }
}
