#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sName = GetName(oPC);
//
int iMessages = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&BoardTot");
//
int iPage = (GetLocalInt(OBJECT_SELF,"Page")-1)*10;if(iPage<0){iPage = 0;}
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1")+iPage;
int iMes = GetLocalInt(OBJECT_SELF,"Message"+IntToString(iChoice));
//
while(iMes<iMessages)
 {
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Board"+IntToString(iMes),GetPersistentString(oModule,sPlanet+"&"+sArea+"&Board"+IntToString(iMes+1)));
iMes++;
 }
DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Board"+IntToString(iMes));
SetPersistentInt(oModule,sPlanet+"&"+sArea+"&BoardTot",iMes-1);
}
