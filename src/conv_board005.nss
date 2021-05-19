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
string sName = GetName(oPC);
//
int iMessages = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&BoardTot");
string sMes;string sAuthor;string sTitle;int i;
//
SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);
SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);
SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);
DeleteLocalInt(OBJECT_SELF,"Step");
DeleteLocalInt(OBJECT_SELF,"Choice1");
DeleteLocalInt(OBJECT_SELF,"Choice2");
DeleteLocalInt(OBJECT_SELF,"Choice3");

while(iMessages>0)
 {
sMes = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Board"+IntToString(iMessages));

sAuthor = GetStringLeft(sMes,FindSubString(sMes,"_A_"));
sTitle = GetStringRight(GetStringLeft(sMes,FindSubString(sMes,"_B_")),GetStringLength(GetStringLeft(sMes,FindSubString(sMes,"_B_")))-FindSubString(sMes,"_A_")-3);

if(sAuthor==sName)
  {
i++;
SetCustomToken(10066+i,ColorText(sTitle,"yellow"));
SetLocalInt(OBJECT_SELF,"Message"+IntToString(i),iMessages);
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
  }
iMessages--;
 }
}
