////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"PlanetOrb");
//
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
//
float fX;float fY;
////////////////////////////////////////////////////////////////////////////////
string sAreaDest = GetLocalString(OBJECT_SELF,"LandPlaceDest"+IntToString(iChoice+((iStep-1)*10)));

SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sAreaDest);
fX = 120.0;fY = 90.0;if(sAreaDest=="0_0"){fX = 120.0;fY = 120.0;}
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);

ExecuteScript("transitions",oPC);
////////////////////////////////////////////////////////////////////////////////
}
