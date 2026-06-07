#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
object oGoldbag = GetItemPossessedBy(oTarget,"goldbag");
int iHenchs;string sHench;string sBP;string sName;string sStayHench;

while(iHenchs<iMaxHenchs)
 {
iHenchs++;
sHench = GetLocalString(oGoldbag,IntToString(iHenchs)+"Hench");
sBP = GetStringLeft(sHench,FindSubString(sHench,"&A&"));
sName = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&B&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&B&")))-FindSubString(sHench,"&A&")-3);
sStayHench = GetLocalString(oGoldbag,IntToString(iHenchs)+"StayHench");

if(sBP!="")
  {
if(sStayHench=="")
   {
SendMessageToPC(oPC,"Hench "+IntToString(iHenchs)+" : with master");
   }
else
   {
SendMessageToPC(oPC,"Hench "+IntToString(iHenchs)+" : location : "+sStayHench);
   }
  }
else
  {
SendMessageToPC(oPC,"Hench "+IntToString(iHenchs)+" : no hench");
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
