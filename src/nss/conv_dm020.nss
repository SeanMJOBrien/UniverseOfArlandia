#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sName = GetName(oPC)+GetPCPublicCDKey(oPC);
int iNPCs = GetCampaignInt(sName,"NPCs");
int iFly = GetLocalInt(oPC,"Flying_Cre");
object oObject = GetFirstObjectInArea(oArea);
//
object oTarget = GetLocalObject(oPC,"oTarget");
string sBP = GetResRef(oTarget);
string sTag = GetTag(oTarget);
string sNPCName = GetName(oTarget);
int iStop = GetLocalInt(oTarget,"Stop");
int iType = GetObjectType(oTarget);
//
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
int iChoice4 = GetLocalInt(OBJECT_SELF,"Choice4");
int iChoice5 = GetLocalInt(OBJECT_SELF,"Choice5");
int iChoice6 = GetLocalInt(OBJECT_SELF,"Choice6");
int iChoice7 = GetLocalInt(OBJECT_SELF,"Choice7");
int iChoice8 = GetLocalInt(OBJECT_SELF,"Choice8");
int iChoice9 = GetLocalInt(OBJECT_SELF,"Choice9");
//
location lTarget = GetLocalLocation(oPC,"lTarget");
location lTarget1 = GetLocalLocation(oPC,"Loc1");
location lTarget2 = GetLocalLocation(oPC,"Loc2");
vector v1 = GetPositionFromLocation(lTarget1);float fv1x = v1.x;float fv1y = v1.y;float fv1z = v1.z;
vector v2 = GetPositionFromLocation(lTarget2);float fv2x = v2.x;float fv2y = v2.y;float fv2z = v2.z;
float fAx;if(fv1x>=fv2x){fAx = fv1x-fv2x;}else{fAx = fv2x-fv1x;}
float fAy;if(fv1y>=fv2y){fAy = fv1y-fv2y;}else{fAy = fv2y-fv1y;}
float X;float Y;float Z;float F;float X2;float Y2;float Z2;
//
int iPrix = FloatToInt(fAx+fAy);
//
float fv1f;float h;float Const;string s;string s1;string s2;string s3;object oNPC;string sNPC1;string sNPC2;int iNPCNum;int iDep;int iN;int i;int j;object oItem;object oPla;float fZ;location l1;location l2;object oNew;string sInterest;string sVar;
////////////////////////////////////////////////////////////////////////////////
// Creatures
if(iChoice1==1)
 {
////////////////////////////////////////////////////////////////////////////////
// Recall creatures
if(iChoice2==1)
  {
iChoice3 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep-1));
iChoice4 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
i = (iNPCs+1)-(iChoice3+(10*(iStep-4)));
     if(iChoice4==4){iChoice4 = 5;}
else if(iChoice4==5){iChoice4 = 10;}
else if(iChoice4==6){iChoice4 = 20;}
else if(iChoice4==7){iChoice4 = 50;}
while(iN<iChoice4)
   {
iN++;
oNPC = RetrieveCampaignObject(sName,"NPC"+IntToString(i),lTarget);
sNPC1 = GetCampaignString(sName,"NPCName"+IntToString(i));
sNPC2 = GetCampaignString(sName,"NPCMaster"+IntToString(i));
iDep = GetCampaignInt(sName,"NPCStop"+IntToString(i));
//
SetLocalInt(oNPC,"Remains",1);
SetName(oNPC,sNPC1);
SetLocalString(oNPC,"Master",sNPC2);
SetLocalInt(oNPC,"Stop",iDep);
SetLocalInt(oNPC,"Num",i);
if(iN==1){SetLocalObject(oPC,"oTarget",oNPC);}
   }
AssignCommand(oPC,ActionStartConversation(oPC,"dm",TRUE,FALSE));
  }
