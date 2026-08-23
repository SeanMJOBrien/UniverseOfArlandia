#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
// DM cluster tool, step 1: while standing on the terrain tile you want to
// register a cluster at, mark it as the pending cluster coordinate. Then
// walk/jump to the entry area you built and use conv_dm046 to register it
// into a slot (Default/North/South/East/West).
////////////////////////////////////////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
if(sPlanet=="")
 {
FloatingTextStringOnCreature("you must be on a planet tile to use that function",oPC);
 }
else
 {
SetLocalString(oPC,"PendingClusterPlanet",sPlanet);
SetLocalString(oPC,"PendingClusterAreaKey",sArea);
SendMessageToPC(oPC,"Marked "+sPlanet+" "+sArea+" as the pending cluster coordinate - now go to the area you want to register and use the cluster tool there.");
 }
}
