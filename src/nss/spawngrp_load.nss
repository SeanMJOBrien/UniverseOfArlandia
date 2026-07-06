#include "aps_include"
// ---------------------------------------------------------------------------
// Spawn-group re-stamp engine.
//
// Rebuilds a saved spawn group (see spawngrp_save.nss) into OBJECT_SELF (an
// area), centred on the area middle and flagged as a camp so the existing camp
// despawn / lifecycle wiring applies (SetLocalInt(o,"Camp",1); the "Camp" flag
// is what area_recall / conv_domain002 / conv_dm020 use to clean up).
//
// Caller supplies on the area, before running:
//   string "SpawnGrpLoad"       - a specific group name to stamp; if empty a
//                                  random registered group is picked
//   int    "SpawnGrpLevelGate"  - only groups whose MinLevel <= this are
//                                  eligible for the random pick
// On success sets int "SpawnGrpLoaded"=1 on the area (area_creatures reads this
// to know a data-driven camp replaced the hardcoded one). Both input locals are
// consumed. Objects are recreated from the "SpawnGroups" campaign DB, so their
// captured equipment and locals come back intact.
// ---------------------------------------------------------------------------

void main()
{
object oModule = GetModule();
object oArea = OBJECT_SELF;
string sCampaign = "SpawnGroups";

DeleteLocalInt(oArea,"SpawnGrpLoaded");

string sGroup = GetLocalString(oArea,"SpawnGrpLoad");
int iGate = GetLocalInt(oArea,"SpawnGrpLevelGate");

// No explicit group: pick a random one whose MinLevel is within the gate.
if(sGroup=="")
 {
 int iTot = GetPersistentInt(oModule,"SpawnGroupsTot");
 if(iTot<1){return;}
 int n;int iEl;
 for(n=1;n<=iTot;n++)
  {
  string sName = GetPersistentString(oModule,"SpawnGroup"+IntToString(n));
  if(sName==""){continue;}
  if(GetPersistentInt(oModule,"SpawnGrp&"+sName+"&Count")<1){continue;}
  if(GetPersistentInt(oModule,"SpawnGrp&"+sName+"&MinLevel")<=iGate){iEl++;SetLocalString(oArea,"_SGEl"+IntToString(iEl),sName);}
  }
 if(iEl>0){sGroup = GetLocalString(oArea,"_SGEl"+IntToString(Random(iEl)+1));}
 int e;for(e=1;e<=iEl;e++){DeleteLocalString(oArea,"_SGEl"+IntToString(e));}
 if(sGroup==""){return;}
 }

string sKey = "SpawnGrp&"+sGroup+"&";
int iCount = GetPersistentInt(oModule,sKey+"Count");
if(iCount<1){return;}

// Same origin/terrain-height logic as the hardcoded camps in area_creatures.
float fX = IntToFloat(GetAreaSize(AREA_WIDTH,oArea)*10)/2.0;
float fY = IntToFloat(GetAreaSize(AREA_HEIGHT,oArea)*10)/2.0;
float fZ = 0.0;if(GetStringLeft(GetTag(oArea),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")){fZ = 5.0;}

int i;int iMade;
for(i=1;i<=iCount;i++)
 {
 string sGeo = GetPersistentString(oModule,sKey+"Geo"+IntToString(i));
 if(sGeo==""){continue;}
 float fDX = StringToFloat(GetStringLeft(sGeo,FindSubString(sGeo,"_A_")));
 float fDY = StringToFloat(GetStringRight(GetStringLeft(sGeo,FindSubString(sGeo,"_B_")),GetStringLength(GetStringLeft(sGeo,FindSubString(sGeo,"_B_")))-FindSubString(sGeo,"_A_")-3));
 float fF = StringToFloat(GetStringRight(GetStringLeft(sGeo,FindSubString(sGeo,"_C_")),GetStringLength(GetStringLeft(sGeo,FindSubString(sGeo,"_C_")))-FindSubString(sGeo,"_B_")-3));
 object oNew = RetrieveCampaignObject(sCampaign,sGroup+"_o"+IntToString(i),Location(oArea,Vector(fX+fDX,fY+fDY,fZ),fF));
 if(GetIsObjectValid(oNew)){SetLocalInt(oNew,"Camp",1);iMade++;}
 }

if(iMade>0){SetLocalInt(oArea,"SpawnGrpLoaded",1);}
DeleteLocalString(oArea,"SpawnGrpLoad");DeleteLocalInt(oArea,"SpawnGrpLevelGate");
}