////////////////////////////////////////////////////////////////////////////////
// Destroy creatures
else if(iChoice2==2)
  {
iChoice3 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
i = (iNPCs+1)-(iChoice3+(10*(iStep-3)));
while(i<iNPCs)
   {
oNPC = RetrieveCampaignObject(sName,"NPC"+IntToString(i+1),lTarget);
sNPC1 = GetCampaignString(sName,"NPCName"+IntToString(i+1));
sNPC2 = GetCampaignString(sName,"NPCMaster"+IntToString(i+1));
iDep = GetCampaignInt(sName,"NPCStop"+IntToString(i+1));
//
SetLocalInt(oNPC,"Remains",1);
StoreCampaignObject(sName,"NPC"+IntToString(i),oNPC);
SetCampaignString(sName,"NPCName"+IntToString(i),sNPC1);
SetCampaignString(sName,"NPCMaster"+IntToString(i),sNPC2);
SetCampaignInt(sName,"NPCStop"+IntToString(i),iDep);
AssignCommand(oNPC,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oNPC);
i++;
   }
DeleteCampaignVariable(sName,"NPC"+IntToString(iNPCs));
DeleteCampaignVariable(sName,"NPCName"+IntToString(iNPCs));
DeleteCampaignVariable(sName,"NPCMaster"+IntToString(iNPCs));
DeleteCampaignVariable(sName,"NPCStop"+IntToString(iNPCs));
SetCampaignInt(sName,"NPCs",iNPCs-1);
  }
////////////////////////////////////////////////////////////////////////////////
// Land creatures
else if(iChoice2==3)
  {
while(iFly>0)
   {
oNew = CreateObject(OBJECT_TYPE_CREATURE,GetLocalString(oPC,IntToString(iFly)+"BP"),lTarget,FALSE,GetLocalString(oPC,IntToString(iFly)+"Tag"));
if(GetName(oNew)!=GetLocalString(oPC,IntToString(iFly)+"Name")){SetName(oNew,GetLocalString(oPC,IntToString(iFly)+"Name"));}
SetLocalInt(oNew,"Persistent",GetLocalInt(oPC,IntToString(iFly)+"Persistent"));
SetLocalInt(oNew,"Stop",GetLocalInt(oPC,IntToString(iFly)+"Stop"));
SetLocalString(oNew,"Master",GetLocalString(oPC,IntToString(iFly)+"Master"));
SetLocalInt(oNew,"HitPoints",GetLocalInt(oPC,IntToString(iFly)+"HitPoints"));
SetLocalString(oNew,"Var",GetLocalString(oPC,IntToString(iFly)+"Var"));
SetLocalInt(oNew,"Hench",GetLocalInt(oPC,IntToString(iFly)+"Hench"));
SetLocalInt(oNew,"HenchNum",GetLocalInt(oPC,IntToString(iFly)+"HenchNum"));
SetLocalInt(oNew,"Camp",GetLocalInt(oPC,IntToString(iFly)+"Camp"));
SetLocalInt(oNew,"Flee",GetLocalInt(oPC,IntToString(iFly)+"Flee"));
SetLocalInt(oNew,"NotFlee",GetLocalInt(oPC,IntToString(iFly)+"NotFlee"));

     if(GetLocalInt(oPC,IntToString(iFly)+"Faction")==1){ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);}
else if(GetLocalInt(oPC,IntToString(iFly)+"Faction")==2){ChangeToStandardFaction(oNew,STANDARD_FACTION_DEFENDER);}
else if(GetLocalInt(oPC,IntToString(iFly)+"Faction")==3){ChangeToStandardFaction(oNew,STANDARD_FACTION_HOSTILE);}
else if(GetLocalInt(oPC,IntToString(iFly)+"Faction")==4){ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);}

ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAppear(),oNew);
iFly--;
   }
  }
