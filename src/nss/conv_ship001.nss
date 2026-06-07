////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sTag = GetTag(OBJECT_SELF);
object oPC = GetPCSpeaker();if(sTag=="pla_rope"){oPC = GetLastUsedBy();}
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oTarget = GetNearestObjectByTag("dock",oPC);
string sItemTag = GetLocalString(oPC,"shiptool");
float fX = GetPosition(oPC).x;
float fY = GetPosition(oPC).y;
//
int i;
////////////////////////////////////////////////////////////////////////////////
// Go back to ship by rope
if((sTag=="pla_rope")&&(GetLocalString(OBJECT_SELF,"Master")==GetName(oPC)))
 {
sArea = GetStringLeft(sArea,GetStringLength(sArea)-5);

SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sArea);
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",DIRECTION_NORTH);
//
SetLocalObject(oPC,"DestroyIt2",GetNearestObjectByTag("rope",OBJECT_SELF));
SetLocalObject(oPC,"DestroyIt",OBJECT_SELF);
ExecuteScript("transitions",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
// Take off
else if(sItemTag=="tool_airship")
 {
object oAirship = GetItemPossessedBy(oPC,"airship");if(oAirship==OBJECT_INVALID){i++;FloatingTextStringOnCreature("you need an Airship to take off",oPC);}
object oToolAirship = GetItemPossessedBy(oPC,"tool_airship");if(oToolAirship==OBJECT_INVALID){i++;FloatingTextStringOnCreature("you need a Airship Tool to take off",oPC);}
object oGem = GetItemPossessedBy(oPC,"cr_gem001");if(oGem==OBJECT_INVALID){i++;FloatingTextStringOnCreature("you need more Alexandrite to take off",oPC);}

if((sPlanet=="")||(sArea=="")||(GetIsAreaInterior(oArea))||(GetStringLeft(GetTag(oArea),6)=="clouds")||(GetStringLeft(GetTag(oArea),5)=="ocean")||(GetStringLeft(GetTag(oArea),5)=="space"))
  {
FloatingTextStringOnCreature("Impossible to take off here",oPC);
  }
else if(i==0)
  {
SetLocalString(oPC,"NewAreaSpecial","clouds");

SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sArea+"_Ship");
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",DIRECTION_NORTH);

if(GetLocalInt(oGoldbag,"OrigApp")==0){SetLocalInt(oGoldbag,"OrigApp",GetAppearanceType(oPC)+1);}
//SetLocalObject(oPC,"DestroyIt",oGem);

SetLocalInt(oPC,"Henchs",1);
ExecuteScript("transitions",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
