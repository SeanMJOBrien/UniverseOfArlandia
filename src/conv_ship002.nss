#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sAreaTag = GetTag(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oTarget = GetNearestObjectByTag("dock",oPC);
object oRope = GetItemPossessedBy(oPC,"cr_rope");
float fX = GetPosition(oPC).x;
float fY = GetPosition(oPC).y;
float fZ = 0.0;if(GetStringLeft(GetTag(oArea),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")){fZ = 5.0;}
string sItemTag = GetLocalString(oPC,"shiptool");
//
int iCheck;object oTargetArea;string sTargetArea;string sNewArea;string sAreaNumber;int i;object oNew;string sVar;string sCount1;string sCount2;int iX;int iY;
////////////////////////////////////////////////////////////////////////////////
// Dive
if(sItemTag=="tool_ship")
 {
if(GetStringLeft(sAreaTag,5)!="ocean")
  {
FloatingTextStringOnCreature("diving impossible",oPC);
  }
else if(oRope==OBJECT_INVALID)
  {
FloatingTextStringOnCreature("you need a rope to be able to dive",oPC);
  }
else
  {
sTargetArea = GetLocalString(oModule,sPlanet+"_"+sArea+"_Ship");

if(sTargetArea!=""){iCheck = 1;oTargetArea = GetObjectByTag(sTargetArea);}else
   {
sNewArea = "underwater";
while(i<10)
    {
i++;if(i<10){sAreaNumber = "00"+IntToString(i);}else{sAreaNumber = "0"+IntToString(i);}
sTargetArea = sNewArea+sAreaNumber;oTargetArea = GetObjectByTag(sTargetArea);

if((GetIsObjectValid(oTargetArea))&&(GetLocalInt(oTargetArea,"Used")<1))
     {
SetLocalInt(oTargetArea,"Used",1);
SetLocalString(oModule,sPlanet+"_"+sArea+"_Ship",sTargetArea);
SetLocalString(oTargetArea,"Planet",sPlanet);
SetLocalString(oTargetArea,"Area",sArea+"_Ship");
iCheck = 1;
break;
     }
    }
   }
if(iCheck==1)
   {
// Lock target area
SetLocalString(oPC,"PlayerAreaTo",GetTag(oTargetArea));
// Jump player
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_rope",Location(oTargetArea,Vector(fX,fY,fZ+1.0),DIRECTION_NORTH));SetLocalInt(oNew,"DontSave2",1);SetLocalString(oNew,"Master",GetName(oPC));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_rope",Location(oTargetArea,Vector(fX,fY,fZ+16.0),DIRECTION_NORTH));SetLocalInt(oNew,"DontSave2",1);SetLocalString(oNew,"Master",GetName(oPC));
AssignCommand(oPC,ActionJumpToLocation(Location(oTargetArea,Vector(fX,fY,1.0),DIRECTION_NORTH)));
   }
else
   {
FloatingTextStringOnCreature("*no area available*",oPC);
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Land
else if(sItemTag=="tool_airship")
 {
sArea = GetStringLeft(sArea,GetStringLength(sArea)-5);

string sPlanetVar = GetPersistentString(oModule,sPlanet);
int iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sPlanetVar,FindSubString(sPlanetVar,"&002&")),GetStringLength(GetStringLeft(sPlanetVar,FindSubString(sPlanetVar,"&002&")))-FindSubString(sPlanetVar,"&001&")-5));
string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);

if(GetStringLeft(sX,1)=="m"){sX = "-"+GetStringRight(sX,GetStringLength(sX)-1);}iX = StringToInt(sX);
if(GetStringLeft(sY,1)=="m"){sY = "-"+GetStringRight(sY,GetStringLength(sY)-1);}iY = StringToInt(sY);
sVar = GetPersistentString(oModule,sPlanet+"AreasX"+sX);
if(iY<=-10){sCount1 = "-"+IntToString(-iY);}else if(iY<0){sCount1 = "-0"+IntToString(-iY);}else if(iY<10){sCount1 = "+0"+IntToString(iY);}else{sCount1 = "+"+IntToString(iY);}sCount1 = "&"+sCount1+"&";
if(iY-1<=-10){sCount2 = "-"+IntToString(-iY+1);}else if(iY-1<0){sCount2 = "-0"+IntToString(-iY+1);}else if(iY-1<10){sCount2 = "+0"+IntToString(iY-1);}else{sCount2 = "+"+IntToString(iY-1);}sCount2 = "&"+sCount2+"&";
if(iY==-iPlanetSize/2){sNewArea = GetStringLeft(sVar,FindSubString(sVar,sCount1));}else{sNewArea = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,sCount1)),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,sCount1)))-FindSubString(sVar,sCount2)-5);}

if((GetStringLeft(sAreaTag,6)=="clouds")&&(sNewArea!="clouds")&&(sNewArea!="ocean")&&(sNewArea!="space"))
  {
SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sArea);
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",DIRECTION_NORTH);

ExecuteScript("transitions",oPC);
  }
else
  {
FloatingTextStringOnCreature("Impossible to land here",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