////////////////////////////////////////////////////////////////////////////////
// Transform creatures
else if(iChoice2==20)
  {
iChoice3 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
i = (iNPCs+1)-(iChoice3+10*(iStep-2));
lTarget = GetLocation(oTarget);
object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",lTarget);

SetLocalInt(oNew,"ShapeNPC",i);
SetLocalString(oNew,"ShapeOrigBP",sBP);
SetLocalString(oNew,"ShapeOrigTag",sTag);
SetLocalString(oNew,"ShapeOrigName",sNPCName);
SetLocalInt(oNew,"ShapeType",OBJECT_TYPE_CREATURE);
SetLocalInt(oNew,"ShapeOrigType",iType);
SetLocalLocation(oNew,"ShapeLoc",lTarget);
SetLocalObject(oNew,"PC",oPC);

SetLocalInt(oNew,"ShapeStop",iStop);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD),lTarget);
oItem = GetFirstItemInInventory(oTarget);while(GetIsObjectValid(oItem)){DestroyObject(oItem);oItem = GetNextItemInInventory(oTarget);}
AssignCommand(oTarget,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oTarget);
DelayCommand(0.5,ExecuteScript("shapes",oNew));
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Place
else if(iChoice1==2)
 {
if(GetAreaFromLocation(lTarget1)==GetAreaFromLocation(lTarget2))
  {
////////////////////////////////////////////////////////////////////////////////
// Camp
if(iChoice2==1)
   {
SetLocalInt(oArea,"CampSize",iChoice3);
SetLocalInt(oArea,"DungeonLevel",iChoice4);
SetLocalInt(oArea,"DungeonFamily",iChoice5);if(iChoice6>0){SetLocalInt(oArea,"DungeonFamily",20+iChoice6);}
DeleteLocalInt(oModule,sPlanet+sArea+"Chest");

ExecuteScript("area_creatures",oArea);
   }
////////////////////////////////////////////////////////////////////////////////
// Interest
else if(iChoice2==2)
   {
// Destroy all existing creatures and placeables in the area
while(GetIsObjectValid(oObject)){if(((GetObjectType(oObject)==OBJECT_TYPE_CREATURE)||(GetObjectType(oObject)==OBJECT_TYPE_PLACEABLE))&&(GetLocalInt(oObject,"Permanent")!=1)){SetImmortal(oObject,FALSE);SetPlotFlag(oObject,FALSE);AssignCommand(oObject,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObject);}oObject = GetNextObjectInArea(oArea);}
// Dungeon
if(iChoice3==2)
    {
SetLocalInt(oArea,"DungeonLevel",iChoice5);
SetLocalInt(oArea,"DungeonFamily",iChoice6);if(iChoice7>0){SetLocalInt(oArea,"DungeonFamily",20+iChoice7);}
DelayCommand(1.0,ExecuteScript("dungeons",oArea));
    }
// Animal reserve
else if(iChoice3==5)
    {
SetLocalInt(oModule,"Choice5",iChoice5);
SetLocalInt(oModule,"Choice6",iChoice6);
SetLocalInt(oModule,"Choice7",iChoice7);
SetLocalInt(oModule,"Choice8",iChoice8);
SetLocalInt(oModule,"Choice9",iChoice9);
    }
SetLocalInt(oModule,"InterestChosen",iChoice3);
SetLocalInt(oModule,"InterestType",iChoice4);
SetLocalString(oModule,"InterestPlanet",sPlanet);
SetLocalString(oModule,"InterestArea",sArea);
ExecuteScript("interests",oModule);

sInterest = GetLocalString(oModule,"Interest");
sName = GetLocalString(oModule,"Name");
sVar = GetLocalString(oModule,"Var");

SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests",sInterest+"&1&"+sName+"&2&"+sVar+"&3&1&4&");
DelayCommand(0.5,ExecuteScript("area_interests",oArea));
   }
////////////////////////////////////////////////////////////////////////////////
// Scenery
else if(iChoice2==3)
   {
// Bridge
if(iChoice3==1)
    {
Const = 5.0;h = Const/2.0;
if(fAy>fAx) {if(fv2y>fv1y) {while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nw_plc_raft",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.0),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+2.5,v1.y+h+2.5,v1.z+0.6),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+2.5,v1.y+h-2.5,v1.z+0.6),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-2.5,v1.y+h+2.5,v1.z+0.6),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-2.5,v1.y+h-2.5,v1.z+0.6),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);if(j==1) {j=0; }else {j=1;fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x+2.4,v1.y+h+2.5,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; }fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x-2.4,v1.y+h+2.5,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; } }h=h+Const; }l2 = Location(oArea,Vector(v1.x,v1.y+h-(Const/2.0),v1.z),0.0); }
                     else {while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nw_plc_raft",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.0),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+2.5,v1.y-h+2.5,v1.z+0.6),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+2.5,v1.y-h-2.5,v1.z+0.6),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-2.5,v1.y-h+2.5,v1.z+0.6),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-2.5,v1.y-h-2.5,v1.z+0.6),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);if(j==1) {j=0; }else {j=1;fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x+2.4,v1.y-h+2.5,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; }fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x-2.4,v1.y-h+2.5,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; } }h=h+Const; }l2 = Location(oArea,Vector(v1.x,v1.y-h+(Const/2.0),v1.z),0.0); } }
       else {if(fv2x>fv1x) {while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nw_plc_raft",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.0),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+h+2.5,v1.y+2.5,v1.z+0.6),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+h+2.5,v1.y-2.5,v1.z+0.6),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+h-2.5,v1.y+2.5,v1.z+0.6),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x+h-2.5,v1.y-2.5,v1.z+0.6),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);if(j==1) {j=0; }else {j=1;fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x+h+2.5,v1.y+2.4,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; }fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x+h+2.5,v1.y-2.4,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; } }h=h+Const; }l2 = Location(oArea,Vector(v1.x+h-(Const/2.0),v1.y,v1.z),0.0); }
                     else {while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"nw_plc_raft",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.0),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-h+2.5,v1.y+2.5,v1.z+0.6),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-h+2.5,v1.y-2.5,v1.z+0.6),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-h-2.5,v1.y+2.5,v1.z+0.6),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence002",Location(oArea,Vector(v1.x-h-2.5,v1.y-2.5,v1.z+0.6),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);if(j==1) {j=0; }else {j=1;fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x-h+2.5,v1.y+2.4,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; }fZ = v1.z;while(fZ>=0.0) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_pillar2",Location(oArea,Vector(v1.x-h+2.5,v1.y-2.4,fZ-3.5),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);fZ = fZ-3.5; } }h=h+Const; }l2 = Location(oArea,Vector(v1.x-h+(Const/2.0),v1.y,v1.z),0.0); } }
l1 = Location(oArea,Vector(v1.x,v1.y,v1.z),0.0);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"bridgepass",l1);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);SetLocalString(oPla,"Var",FloatToString(GetPositionFromLocation(l2).x)+"_A_"+FloatToString(GetPositionFromLocation(l2).y)+"_B_");oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"bridgepass",l2);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);SetLocalString(oPla,"Var",FloatToString(GetPositionFromLocation(l1).x)+"_A_"+FloatToString(GetPositionFromLocation(l1).y)+"_B_");
    }
