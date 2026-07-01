#include "aps_include"
#include "_string_utils"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetClickingObject();
object oArea = GetArea(OBJECT_SELF);
string sTag = GetTag(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(GetStringRight(sArea,5)=="_Ship"){sArea = GetStringLeft(sArea,GetStringLength(sArea)-5);}
string sPlanetVar = GetPersistentString(oModule,sPlanet);
int iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sPlanetVar,FindSubString(sPlanetVar,"&002&")),GetStringLength(GetStringLeft(sPlanetVar,FindSubString(sPlanetVar,"&002&")))-FindSubString(sPlanetVar,"&001&")-5));
int bIsSpace = (GetStringLeft(sTag,5)=="space");
//
string sT = GetTag(OBJECT_SELF);
SetLocalString(oPC,"Direction",sT);
int iAreaWidth = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;
float fPos = 5.0;int iCorner = 10;
////////////////////////////////////////////////////////////////////////////////
string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);
string sXnew = sX;string sYnew = sY;string sXu;string sYu;string sVar;string sCount1;string sCount2;int iX;int iY;string sNewArea;int i;
////////////////////////////////////////////////////////////////////////////////
vector vPCVector = GetPosition(oPC);
float fX = vPCVector.x;
float fY = vPCVector.y;
float fFacing = GetFacing(oPC);
////////////////////////////////////////////////////////////////////////////////
SetLocalString(oPC,"PlanetDest",sPlanet);
////////////////////////////////////////////////////////////////////////////////
if(sT=="North")
 {
// North
sYnew=AdvanceCoordAxis(sY,iPlanetSize,1,bIsSpace);
fY = fPos;
// West Corner
if(FloatToInt(fX)<=iCorner)
  {
sXnew=AdvanceCoordAxis(sX,iPlanetSize,-1,bIsSpace);
fX = IntToFloat(iAreaWidth)-fPos;
  }
// East Corner
else if(FloatToInt(fX)>=(iAreaWidth-iCorner))
  {
sXnew=AdvanceCoordAxis(sX,iPlanetSize,1,bIsSpace);
fX = fPos;
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
else if(sT=="South")
 {
// South
sYnew=AdvanceCoordAxis(sY,iPlanetSize,-1,bIsSpace);
fY = IntToFloat(iAreaHeight)-fPos;
// West Corner
if(FloatToInt(fX)<=iCorner)
  {
sXnew=AdvanceCoordAxis(sX,iPlanetSize,-1,bIsSpace);
fX = IntToFloat(iAreaWidth)-fPos;
  }
// East Corner
else if(FloatToInt(fX)>=(iAreaWidth-iCorner))
  {
sXnew=AdvanceCoordAxis(sX,iPlanetSize,1,bIsSpace);
fX = fPos;
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
else if(sT=="East")
 {
// East
sXnew=AdvanceCoordAxis(sX,iPlanetSize,1,bIsSpace);
fX = fPos;
// North Corner
if(FloatToInt(fY)>=(iAreaHeight-iCorner))
  {
sYnew=AdvanceCoordAxis(sY,iPlanetSize,1,bIsSpace);
fY = fPos;
  }
// South Corner
else if(FloatToInt(fY)<=iCorner)
  {
sYnew=AdvanceCoordAxis(sY,iPlanetSize,-1,bIsSpace);
fY = IntToFloat(iAreaHeight)-fPos;
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
else if(sT=="West")
 {
// West
sXnew=AdvanceCoordAxis(sX,iPlanetSize,-1,bIsSpace);
fX = IntToFloat(iAreaWidth)-fPos;
// North Corner
if(FloatToInt(fY)>=(iAreaHeight-iCorner))
  {
sYnew=AdvanceCoordAxis(sY,iPlanetSize,1,bIsSpace);
fY = fPos;
  }
// South Corner
else if(FloatToInt(fY)<=iCorner)
  {
sYnew=AdvanceCoordAxis(sY,iPlanetSize,-1,bIsSpace);
fY = IntToFloat(iAreaHeight)-fPos;
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(sTag,6)=="clouds")
 {
SetLocalString(oPC,"NewAreaSpecial","clouds");
sArea = sArea+"_Ship";
 }
////////////////////////////////////////////////////////////////////////////////
else if(GetStringLeft(sTag,10)=="underwater")
 {
if(GetStringLeft(sXnew,1)=="m"){sXu = "-"+GetStringRight(sXnew,GetStringLength(sXnew)-1);}else{sXu = sXnew;}iX = StringToInt(sXu);
if(GetStringLeft(sYnew,1)=="m"){sYu = "-"+GetStringRight(sYnew,GetStringLength(sYnew)-1);}else{sYu = sYnew;}iY = StringToInt(sYu);
sVar = GetPersistentString(oModule,sPlanet+"AreasX"+sXu);
if(iY<=-10){sCount1 = "-"+IntToString(-iY);}else if(iY<0){sCount1 = "-0"+IntToString(-iY);}else if(iY<10){sCount1 = "+0"+IntToString(iY);}else{sCount1 = "+"+IntToString(iY);}sCount1 = "&"+sCount1+"&";
if(iY-1<=-10){sCount2 = "-"+IntToString(-iY+1);}else if(iY-1<0){sCount2 = "-0"+IntToString(-iY+1);}else if(iY-1<10){sCount2 = "+0"+IntToString(iY-1);}else{sCount2 = "+"+IntToString(iY-1);}sCount2 = "&"+sCount2+"&";
if(iY==-iPlanetSize/2){sNewArea = GetStringLeft(sVar,FindSubString(sVar,sCount1));}else{sNewArea = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,sCount1)),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,sCount1)))-FindSubString(sVar,sCount2)-5);}

if(sNewArea=="11")
  {
SetLocalString(oPC,"NewAreaSpecial","underwater");
sArea = sArea+"_Ship";
  }
else
  {
i++;FloatingTextStringOnCreature("*no way*",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
sArea = sXnew+"_"+sYnew;
SetLocalString(oPC,"AreaDest",sArea);
////////////////////////////////////////////////////////////////////////////////
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",fFacing);
////////////////////////////////////////////////////////////////////////////////
if(i==0){ExecuteScript("transitions",oPC);}
////////////////////////////////////////////////////////////////////////////////
}
