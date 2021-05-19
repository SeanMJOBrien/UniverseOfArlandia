#include "dmfi_dmw_inc"
void main()
{
object oPC = GetPCSpeaker();
object oPCs = GetFirstPC();
string sPlanet;string sArea;string s;int i;int iArea;

while(i<10){i++;SetCustomToken(20000+i,"");DeleteLocalString(oPC,"NameTarget"+IntToString(i));DeleteLocalLocation(oPC,"LocTarget"+IntToString(i));}i=0;

while(GetIsObjectValid(oPCs))
 {
if(oPCs!=oPC)
  {
i++;s = "";if((GetIsDMPossessed(oPCs))||(GetIsDM(oPCs))){s = ColorText(" / ","white")+ColorText("DM","red");}
sPlanet = GetLocalString(GetArea(oPCs),"Planet");
sArea = GetLocalString(GetArea(oPCs),"Area");
SetLocalString(oPC,"NameTarget"+IntToString(i),ColorText(GetName(oPCs),"yellow")+ColorText(" (","white")+ColorText(sPlanet+" "+sArea,"cyan")+s+")");
SetLocalLocation(oPC,"LocTarget"+IntToString(i),GetLocation(oPCs));
  }
oPCs = GetNextPC();
 }
}