// Buildings
else if(iChoice3==2)
    {
// House
if(iChoice4==1)
     {
fv1x = GetPositionFromLocation(lTarget).x;
fv1y = GetPositionFromLocation(lTarget).y;
fv1z = GetPositionFromLocation(lTarget).z;
fv1f = 0.0;
s = "zep_house001";X=0.0;Y=0.0;Z=0.0;F=180.0;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "townhome_plc";X=-2.05;Y=-3.0;Z=0.0;F=90.0;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
     }
// Monastery
else if(iChoice4==2)
     {
fv1x = GetPositionFromLocation(lTarget).x;
fv1y = GetPositionFromLocation(lTarget).y;
fv1z = GetPositionFromLocation(lTarget).z;
fv1f = 90.0;
s = "zep_fence009";X=1.0;Y=-3.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "lamp";X=5.0;Y=-2.5;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "lamp";X=-10.0;Y=-4.0;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "lamp";X=-10.0;Y=4.15;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_arch003";X=-12.00;Y=0.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_swall003";X=-12.00;Y=0.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-6.0;Y=12.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=0.0;Y=12.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=6.0;Y=12.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-5.0;Y=-12.0;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=0.0;Y=-12.0;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=6.0;Y=-12.0;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=12.0;Y=-6.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=12.0;Y=0.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=12.0;Y=6.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-12.0;Y=-6.0;Z=0.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-12.0;Y=6.0;Z=0.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-10.5;Y=10.5;Z=0.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-10.5;Y=-10.5;Z=0.0;F=225.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=10.5;Y=-10.5;Z=0.0;F=135.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=10.5;Y=10.5;Z=0.0;F=45.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=-10.5;Y=10.5;Z=0.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=-10.5;Y=-10.5;Z=0.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=10.5;Y=-10.5;Z=0.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=10.5;Y=10.5;Z=0.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=-10.5;Y=10.5;Z=3.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=-10.5;Y=-10.5;Z=3.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=10.5;Y=-10.5;Z=3.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_pillar004";X=10.5;Y=10.5;Z=3.0;F=315.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "castledoor";X=-12.0;Y=0.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_tower014";X=-12.0;Y=12.0;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_tower014";X=12.0;Y=12.0;Z=0.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_tower014";X=-12.0;Y=-12.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_tower014";X=12.0;Y=-12.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-12.0;Y=0.0;Z=3.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-6.0;Y=12.0;Z=3.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=0.0;Y=12.0;Z=3.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=6.0;Y=12.0;Z=3.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-6.0;Y=-12.0;Z=3.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=0.0;Y=-12.0;Z=3.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=6.0;Y=-12.0;Z=3.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=12.0;Y=-6.0;Z=3.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=12.0;Y=0.0;Z=3.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=12.0;Y=6.0;Z=3.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-12.0;Y=-6.0;Z=3.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wall002";X=-12.0;Y=6.0;Z=3.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_shrine001";X=0.0;Y=3.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "fountain2";X=-5.0;Y=0.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_shed001";X=-0.5;Y=9.7;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_house001";X=8.5;Y=-3.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "townshop_plc";X=5.5;Y=-1.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget,FALSE,"townshop007");i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_house001";X=7.5;Y=7.5;Z=0.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "townshop_plc";X=5.5;Y=4.5;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget,FALSE,"townshop002");i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_fence012";X=3.4;Y=-2.8;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_fence012";X=5.0;Y=-5.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_fence012";X=3.6;Y=-6.6;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_wagon004";X=3.3;Y=-5.4;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_cabin001";X=-5.8;Y=-7.8;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "townhome_plc";X=-4.0;Y=-4.8;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget,FALSE,"townhome002");i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_archtarget";X=-7.0;Y=-4.5;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_archtarget";X=-8.5;Y=-4.5;Z=0.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_outhouse001";X=0.8;Y=-9.7;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_tree023";X=0.8;Y=-11.0;Z=2.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_campfrwpot";X=9.7;Y=2.6;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_cmbtdummy";X=9.2;Y=4.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_weaponrack";X=11.0;Y=3.5;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_weaponrack";X=11.0;Y=1.5;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_house001";X=-7.0;Y=8.0;Z=0.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "townshop_plc";X=-9.0;Y=5.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget,FALSE,"townshop001");i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_magicpurple";X=-9.5;Y=5.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_magicpurple";X=-8.5;Y=5.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_magicmth004";X=-4.5;Y=5.0;Z=0.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_arch002";X=-12.0;Y=-0.08;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_statue001";X=-12.0;Y=-4.0;Z=8.0;F=90.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_statue001";X=-12.0;Y=4.0;Z=8.0;F=270.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_flamelarge";X=-12.0;Y=-3.3;Z=12.5;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_flamelarge";X=-12.0;Y=3.3;Z=12.5;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_tower016";X=7.4;Y=-9.0;Z=0.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_statues024";X=7.4;Y=-9.0;Z=20.0;F=180.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "zep_giantsword";X=6.1;Y=-9.0;Z=17.0;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
s = "plc_solwhite";X=7.1;Y=-9.0;Z=26.6;F=0.0;X2=X;Y2=Y;Y=X2;X=-Y2;lTarget = Location(oArea,Vector(fv1x+X,fv1y+Y,fv1z+Z),fv1f+F);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,s,lTarget);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
     }
