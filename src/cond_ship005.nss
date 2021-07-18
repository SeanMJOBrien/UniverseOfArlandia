int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oPlanet = GetNearestObjectByTag("pla_orb",oPC);
string sPlanetType = GetLocalString(oArea,"PlanetType");

if((GetIsObjectValid(oPlanet))&&(GetDistanceBetween(oPC,oPlanet)<=60.0)&&((GetStringLeft(sPlanetType,1)=="m")||(GetStringLeft(sPlanetType,1)=="p"))){return TRUE;}else{return FALSE;}
}
