#include "aps_include"
#include "_module"
#include "_string_utils"
////////////////////////////////////////////////////////////////////////////////
// OnEnter script for the four cardinal border triggers on a cluster's
// outermost areas. Cluster areas carry no Planet/Area locals (see the
// cluster branch in transitions.nss), so the home coordinate is baked onto
// the trigger itself via toolset-set locals: ClusterPlanet, ClusterArea
// ("X_Y"). Internal cluster navigation uses plain NWN doors/triggers - this
// script only fires at the cluster's true outer edge.
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetEnteringObject();
if(!GetIsPC(oPC)){return;}
string sTag = GetTag(OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
string sPlanet = GetLocalString(OBJECT_SELF,"ClusterPlanet");
string sArea = GetLocalString(OBJECT_SELF,"ClusterArea");
if((sPlanet=="")||(sArea=="")){return;}
////////////////////////////////////////////////////////////////////////////////
string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);
string sTot = GetPersistentString(oModule,sPlanet);
int iPlanetSize = StringToInt(EncodedField(sTot,2));
string sXnew = sX;string sYnew = sY;
////////////////////////////////////////////////////////////////////////////////
object oArea = GetArea(oPC);
int iAreaWidth = GetAreaSize(AREA_WIDTH,oArea)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,oArea)*10;
float fPos = 5.0;float fX;float fY;float fFacing;
////////////////////////////////////////////////////////////////////////////////
if(sTag=="North")
 {
sYnew=AdvanceCoordAxis(sY,iPlanetSize,1,FALSE);
fY = fPos;fFacing = 0.0;
 }
else if(sTag=="South")
 {
sYnew=AdvanceCoordAxis(sY,iPlanetSize,-1,FALSE);
fY = IntToFloat(iAreaHeight)-fPos;fFacing = 180.0;
 }
else if(sTag=="East")
 {
sXnew=AdvanceCoordAxis(sX,iPlanetSize,1,FALSE);
fX = fPos;fFacing = 90.0;
 }
else if(sTag=="West")
 {
sXnew=AdvanceCoordAxis(sX,iPlanetSize,-1,FALSE);
fX = IntToFloat(iAreaWidth)-fPos;fFacing = 270.0;
 }
else{return;}
////////////////////////////////////////////////////////////////////////////////
SetLocalString(oPC,"Direction",sTag);
SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sXnew+"_"+sYnew);
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",fFacing);
ExecuteScript("transitions",oPC);
////////////////////////////////////////////////////////////////////////////////
}
