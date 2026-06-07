#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterest = GetStringLeft(sInterests,FindSubString(sInterests,"&1&"));
string sName = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")))-FindSubString(sInterests,"&1&")-3);
string sVar = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")))-FindSubString(sInterests,"&2&")-3);
string sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
int iNight = GetLocalInt(OBJECT_SELF,"Night");
////////////////////////////////////////////////////////////////////////////////
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;float fX = IntToFloat(iAreaX/2);
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;float fY = IntToFloat(iAreaY/2);
float fZ = 0.0;if(GetStringLeft(GetTag(OBJECT_SELF),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(OBJECT_SELF),6)=="ground")||(GetStringLeft(GetTag(OBJECT_SELF),11)=="ruralcastle")){fZ = 5.0;}
float fF = 90.0;
object oPla;object oPla2;string sPla;int iDoor;int iLamp;object oNew;string s;string sBP;location lLoc;int iReserveRand1;int iReserveRand2;int iReserveRand3;string sReserveAni;float fX2;float fY2;int i;
int i000;int i001;int i002;int i003;int i004;int i005;int i006;int i007;int i008;int i009;int i010;int i011;int i012;int i013;int i014;int i015;int i016;int i017;int i018;int i019;int i020;int i021;int i022;int i023;int i024;int i025;int i026;int i027;int i028;int i029;int i030;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Scenery
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Domain
if(GetStringLeft(sInterest,1)=="D")
 {
sPla = "domaincontrol";lLoc = Location(OBJECT_SELF,Vector(fX+0.0,fY-3.0,fZ+0.0),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sPla,lLoc);if(sVar11==""){SetName(oPla,sName+"'s Domain");}else{SetName(oPla,sVar11);}SetLocalString(oPla,"Master",sName);SetLocalInt(oPla,"DontSave",1);
SetLocalInt(OBJECT_SELF,"Domain_Ini",1);ExecuteScript("domains",OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////
// Town
else if(GetStringLeft(sInterest,1)=="1")
 {
if(iNight==0)
  {
fF = fF-90.0;
// Doors
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX-1.0,fY+15.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_WAYPOINT,"pin_townhall",Location(OBJECT_SELF,Vector(fX-1.0,fY+15.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doortown001",Location(OBJECT_SELF,Vector(fX+0.0,fY-40.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);AssignCommand(oPla,PlayAnimation(ANIMATION_PLACEABLE_OPEN));
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-30.09,fY+5.22,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-30.09,fY+10.22,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-29.59,fY+22.3,fZ+0.0),fF+160.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-29.09,fY+16.25,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-26.58,fY+27.1,fZ+0.01),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-26.4,fY+0.25,fZ+0.0),fF+190.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-26.34,fY-6.19,fZ+0.01),fF+190.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-24.05,fY-16.59,fZ+0.0),fF+190.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-22.9,fY+15.75,fZ+0.75),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-22.09,fY-24.9,fZ+0.0),fF+190.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-20.69,fY-33.69,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-17.59,fY+29.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-16.73,fY-34.3,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-14.55,fY-7.9,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-14.09,fY-16.44,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-13.75,fY-27.08,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door002",Location(OBJECT_SELF,Vector(fX-6.4,fY+15.0,fZ+1.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-5.69,fY+28.68,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-5.65,fY-23.32,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-3.5,fY-34.94,fZ+0.46),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-3.4,fY-17.02,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-3.0,fY-9.38,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX-0.77,fY+29.19,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+3.0,fY-34.62,fZ+0.01),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+3.4,fY-9.05,fZ+0.46),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+3.44,fY-27.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+5.8,fY-20.69,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+13.5,fY-16.92,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+14.0,fY-27.55,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+14.6,fY-10.55,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+16.1,fY+29.44,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+16.25,fY+6.0,fZ+0.11),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+19.75,fY-33.09,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+25.1,fY+27.4,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+25.85,fY-23.0,fZ+0.0),fF+340.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+27.0,fY+23.75,fZ+0.0),fF+20.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+27.8,fY-1.19,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+28.0,fY+16.75,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+29.0,fY+4.8,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorhouse001",Location(OBJECT_SELF,Vector(fX+29.19,fY+10.78,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
// Houses
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house051",Location(OBJECT_SELF,Vector(fX-33.19,fY+17.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house048",Location(OBJECT_SELF,Vector(fX-33.0,fY+6.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house053",Location(OBJECT_SELF,Vector(fX-33.0,fY+11.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house048",Location(OBJECT_SELF,Vector(fX-32.0,fY+24.0,fZ+0.0),fF+160.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house002",Location(OBJECT_SELF,Vector(fX-30.0,fY-12.0,fZ+0.0),fF+10.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building021",Location(OBJECT_SELF,Vector(fX-25.0,fY-33.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house053",Location(OBJECT_SELF,Vector(fX-17.5,fY-37.19,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house001",Location(OBJECT_SELF,Vector(fX-15.0,fY+33.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building041",Location(OBJECT_SELF,Vector(fX-15.0,fY+15.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house002",Location(OBJECT_SELF,Vector(fX-9.0,fY-22.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house048",Location(OBJECT_SELF,Vector(fX+0.0,fY+32.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house002",Location(OBJECT_SELF,Vector(fX+9.0,fY-22.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house001",Location(OBJECT_SELF,Vector(fX+15.0,fY+33.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building043",Location(OBJECT_SELF,Vector(fX+15.0,fY+20.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building042",Location(OBJECT_SELF,Vector(fX+16.0,fY+20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building010",Location(OBJECT_SELF,Vector(fX+17.0,fY+12.5,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house048",Location(OBJECT_SELF,Vector(fX+19.0,fY-36.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house023",Location(OBJECT_SELF,Vector(fX+28.0,fY-27.0,fZ+0.0),fF+70.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house048",Location(OBJECT_SELF,Vector(fX+30.0,fY+24.0,fZ+0.0),fF+20.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building004",Location(OBJECT_SELF,Vector(fX+30.0,fY-14.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house051",Location(OBJECT_SELF,Vector(fX+32.0,fY-2.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house053",Location(OBJECT_SELF,Vector(fX+32.0,fY+10.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house051",Location(OBJECT_SELF,Vector(fX+32.0,fY+16.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house048",Location(OBJECT_SELF,Vector(fX+32.0,fY+4.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
// Misc
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"messageboard",Location(OBJECT_SELF,Vector(fX+0.0,fY+10.0,fZ+0.0),fF+210.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_billboard8",Location(OBJECT_SELF,Vector(fX+4.5,fY-42.0,fZ+0.0),fF+80.0));SetLocalInt(oPla,"DontSave",1);SetName(oPla,sName);SetUseableFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"planettakeoff",Location(OBJECT_SELF,Vector(fX+4.0,fY+23.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"pilot",Location(OBJECT_SELF,Vector(fX+2.0,fY+20.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_WAYPOINT,"pin_airstarship",Location(OBJECT_SELF,Vector(fX+2.0,fY+20.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"nw_nevmilitia",Location(OBJECT_SELF,Vector(fX-2.5,fY-38.5,fZ+0.0),fF+45.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetName(oPla,"Town Guard");
oPla = CreateObject(OBJECT_TYPE_CREATURE,"nw_nevmilitia",Location(OBJECT_SELF,Vector(fX+2.5,fY-38.5,fZ+0.0),fF+135.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetName(oPla,"Town Guard");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX-4.0,fY-41.23,fZ+2.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+4.0,fY-41.23,fZ+2.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX-15.5,fY-32.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX-15.0,fY-13.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX-14.09,fY+27.69,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX-12.0,fY+3.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX-3.0,fY-25.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX+2.0,fY+8.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX+3.0,fY-4.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX+15.0,fY+28.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX+15.0,fY-24.5,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX+21.0,fY+3.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"lamppostoff",Location(OBJECT_SELF,Vector(fX+25.5,fY-21.5,fZ+0.0),fF+70.0));SetLocalInt(oPla,"DontSave",1);
// Roads
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road005",Location(OBJECT_SELF,Vector(fX-20.0,fY+0.0,fZ+0.2),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(OBJECT_SELF,Vector(fX-10.0,fY+0.0,fZ+0.2),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road008",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.2),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(OBJECT_SELF,Vector(fX+0.0,fY-10.0,fZ+0.2),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(OBJECT_SELF,Vector(fX+0.0,fY-20.0,fZ+0.2),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road005",Location(OBJECT_SELF,Vector(fX+0.0,fY-40.0,fZ+0.2),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(OBJECT_SELF,Vector(fX+0.0,fY-30.0,fZ+0.2),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road005",Location(OBJECT_SELF,Vector(fX+5.0,fY+20.0,fZ+0.2),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road008",Location(OBJECT_SELF,Vector(fX+5.0,fY+0.0,fZ+0.2),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(OBJECT_SELF,Vector(fX+5.0,fY+10.0,fZ+0.2),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(OBJECT_SELF,Vector(fX+15.0,fY+0.0,fZ+0.2),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road005",Location(OBJECT_SELF,Vector(fX+25.0,fY+0.0,fZ+0.2),fF+180.0));SetLocalInt(oPla,"DontSave",1);
// Trees
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX-34.5,fY-13.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX-32.5,fY+29.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX-19.0,fY+5.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX-3.5,fY+6.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX+0.0,fY+36.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX+10.0,fY+6.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX+19.0,fY-14.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX+23.0,fY-37.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX+31.5,fY+30.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX+33.0,fY+21.8,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree021",Location(OBJECT_SELF,Vector(fX+35.5,fY-14.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
// Walls
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX-37.0,fY-20.0,fZ+0.0),fF+20.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX-37.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX-37.0,fY+20.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX-30.0,fY+40.0,fZ+0.0),fF+340.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX-30.0,fY-40.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall044",Location(OBJECT_SELF,Vector(fX-14.3,fY-34.25,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX-10.0,fY+40.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall005",Location(OBJECT_SELF,Vector(fX-10.0,fY-40.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall051",Location(OBJECT_SELF,Vector(fX+0.0,fY-40.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX+10.0,fY+40.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX+10.0,fY-40.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX+30.0,fY-40.0,fZ+0.0),fF+160.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX+30.0,fY+40.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX+37.0,fY+20.0,fZ+0.0),fF+200.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX+37.0,fY+0.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2wall001",Location(OBJECT_SELF,Vector(fX+37.0,fY-20.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
  }
// Commoners
while(i<50){i++;if(Random(2)==1){s = "fe";}else{s = "";}oNew = CreateObject(OBJECT_TYPE_CREATURE,"commoner_"+s+"male",Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0));SetLocalInt(oNew,"DontSave",1);}
 }
////////////////////////////////////////////////////////////////////////////////
// Temple
else if(GetStringLeft(sInterest,5)=="2_A_1")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building027",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door005",Location(OBJECT_SELF,Vector(fX-0.95,fY-11.5,fZ+0.3),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
 }

// Cave + Cliff
else if(GetStringLeft(sInterest,5)=="2_A_2")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+17.0,fY-27.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tno_cliff_1",Location(OBJECT_SELF,Vector(fX-10.0,fY-20.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tno_cliff_2",Location(OBJECT_SELF,Vector(fX+7.5,fY+0.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tno_cliff_2",Location(OBJECT_SELF,Vector(fX+9.0,fY-20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tno_cliff_2",Location(OBJECT_SELF,Vector(fX-12.0,fY+0.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
 }

// Pyramid
else if(GetStringLeft(sInterest,5)=="2_A_3")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-24.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ziggurat004",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ziggurattemp",Location(OBJECT_SELF,Vector(fX+0.0,fY-22.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX-25.0,fY-25.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX-25.0,fY-25.0,fZ+6.8),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX-25.0,fY-25.0,fZ+13.6),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX-25.0,fY+25.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX-25.0,fY+25.0,fZ+6.8),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX-25.0,fY+25.0,fZ+13.6),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX+25.0,fY-25.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX+25.0,fY-25.0,fZ+6.8),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX+25.0,fY-25.0,fZ+13.6),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX+25.0,fY+25.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX+25.0,fY+25.0,fZ+6.8),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"the_ccp_plac026",Location(OBJECT_SELF,Vector(fX+25.0,fY+25.0,fZ+13.6),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solwhite",Location(OBJECT_SELF,Vector(fX-25.0,fY-25.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solwhite",Location(OBJECT_SELF,Vector(fX-25.0,fY+25.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solwhite",Location(OBJECT_SELF,Vector(fX+25.0,fY-25.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solwhite",Location(OBJECT_SELF,Vector(fX+25.0,fY+25.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
 }

// Old Castle
else if(GetStringLeft(sInterest,5)=="2_A_4")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-18.2,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building014",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door006",Location(OBJECT_SELF,Vector(fX-2.0,fY-16.5,fZ+0.4),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
 }

// Crypt
else if(GetStringLeft(sInterest,5)=="2_A_5")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-6.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building015",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door006",Location(OBJECT_SELF,Vector(fX-2.0,fY-6.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
 }

// White tower
else if(GetStringLeft(sInterest,5)=="2_A_6")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-8.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_lighttower",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
 }

// Black tower
else if(GetStringLeft(sInterest,5)=="2_A_7")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-8.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_darktower",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
 }

// Underground dungeon
else if(GetStringLeft(sInterest,5)=="2_A_8")
 {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-8.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building024",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door004",Location(OBJECT_SELF,Vector(fX-0.75,fY-7.25,fZ+0.4),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
 }
////////////////////////////////////////////////////////////////////////////////
// Castle
else if(GetStringLeft(sInterest,1)=="3")
 {
if(iNight==0)
  {
fX = fX-40.0;fY = fY-40.0;

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+40.0,fY+15.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+40.0,fY+19.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+40.0,fY+18.0,fZ+5.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+45.5,fY+45.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+45.5,fY+55.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+45.5,fY+65.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+55.5,fY+45.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+55.5,fY+55.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+55.5,fY+65.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+65.5,fY+45.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+65.5,fY+55.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+65.5,fY+65.5,fZ+29.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+15.0,fY+16.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_floor5",Location(OBJECT_SELF,Vector(fX+15.0,fY+16.0,fZ+5.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door002",Location(OBJECT_SELF,Vector(fX+39.9,fY+53.5,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);SetLocalObject(OBJECT_SELF,"Door3",oPla);SetLocalInt(oPla,"Door",3);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door003",Location(OBJECT_SELF,Vector(fX+61.5,fY+40.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalObject(OBJECT_SELF,"Door1",oPla);SetLocalInt(oPla,"Door",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door003",Location(OBJECT_SELF,Vector(fX+15.5,fY+17.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalObject(OBJECT_SELF,"Door2",oPla);SetLocalInt(oPla,"Door",2);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+25.0,fY+64.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+32.5,fY+64.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_house5",Location(OBJECT_SELF,Vector(fX+26.9,fY+19.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_house3",Location(OBJECT_SELF,Vector(fX+20.0,fY+57.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_house3",Location(OBJECT_SELF,Vector(fX+20.0,fY+47.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_house3",Location(OBJECT_SELF,Vector(fX+20.0,fY+37.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keepgate",Location(OBJECT_SELF,Vector(fX+40.0,fY+12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keepgate",Location(OBJECT_SELF,Vector(fX+40.0,fY+22.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keepgate",Location(OBJECT_SELF,Vector(fX+14.9,fY+19.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+68.0,fY+12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+12.0,fY+12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+12.0,fY+68.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+68.0,fY+68.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+68.2,fY+44.8,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+44.8,fY+44.8,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+44.8,fY+68.2,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+45.0,fY+45.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+45.0,fY+68.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+68.0,fY+68.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_keeptower",Location(OBJECT_SELF,Vector(fX+68.0,fY+45.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+20.0,fY+12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+30.0,fY+12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+12.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+20.0,fY+68.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+30.0,fY+68.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+40.0,fY+68.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+68.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+68.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+30.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+40.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+50.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+60.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+12.0,fY+20.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+12.0,fY+30.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+12.0,fY+40.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+12.0,fY+50.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+12.0,fY+60.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+46.0,fY+19.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+34.0,fY+19.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+19.0,fY+16.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+42.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+42.0,fZ+6.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+42.0,fZ+12.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+42.0,fZ+18.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+42.0,fZ+24.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+42.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+42.0,fZ+6.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+42.0,fZ+12.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+42.0,fZ+18.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+42.0,fZ+24.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+68.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+68.0,fZ+6.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+68.0,fZ+12.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+68.0,fZ+18.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+50.0,fY+68.0,fZ+24.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+68.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+68.0,fZ+6.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+68.0,fZ+12.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+68.0,fZ+18.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+60.0,fY+68.0,fZ+24.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+50.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+50.0,fZ+6.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+50.0,fZ+12.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+50.0,fZ+18.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+50.0,fZ+24.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+60.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+60.0,fZ+6.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+60.0,fZ+12.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+60.0,fZ+18.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+42.0,fY+60.0,fZ+24.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+50.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+50.0,fZ+6.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+50.0,fZ+12.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+50.0,fZ+18.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+50.0,fZ+24.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+60.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+60.0,fZ+6.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+60.0,fZ+12.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+60.0,fZ+18.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wall",Location(OBJECT_SELF,Vector(fX+68.0,fY+60.0,fZ+24.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_006",Location(OBJECT_SELF,Vector(fX+33.5,fY+46.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_007",Location(OBJECT_SELF,Vector(fX+37.5,fY+47.6,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doortown001",Location(OBJECT_SELF,Vector(fX+40.0,fY+10.1,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_outhouse001",Location(OBJECT_SELF,Vector(fX+38.0,fY+63.5,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiportala",Location(OBJECT_SELF,Vector(fX+33.5,fY+57.05,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiportala",Location(OBJECT_SELF,Vector(fX+33.55,fY+49.95,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_blacksmith",Location(OBJECT_SELF,Vector(fX+50.0,fY+37.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+43.0,fY+9.85,fZ+2.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+37.0,fY+9.85,fZ+2.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+43.0,fY+24.15,fZ+2.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+37.0,fY+24.15,fZ+2.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+36.15,fY+17.0,fZ+1.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+43.85,fY+17.0,fZ+1.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+60.5,fY+22.15,fZ+0.5),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+63.5,fY+39.65,fZ+1.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+52.0,fY+33.85,fZ+1.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+38.3,fY+41.0,fZ+1.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+39.85,fY+51.0,fZ+1.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+39.85,fY+56.0,fZ+1.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+25.15,fY+57.0,fZ+0.5),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+25.15,fY+47.0,fZ+0.5),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+25.15,fY+37.0,fZ+0.5),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_torch001",Location(OBJECT_SELF,Vector(fX+18.0,fY+21.15,fZ+1.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+40.0,fY+68.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+68.0,fY+40.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+45.0,fY+45.0,fZ+25.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+60.0,fY+45.0,fZ+30.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+45.0,fY+65.0,fZ+35.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+41.0,fY+41.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+18.0,fY+65.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+18.0,fY+15.0,fZ+5.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+65.0,fY+15.0,fZ+10.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+72.0,fY+62.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+62.0,fY+72.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+72.0,fY+62.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_whitetower",Location(OBJECT_SELF,Vector(fX+62.0,fY+72.0,fZ+20.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_trebuchet",Location(OBJECT_SELF,Vector(fX+20.0,fY+30.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree022",Location(OBJECT_SELF,Vector(fX+40.0,fY+36.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree022",Location(OBJECT_SELF,Vector(fX+64.0,fY+29.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wagon001",Location(OBJECT_SELF,Vector(fX+45.0,fY+33.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_wagonwright",Location(OBJECT_SELF,Vector(fX+56.5,fY+19.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);

oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence011",Location(OBJECT_SELF,Vector(fX+39.0,fY+56.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence011",Location(OBJECT_SELF,Vector(fX+37.0,fY+56.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence011",Location(OBJECT_SELF,Vector(fX+35.0,fY+56.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence011",Location(OBJECT_SELF,Vector(fX+39.0,fY+51.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence011",Location(OBJECT_SELF,Vector(fX+37.0,fY+51.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence011",Location(OBJECT_SELF,Vector(fX+35.0,fY+51.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
  }
// Commoners
while(i<30){i++;if(Random(2)==1){s = "fe";}else{s = "";}oNew = CreateObject(OBJECT_TYPE_CREATURE,"commoner_"+s+"male",Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0));SetLocalInt(oNew,"DontSave",1);}
 }
////////////////////////////////////////////////////////////////////////////////
// Ruins
else if(GetStringLeft(sInterest,1)=="4")
 {
fF = fF-90.0;
// Roof
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+0.1,fY+0.0,fZ+5.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+5.0),fF+45.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+5.0),fF+315.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+0.1,fY+0.0,fZ+5.0),fF+290.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+0.1,fY+0.0,fZ+5.0),fF+250.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+5.0),fF+20.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+5.0),fF+340.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX-1.35,fY-4.5,fZ+5.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+1.35,fY-4.5,fZ+5.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX-1.35,fY+5.3,fZ+5.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+1.35,fY+5.3,fZ+5.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+4.0,fY+6.0,fZ+5.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX+4.0,fY+8.0,fZ+5.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX-4.0,fY+6.0,fZ+5.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_arch003",Location(OBJECT_SELF,Vector(fX-4.0,fY+8.0,fZ+5.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
// Buildings
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin5",Location(OBJECT_SELF,Vector(fX-29.0,fY-30.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin10",Location(OBJECT_SELF,Vector(fX-27.0,fY-10.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin8",Location(OBJECT_SELF,Vector(fX-26.0,fY+26.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ruine_bild",Location(OBJECT_SELF,Vector(fX-23.0,fY+12.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin12",Location(OBJECT_SELF,Vector(fX-21.0,fY-20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_thornwall",Location(OBJECT_SELF,Vector(fX-21.0,fY-1.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin6",Location(OBJECT_SELF,Vector(fX-20.0,fY-30.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin7",Location(OBJECT_SELF,Vector(fX-18.0,fY-6.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin4",Location(OBJECT_SELF,Vector(fX-11.0,fY-20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin5",Location(OBJECT_SELF,Vector(fX-1.5,fY-30.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-10.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house038",Location(OBJECT_SELF,Vector(fX+0.0,fY+25.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building032",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ-0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_bf_mark_003",Location(OBJECT_SELF,Vector(fX+7.0,fY-19.0,fZ-0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_aqueduct3",Location(OBJECT_SELF,Vector(fX+10.0,fY-30.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building003",Location(OBJECT_SELF,Vector(fX+21.0,fY-1.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2house019",Location(OBJECT_SELF,Vector(fX+23.0,fY+22.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin1",Location(OBJECT_SELF,Vector(fX+24.0,fY-24.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_thornwall",Location(OBJECT_SELF,Vector(fX+27.6,fY-17.4,fZ-0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
// Waypoints
oPla = CreateObject(OBJECT_TYPE_WAYPOINT,"wp_ruins",Location(OBJECT_SELF,Vector(fX-28.0,fY-10.0,fZ+0.1),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_WAYPOINT,"wp_ruins",Location(OBJECT_SELF,Vector(fX-26.0,fY+26.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_WAYPOINT,"wp_ruins",Location(OBJECT_SELF,Vector(fX+4.0,fY+31.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_WAYPOINT,"wp_ruins",Location(OBJECT_SELF,Vector(fX+24.0,fY-3.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_WAYPOINT,"wp_ruins",Location(OBJECT_SELF,Vector(fX+28.0,fY-28.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
 }
////////////////////////////////////////////////////////////////////////////////
// Animal reserve
else if(GetStringLeft(sInterest,1)=="5")
 {
if(iNight==0)
  {
fF = fF-90.0;
// Fences
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-34.0,fY+3.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-34.0,fY+7.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-34.0,fY+11.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-34.0,fY+15.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-33.9,fY-3.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-33.9,fY-7.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-33.9,fY-11.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-33.9,fY-15.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-32.2,fY-17.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-32.2,fY+17.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-31.8,fY-1.9,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-31.8,fY+1.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-27.8,fY-1.9,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-27.8,fY+1.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-22.4,fY-1.9,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-22.3,fY+1.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-18.4,fY-1.9,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-18.3,fY+1.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-17.8,fY-17.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-17.8,fY+17.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY+3.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY+7.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY+11.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY+15.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY-3.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY-7.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY-11.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-16.0,fY-15.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-4.8,fY-9.7,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-5.3,fY-29.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-7.1,fY-15.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-7.1,fY-11.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-7.1,fY-19.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-7.1,fY-23.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX-7.1,fY-27.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+0.8,fY-9.7,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+4.8,fY-9.7,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+5.3,fY-29.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+7.1,fY-15.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+7.1,fY-11.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+7.1,fY-19.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+7.1,fY-23.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+7.1,fY-27.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.0,fY+3.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.0,fY+7.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.0,fY+11.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.0,fY+15.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.1,fY-3.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.1,fY-7.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.1,fY-11.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+16.1,fY-15.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+17.8,fY+17.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+17.8,fY-17.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+18.2,fY-1.9,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+18.2,fY+1.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+22.2,fY-1.9,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+22.2,fY+1.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+27.6,fY-1.9,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+27.7,fY+1.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+31.6,fY-1.9,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+31.7,fY+1.8,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+32.3,fY-18.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+32.3,fY+17.8,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY+3.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY+7.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY+11.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY+15.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY-3.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY-7.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY-11.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(OBJECT_SELF,Vector(fX+34.0,fY-15.7,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
// Houses & Doors
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_house2",Location(OBJECT_SELF,Vector(fX+0.0,fY+20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorinvisible",Location(OBJECT_SELF,Vector(fX-25.0,fY+2.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetName(oPla," ");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorinvisible",Location(OBJECT_SELF,Vector(fX-25.0,fY-2.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetName(oPla," ");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorinvisible",Location(OBJECT_SELF,Vector(fX+25.0,fY+2.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetName(oPla," ");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorinvisible",Location(OBJECT_SELF,Vector(fX+25.0,fY-2.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetName(oPla," ");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"doorinvisible",Location(OBJECT_SELF,Vector(fX-2.0,fY-10.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetName(oPla," ");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors011",Location(OBJECT_SELF,Vector(fX+25.0,fY+12.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors011",Location(OBJECT_SELF,Vector(fX-25.0,fY+12.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors011",Location(OBJECT_SELF,Vector(fX-25.0,fY-12.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors011",Location(OBJECT_SELF,Vector(fX+25.0,fY-12.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_doors011",Location(OBJECT_SELF,Vector(fX+0.0,fY-20.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cabin001",Location(OBJECT_SELF,Vector(fX+25.0,fY+15.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cabin001",Location(OBJECT_SELF,Vector(fX+25.0,fY-15.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cabin001",Location(OBJECT_SELF,Vector(fX-25.0,fY+15.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cabin001",Location(OBJECT_SELF,Vector(fX-25.0,fY-15.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cabin001",Location(OBJECT_SELF,Vector(fX+0.0,fY-25.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_outhouse001",Location(OBJECT_SELF,Vector(fX+5.0,fY-12.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_outhouse001",Location(OBJECT_SELF,Vector(fX+32.0,fY-5.5,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_outhouse001",Location(OBJECT_SELF,Vector(fX+18.0,fY+4.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_outhouse001",Location(OBJECT_SELF,Vector(fX-18.0,fY+4.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_outhouse001",Location(OBJECT_SELF,Vector(fX-32.0,fY-4.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_billboard8",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Animal Reserve");
// Trees
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree060",Location(OBJECT_SELF,Vector(fX-20.0,fY-25.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree060",Location(OBJECT_SELF,Vector(fX-20.0,fY+25.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree060",Location(OBJECT_SELF,Vector(fX+20.0,fY+25.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree060",Location(OBJECT_SELF,Vector(fX+20.0,fY-25.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_dirt02",Location(OBJECT_SELF,Vector(fX-25.0,fY+7.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_dirt02",Location(OBJECT_SELF,Vector(fX-25.0,fY-7.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_dirt02",Location(OBJECT_SELF,Vector(fX+25.0,fY+7.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_dirt02",Location(OBJECT_SELF,Vector(fX+25.0,fY-7.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_dirt02",Location(OBJECT_SELF,Vector(fX+0.0,fY-15.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
  }
if(GetIsDay())
  {
// Pet boy
oPla = CreateObject(OBJECT_TYPE_CREATURE,"anikeeper",Location(OBJECT_SELF,Vector(fX+0.0,fY+5.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Pen",6);AssignCommand(oPla,ActionRandomWalk());
// Animals
if(GetLocalInt(oModule,sPlanet+sArea+"ReserveIni")!=1){SetLocalInt(oModule,sPlanet+sArea+"Pen1",Random(6)+10);SetLocalInt(oModule,sPlanet+sArea+"Pen2",Random(6)+10);SetLocalInt(oModule,sPlanet+sArea+"Pen3",Random(6)+10);SetLocalInt(oModule,sPlanet+sArea+"Pen4",Random(6)+10);SetLocalInt(oModule,sPlanet+sArea+"Pen5",Random(6)+10);SetLocalInt(oModule,sPlanet+sArea+"ReserveIni",1);}
iReserveRand1 = StringToInt(GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_B_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_B_")))-FindSubString(sInterest,"_A_")-3));
if(iReserveRand1>=1){fX2 = 0.0;fY2 = -15.0;iReserveRand2 = StringToInt(GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_C_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_C_")))-FindSubString(sInterest,"_B_")-3));iReserveRand3 = GetLocalInt(oModule,sPlanet+sArea+"Pen1");if(iReserveRand2==1){sReserveAni = "mn_deer002";}else if(iReserveRand2==2){sReserveAni = "mn_wildbeef002";}else if(iReserveRand2==3){sReserveAni = "mn_small_ani001";}else if(iReserveRand2==4){sReserveAni = "mn_bear001";}else if(iReserveRand2==5){sReserveAni = "mn_boar002";}else if(iReserveRand2==6){sReserveAni = "mn_goat001";}while(iReserveRand3>0){oPla = CreateObject(OBJECT_TYPE_CREATURE,sReserveAni,Location(OBJECT_SELF,Vector(fX+fX2,fY+fY2,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);SetPlotFlag(oPla,TRUE);ChangeToStandardFaction(oPla,STANDARD_FACTION_MERCHANT);SetLocalInt(oPla,"Pen",1);AssignCommand(oPla,ActionRandomWalk());iReserveRand3--;}}
if(iReserveRand1>=2){fX2 = -25.0;fY2 = 8.0;iReserveRand2 = StringToInt(GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_D_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_D_")))-FindSubString(sInterest,"_C_")-3));iReserveRand3 = GetLocalInt(oModule,sPlanet+sArea+"Pen2");if(iReserveRand2==1){sReserveAni = "mn_deer002";}else if(iReserveRand2==2){sReserveAni = "mn_wildbeef002";}else if(iReserveRand2==3){sReserveAni = "mn_small_ani001";}else if(iReserveRand2==4){sReserveAni = "mn_bear001";}else if(iReserveRand2==5){sReserveAni = "mn_boar002";}else if(iReserveRand2==6){sReserveAni = "mn_goat001";}while(iReserveRand3>0){oPla = CreateObject(OBJECT_TYPE_CREATURE,sReserveAni,Location(OBJECT_SELF,Vector(fX+fX2,fY+fY2,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);SetPlotFlag(oPla,TRUE);ChangeToStandardFaction(oPla,STANDARD_FACTION_MERCHANT);SetLocalInt(oPla,"Pen",2);AssignCommand(oPla,ActionRandomWalk());iReserveRand3--;}}
if(iReserveRand1>=3){fX2 = 25.0;fY2 = -7.0;iReserveRand2 = StringToInt(GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_E_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_E_")))-FindSubString(sInterest,"_D_")-3));iReserveRand3 = GetLocalInt(oModule,sPlanet+sArea+"Pen3");if(iReserveRand2==1){sReserveAni = "mn_deer002";}else if(iReserveRand2==2){sReserveAni = "mn_wildbeef002";}else if(iReserveRand2==3){sReserveAni = "mn_small_ani001";}else if(iReserveRand2==4){sReserveAni = "mn_bear001";}else if(iReserveRand2==5){sReserveAni = "mn_boar002";}else if(iReserveRand2==6){sReserveAni = "mn_goat001";}while(iReserveRand3>0){oPla = CreateObject(OBJECT_TYPE_CREATURE,sReserveAni,Location(OBJECT_SELF,Vector(fX+fX2,fY+fY2,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);SetPlotFlag(oPla,TRUE);ChangeToStandardFaction(oPla,STANDARD_FACTION_MERCHANT);SetLocalInt(oPla,"Pen",3);AssignCommand(oPla,ActionRandomWalk());iReserveRand3--;}}
if(iReserveRand1>=4){fX2 = -25.0;fY2 = -7.0;iReserveRand2 = StringToInt(GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_F_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_F_")))-FindSubString(sInterest,"_E_")-3));iReserveRand3 = GetLocalInt(oModule,sPlanet+sArea+"Pen4");if(iReserveRand2==1){sReserveAni = "mn_deer002";}else if(iReserveRand2==2){sReserveAni = "mn_wildbeef002";}else if(iReserveRand2==3){sReserveAni = "mn_small_ani001";}else if(iReserveRand2==4){sReserveAni = "mn_bear001";}else if(iReserveRand2==5){sReserveAni = "mn_boar002";}else if(iReserveRand2==6){sReserveAni = "mn_goat001";}while(iReserveRand3>0){oPla = CreateObject(OBJECT_TYPE_CREATURE,sReserveAni,Location(OBJECT_SELF,Vector(fX+fX2,fY+fY2,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);SetPlotFlag(oPla,TRUE);ChangeToStandardFaction(oPla,STANDARD_FACTION_MERCHANT);SetLocalInt(oPla,"Pen",4);AssignCommand(oPla,ActionRandomWalk());iReserveRand3--;}}
if(iReserveRand1>=5){fX2 = 25.0;fY2 = 8.0;iReserveRand2 = StringToInt(GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_G_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_G_")))-FindSubString(sInterest,"_F_")-3));iReserveRand3 = GetLocalInt(oModule,sPlanet+sArea+"Pen5");if(iReserveRand2==1){sReserveAni = "mn_deer002";}else if(iReserveRand2==2){sReserveAni = "mn_wildbeef002";}else if(iReserveRand2==3){sReserveAni = "mn_small_ani001";}else if(iReserveRand2==4){sReserveAni = "mn_bear001";}else if(iReserveRand2==5){sReserveAni = "mn_boar002";}else if(iReserveRand2==6){sReserveAni = "mn_goat001";}while(iReserveRand3>0){oPla = CreateObject(OBJECT_TYPE_CREATURE,sReserveAni,Location(OBJECT_SELF,Vector(fX+fX2,fY+fY2,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);SetPlotFlag(oPla,TRUE);ChangeToStandardFaction(oPla,STANDARD_FACTION_MERCHANT);SetLocalInt(oPla,"Pen",5);AssignCommand(oPla,ActionRandomWalk());iReserveRand3--;}}
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Resource mountain
else if(GetStringLeft(sInterest,1)=="6")
 {
fF = fF-90.0;
// Mounts
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface002",Location(OBJECT_SELF,Vector(fX-15.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface003",Location(OBJECT_SELF,Vector(fX-3.5,fY-21.5,fZ+0.34),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface001",Location(OBJECT_SELF,Vector(fX-3.0,fY-5.0,fZ+10.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface001",Location(OBJECT_SELF,Vector(fX-1.0,fY+6.0,fZ-0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface004",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ+20.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface002",Location(OBJECT_SELF,Vector(fX+0.0,fY+15.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface002",Location(OBJECT_SELF,Vector(fX+0.0,fY-15.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface001",Location(OBJECT_SELF,Vector(fX+1.0,fY-6.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface001",Location(OBJECT_SELF,Vector(fX+3.0,fY+5.0,fZ+10.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2rockface002",Location(OBJECT_SELF,Vector(fX+15.0,fY+0.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
// Others
oPla = CreateObject(OBJECT_TYPE_CREATURE,"reskeeper",Location(OBJECT_SELF,Vector(fX+2.0,fY-27.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_STORE,"storemountain",Location(OBJECT_SELF,Vector(fX+2.0,fY-27.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"door002",Location(OBJECT_SELF,Vector(fX+4.9,fY-23.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin4",Location(OBJECT_SELF,Vector(fX+2.5,fY-18.05,fZ-1.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin4",Location(OBJECT_SELF,Vector(fX+7.3,fY-18.05,fZ-1.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_ruin11",Location(OBJECT_SELF,Vector(fX+2.8,fY-18.0,fZ-1.05),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_outhouse001",Location(OBJECT_SELF,Vector(fX-1.0,fY-26.5,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_rail002",Location(OBJECT_SELF,Vector(fX-5.95,fY-30.95,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_rail006",Location(OBJECT_SELF,Vector(fX-1.95,fY-30.95,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_rail001",Location(OBJECT_SELF,Vector(fX+5.0,fY-30.95,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_rail006",Location(OBJECT_SELF,Vector(fX+5.0,fY-24.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wagon003",Location(OBJECT_SELF,Vector(fX-6.0,fY-30.95,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wagon003",Location(OBJECT_SELF,Vector(fX-4.0,fY-30.95,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wagon003",Location(OBJECT_SELF,Vector(fX-2.0,fY-30.95,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
 }
////////////////////////////////////////////////////////////////////////////////
// Amusement Place
else if(GetStringLeft(sInterest,1)=="7")
 {
fF = fF-90.0;
// Placeables
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-4.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_sign028",Location(OBJECT_SELF,Vector(fX-2.5,fY-1.0,fZ+2.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"The Gamblers Paradise");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-29.05,fY+2.45,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-29.0,fY-2.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-28.85,fY+11.955,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-28.8,fY+7.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_008",Location(OBJECT_SELF,Vector(fX-27.0,fY-19.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_list008",Location(OBJECT_SELF,Vector(fX-25.0,fY+0.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree031",Location(OBJECT_SELF,Vector(fX-25.0,fY-25.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree031",Location(OBJECT_SELF,Vector(fX-25.0,fY+25.0,fZ-0.05),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent013",Location(OBJECT_SELF,Vector(fX-25.0,fY-10.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"x3_plc_list008",Location(OBJECT_SELF,Vector(fX-25.0,fY+10.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent004",Location(OBJECT_SELF,Vector(fX-22.0,fY-22.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-21.55,fY+2.45,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-21.5,fY-2.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-21.35,fY+11.95,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence013",Location(OBJECT_SELF,Vector(fX-21.3,fY+7.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent017",Location(OBJECT_SELF,Vector(fX-19.0,fY-14.0,fZ+0.0),fF+120.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_campfr001",Location(OBJECT_SELF,Vector(fX-16.0,fY-20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_013",Location(OBJECT_SELF,Vector(fX-15.0,fY-26.0,fZ+0.0),fF+135.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_telescope",Location(OBJECT_SELF,Vector(fX-10.0,fY+0.0,fZ+0.0),fF+225.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_013",Location(OBJECT_SELF,Vector(fX-10.0,fY-20.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfr",Location(OBJECT_SELF,Vector(fX-6.5,fY-1.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2building039",Location(OBJECT_SELF,Vector(fX+0.0,fY+15.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codifortwheel",Location(OBJECT_SELF,Vector(fX+9.0,fY+1.5,fZ+0.0),fF+305.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent004",Location(OBJECT_SELF,Vector(fX+10.0,fY-14.0,fZ-0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent004",Location(OBJECT_SELF,Vector(fX+10.0,fY-20.0,fZ-0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent004",Location(OBJECT_SELF,Vector(fX+10.0,fY-26.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent014",Location(OBJECT_SELF,Vector(fX+13.0,fY+5.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2stable001",Location(OBJECT_SELF,Vector(fX+14.0,fY+17.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2stable001",Location(OBJECT_SELF,Vector(fX+14.0,fY+12.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_campfr001",Location(OBJECT_SELF,Vector(fX+20.0,fY-22.0,fZ-0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_013",Location(OBJECT_SELF,Vector(fX+20.0,fY-15.0,fZ+0.0),fF+200.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"crpp_ropebundle",Location(OBJECT_SELF,Vector(fX+22.4,fY-1.6,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_006",Location(OBJECT_SELF,Vector(fX+24.0,fY-15.0,fZ+0.0),fF+250.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nwn2well002",Location(OBJECT_SELF,Vector(fX+25.0,fY+0.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree031",Location(OBJECT_SELF,Vector(fX+25.0,fY-25.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tree031",Location(OBJECT_SELF,Vector(fX+25.0,fY+25.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent004",Location(OBJECT_SELF,Vector(fX+26.0,fY+12.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"ccp_crane",Location(OBJECT_SELF,Vector(fX+28.0,fY+19.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_ce_car_012",Location(OBJECT_SELF,Vector(fX+28.5,fY+22.5,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+22.0,fY+0.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Well",1);
// Signs
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX-19.5,fY-6.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"The Race");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX-11.0,fY-15.0,fZ+0.0),fF+225.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"The Charade");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX-8.5,fY-3.5,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"The Astronom");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX+12.0,fY+0.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"The Fortune Wheel");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX+17.0,fY-28.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"The 3 Questions");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX+18.0,fY+15.0,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Horses Field");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX+22.0,fY-4.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"The Well");
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_placard5",Location(OBJECT_SELF,Vector(fX+23.0,fY+15.0,fZ+0.0),fF+45.0));SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Find and Run");
// Creatures
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX-25.0,fY-7.0,fZ+0.0),fF+90.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",1);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX-15.5,fY-18.0,fZ+0.0),fF+35.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",2);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX-8.5,fY-1.0,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",3);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX+11.0,fY+1.5,fZ+0.0),fF+270.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",4);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX+18.0,fY-20.0,fZ+0.0),fF+140.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",5);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX+18.5,fY+15.0,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",6);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX+22.5,fY-2.5,fZ+0.0),fF+180.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",7);SetLocalString(oPla,"PC",GetLocalString(oModule,sPlanet+sArea+"Game7PC"));
oPla = CreateObject(OBJECT_TYPE_CREATURE,"player",Location(OBJECT_SELF,Vector(fX+24.0,fY+18.0,fZ+0.0),fF+225.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Player",8);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"mn_wildhorse004",Location(OBJECT_SELF,Vector(fX+15.8,fY+11.3,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"mn_wildhorse004",Location(OBJECT_SELF,Vector(fX+15.8,fY+18.6,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"mn_wildhorse004",Location(OBJECT_SELF,Vector(fX+16.8,fY+13.3,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);
oPla = CreateObject(OBJECT_TYPE_CREATURE,"mn_wildhorse004",Location(OBJECT_SELF,Vector(fX+16.8,fY+16.5,fZ+0.0),fF+0.0));SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Stop",1);SetLocalInt(oPla,"NotFlee",1);
 }
////////////////////////////////////////////////////////////////////////////////
if(sInterests!=""){SetLocalInt(OBJECT_SELF,"NoCamp",1);}
////////////////////////////////////////////////////////////////////////////////
}