// Tower
else if(iChoice4==3)
     {
fv1x = GetPositionFromLocation(lTarget).x;
fv1y = GetPositionFromLocation(lTarget).y;
fv1z = GetPositionFromLocation(lTarget).z;
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y+1.5,fv1z+0.0),270.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y+1.5,fv1z+0.0),180.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y-1.5,fv1z+0.0),90.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y-1.5,fv1z+0.0),0.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
if(iChoice5>1)
      {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y+1.5,fv1z+9.0),270.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y+1.5,fv1z+9.0),180.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y-1.5,fv1z+9.0),90.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y-1.5,fv1z+9.0),0.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
      }
if(iChoice5>2)
      {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y+1.5,fv1z+18.0),270.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y+1.5,fv1z+18.0),180.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y-1.5,fv1z+18.0),90.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y-1.5,fv1z+18.0),0.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
      }
if(iChoice5>3)
      {
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y+1.5,fv1z+27.0),270.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y+1.5,fv1z+27.0),180.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x+1.5,fv1y-1.5,fv1z+27.0),90.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tower014",Location(oArea,Vector(fv1x-1.5,fv1y-1.5,fv1z+27.0),0.0),FALSE);i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);
      }
//
     }
//
    }
// Fields
else if(iChoice3==3)
    {
Const = 4.1;h = Const/2.0;
     if((fv1x<fv2x)&&(fv1y<fv2y))   {if(iChoice2==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+0.3),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }    else if(iChoice2==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0-0.3),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0-0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x<fv2x)&&(fv1y>=fv2y))  {if(iChoice2==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+0.3),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice2==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0-0.3),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0-0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y>=fv2y)) {if(iChoice2==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0-0.3),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0-0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }  else if(iChoice2==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+0.3),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y<fv2y))  {if(iChoice2==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0-0.3),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0-0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice2==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0-0.3),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0-0.3),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence012",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
    }
