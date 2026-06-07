void main()
{
object oPC = GetPCSpeaker();
string sName = GetName(oPC);
object oArea = GetArea(oPC);
object oHenchs = GetFirstObjectInArea(oArea);

while(GetIsObjectValid(oHenchs))
 {
if((GetLocalInt(oHenchs,"Hench")==1)&&(GetLocalInt(oHenchs,"DontSave")==1)&&(GetLocalString(oHenchs,"Master")==sName))
  {
if((GetResRef(oHenchs)=="hench000")&&(GetLocalInt(oHenchs,"HenchNum")==0)){SetLocalInt(oPC,"HenchAction",1);}else{SetLocalInt(oPC,"HenchAction",4);}
SetLocalObject(oPC,"Hench",oHenchs);
ExecuteScript("henchs",oPC);
  }
oHenchs = GetNextObjectInArea(oArea);
 }
}
