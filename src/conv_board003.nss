#include "aps_include"
#include "dmfi_dmw_inc"
////////////////////////////////////////////////////////////////////////////////
void main()
{
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oPC = GetPCSpeaker();
int iPage = GetLocalInt(OBJECT_SELF,"Page")*10;
//
int iMessages = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&BoardTot");
int iMessages2 = GetPersistentInt(oModule,sPlanet+"&DHBoardTot");
//
int iDM = GetLocalInt(OBJECT_SELF,"DM");if(iDM==1){iMessages2 = 0;}
string sName;string sTitle;string sMessage;int i;string sMes;int iMes;string sDomTitle;string sDomMessage;int iRed;string sColor;
//
while(i<10)
 {
i++;
if((iMessages2-iPage-i)>-1){iMes = iMessages2-iPage-i+1;sMes = GetPersistentString(oModule,sPlanet+"&DHBoard"+IntToString(iMes));iRed = 1;}else{iMes = iMessages-iPage-i+1+iMessages2;sMes = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Board"+IntToString(iMes));iRed = 0;}

sName = GetStringLeft(sMes,FindSubString(sMes,"_A_"));
sTitle = GetStringRight(GetStringLeft(sMes,FindSubString(sMes,"_B_")),GetStringLength(GetStringLeft(sMes,FindSubString(sMes,"_B_")))-FindSubString(sMes,"_A_")-3);
sMessage = GetStringRight(sMes,GetStringLength(sMes)-FindSubString(sMes,"_B_")-3);

if(sName!="")
  {
if(iRed==1){sColor = "red";}else{sColor = "yellow";}SetCustomToken(10070+i,ColorText(sTitle,sColor));
if(iRed==1){sColor = "red";}else{sColor = "yellow";}SetCustomToken(10080+i,ColorText(sName,sColor));
if(iRed==1){sColor = "red";}else{sColor = "green";}SetCustomToken(10090+i,ColorText(sMessage,sColor));
SetLocalInt(OBJECT_SELF,"Message"+IntToString(i),iMes);
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
  }
else
  {
SetCustomToken(10070+i,"");
SetCustomToken(10080+i,"");
SetCustomToken(10090+i,"");
DeleteLocalInt(OBJECT_SELF,"Message"+IntToString(i));
SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);
  }
 }
//
SetLocalInt(OBJECT_SELF,"Page",iPage+1);
}
