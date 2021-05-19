#include "aps_include"
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPlanet = GetLocalString(GetArea(oPC),"Planet");
string sArea = GetLocalString(GetArea(oPC),"Area");
object oNew;

}