// Roads
else if(iChoice3==4)
    {
Const = 10.0;h = Const/2.0;
     if((fv1x<fv2x)&&(fv1y<fv2y))   {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }  else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x<fv2x)&&(fv1y>=fv2y))  {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }  else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y>=fv2y)) {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y<fv2y))  {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road002",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = GetPositionFromLocation(GetLocation(oPla)); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_road006",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
    }
// Walls (castle)
else if(iChoice3==5)
    {
Const = 9.5;h = Const/2.0;
     if((fv1x<fv2x)&&(fv1y<fv2y))   {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+0.2),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+0.2),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x<fv2x)&&(fv1y>=fv2y))  {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+0.2),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+0.2),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y>=fv2y)) {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+0.2),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+0.2),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y<fv2y))  {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+0.2),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }  else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+0.2),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+0.2),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"codiwall2",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
    }
// Walls (domain)
else if(iChoice3==6)
    {
Const = 2.5;h = Const/2.0;
     if((fv1x<fv2x)&&(fv1y<fv2y))   {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }    else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x<fv2x)&&(fv1y>=fv2y))  {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y>=fv2y)) {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }  else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y<fv2y))  {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),27+0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_wall001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
    }
// Walls (graveyard)
else if(iChoice3==7)
    {
Const = 2.7;h = Const/2.0;
     if((fv1x<fv2x)&&(fv1y<fv2y))   {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }    else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x<fv2x)&&(fv1y>=fv2y))  {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv2x-fv1x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x+h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y>=fv2y)) {if(iChoice4==1) {while(h<fAx) {if((h>=fAx-Const)&&((fv1y-fv2y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),0.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }  else if(iChoice4==2) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y-h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),90.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
else if((fv1x>=fv2x)&&(fv1y<fv2y))  {if(iChoice4==1) {while(h<fAy) {if((h>=fAy-Const)&&((fv1x-fv2x)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)+(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)+(Const/2.0+v1.z+0.0),0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAx) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } }else if(iChoice4==2) {while(h<fAx) {if((h>=fAx-Const)&&((fv2y-fv1y)>=Const)) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);v1 = Vector((GetPositionFromLocation(GetLocation(oPla)).x)-(Const/2.0+v1.z+0.0),(GetPositionFromLocation(GetLocation(oPla)).y)-(Const/2.0+v1.z+0.0),v1.z+0.05); }else {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x-h,v1.y,v1.z+0.05),270.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE); }h=h+Const; }h=Const;while(h<fAy) {oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fence001",Location(oArea,Vector(v1.x,v1.y+h,v1.z+0.05),180.0));i++;SetLocalObject(oPC,"Road"+IntToString(i),oPla);SetPlotFlag(oPla,TRUE);h=h+Const; } } }
    }
//
   }
////////////////////////////////////////////////////////////////////////////////
// Store
else if(iChoice2==4)
   {
     if(iChoice3==1) {s = "store005";}
else if(iChoice3==2) {s = "store011";}
else if(iChoice3==3) {s = "store016";}
else if(iChoice3==4) {s = "store003";}
else if(iChoice3==5) {s = "store010";}
else if(iChoice3==6) {s = "store012";}
else if(iChoice3==7) {s = "store008";}
else if(iChoice3==8) {s = "store001";}
else if(iChoice3==9) {s = "store014";}
else if(iChoice3==10){s = "store006";}
else if(iChoice3==11){s = "store009";}
else if(iChoice3==12){s = "store004";}
else if(iChoice3==13){s = "store007";}
else if(iChoice3==14){s = "store013";}
else if(iChoice3==15){s = "store015";}
else if(iChoice3==16){s = "store017";}
else if(iChoice3==17){s = "store002";}

oNew = CreateObject(OBJECT_TYPE_STORE,s,lTarget);if(iChoice4==1){SetLocalInt(oNew,"Persistent",1);}
//
   }
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(oPC,"Prixi",i);
  }
