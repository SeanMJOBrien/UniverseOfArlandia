#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
int StartingConditional(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sName = GetName(oPC);
//
int iMessages = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&BoardTot");
string sMes;string sAuthor;int i;
////////////////////////////////////////////////////////////////////////////////
while(iMessages>0)
 {
sMes = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Board"+IntToString(iMessages));

sAuthor = GetStringLeft(sMes,FindSubString(sMes,"_A_"));
if(sAuthor==sName){i++;}
iMessages--;
 }
////////////////////////////////////////////////////////////////////////////////
if(i<3){return TRUE;}else{return FALSE;}
////////////////////////////////////////////////////////////////////////////////
}
