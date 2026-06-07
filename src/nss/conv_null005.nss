#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sName = GetName(oPC);
//
int iMessages = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&BoardTot");
int iMessages2 = GetPersistentInt(oModule,sPlanet+"&DHBoardTot");
//
string sPos = GetLocalString(OBJECT_SELF,"Word");
string sTitle = GetLocalString(OBJECT_SELF,"title");string sTitle2 = sTitle;
string sMessage = GetLocalString(OBJECT_SELF,"message");string sMessage2 = sMessage;
int iBoard = GetLocalInt(oPC,"Board");
int iDomainRule = GetLocalInt(oPC,"DomainRule");
string sMes;string sAuthor;int i;
//
if(iDomainRule>0)
 {
SetPersistentInt(oModule,"Log",1);
WriteTimestampedLogEntry(sName+" : "+sPos);
 }
//
else if(iBoard==1)
 {
iMessages++;
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Board"+IntToString(iMessages),sName+"_A_"+sTitle+"_B_"+sMessage);
SetPersistentInt(oModule,sPlanet+"&"+sArea+"&BoardTot",iMessages);
 }
//
else if(iBoard==2)
 {
SetPersistentInt(oModule,"Log",1);
WriteTimestampedLogEntry(sName+" said : "+sPos);
 }
//
else if(iBoard==3)
 {
while(i<iMessages2)
  {
i++;
sMes = GetPersistentString(oModule,sPlanet+"&DHBoard"+IntToString(i));
sAuthor = GetStringLeft(sMes,FindSubString(sMes,"_A_"));
if(sAuthor==sName){iMessages2 = i-1;break;}
  }
iMessages2++;
SetPersistentString(oModule,sPlanet+"&DHBoard"+IntToString(iMessages2),sName+"_A_"+sTitle+"_B_"+sMessage);
SetPersistentInt(oModule,sPlanet+"&DHBoardTot",iMessages2);
 }
//
DeleteLocalString(OBJECT_SELF,"title");
DeleteLocalString(OBJECT_SELF,"message");
DeleteLocalInt(oPC,"Board");
}