else
  {
AssignCommand(oPC,SpeakString("Path invalid"));
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Players
else if(iChoice1==3)
 {
////////////////////////////////////////////////////////////////////////////////
lTarget = GetLocalLocation(oPC,"LocTarget"+IntToString(GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep))+(10*(iStep-1))));
SetLocalString(oPC,GetName(oPC)+"Loc",GetTag(GetAreaFromLocation(lTarget)));
AssignCommand(oPC,ActionJumpToLocation(lTarget));
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Sound
else if(iChoice1==4)
 {
////////////////////////////////////////////////////////////////////////////////
// Start background music
if(iChoice2==1)
  {
MusicBackgroundPlay(oArea);
  }
// Stop background music
else if(iChoice2==2)
  {
MusicBackgroundStop(oArea);
  }
// Start battle music
else if(iChoice2==3)
  {
MusicBattlePlay(oArea);
  }
// Stop battle music
else if(iChoice2==4)
  {
MusicBattleStop(oArea);
  }
// Play sound
else if(iChoice2==5)
  {
object oObject = GetNearestObject(OBJECT_TYPE_CREATURE,oPC,1);if(GetIsDM(oObject)){oObject = GetNearestObject(OBJECT_TYPE_CREATURE,oPC,2);}
string sSound;int iSound;i=0;

if(iChoice3==1)
 {
sSound = GetLocalString(oModule,"Sound"+IntToString(GetLocalInt(oPC,"LastPlayedSound")));
SetLocalInt(OBJECT_SELF,"Step",iStep-1);
 }
else
 {
     if(iChoice3==2){i = 0;}
else if(iChoice3==3){i = 25;}
else if(iChoice3==4){i = 33;}
else if(iChoice3==5){i = 48;}
else if(iChoice3==6){i = 53;}
//
iSound = i+((iStep-4)*10)+GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
sSound = GetLocalString(oModule,"Sound"+IntToString(iSound));
SetLocalInt(oPC,"LastPlayedSound",iSound);
SetLocalInt(OBJECT_SELF,"Step",iStep-2);
 }
AssignCommand(oObject,ClearAllActions());
AssignCommand(oObject,PlaySound(sSound));
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Teleport
else if(iChoice1==5)
 {
////////////////////////////////////////////////////////////////////////////////
// Axis
if(iChoice2==1)
  {
if(iChoice4==11){iChoice4 = 0;}if(iChoice6==11){iChoice6 = 0;}

string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);
int iX = StringToInt(sX);if(GetStringLeft(sX,1)=="m"){iX = -StringToInt(GetStringRight(sX,GetStringLength(sX)-1));}
int iY = StringToInt(sY);if(GetStringLeft(sY,1)=="m"){iY = -StringToInt(GetStringRight(sY,GetStringLength(sY)-1));}
// X axis
     if(iChoice5==1){iX = iX+iChoice6;sX = IntToString(iX);if(iX<0){sX = "m"+IntToString(-iX);}}
else if(iChoice5==2){iX = iX-iChoice6;sX = IntToString(iX);if(iX<0){sX = "m"+IntToString(-iX);}}
// Y axis
     if(iChoice3==1){iY = iY+iChoice4;sY = IntToString(iY);if(iY<0){sY = "m"+IntToString(-iY);}}
else if(iChoice3==2){iY = iY-iChoice4;sY = IntToString(iY);if(iY<0){sY = "m"+IntToString(-iY);}}
string sPos = sX+sZ+sY;

SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sPos);
SetLocalFloat(oPC,"fX",50.0);
SetLocalFloat(oPC,"fY",50.0);
SetLocalFloat(oPC,"fFacing",90.0);

ClearAllActions();
ExecuteScript("transitions",oPC);
  }
// Nearest creature
else if(iChoice2==2)
  {
AssignCommand(oPC,ActionJumpToObject(GetNearestObject(OBJECT_TYPE_CREATURE)));
  }
// Nearest placeable
else if(iChoice2==3)
  {
AssignCommand(oPC,ActionJumpToObject(GetNearestObject(OBJECT_TYPE_PLACEABLE)));
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
}
