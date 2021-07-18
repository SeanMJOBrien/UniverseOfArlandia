void main()
{
object oPC = GetMaster();
object oHenchs = GetHenchman(oPC);

while(GetIsObjectValid(oHenchs))
 {
if(GetResRef(oHenchs)=="hench000"){ExecuteScript("soldiers_save",oHenchs);}
oHenchs = GetHenchman(oPC);
 }
}
