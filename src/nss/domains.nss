#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLocalObject(OBJECT_SELF,"PC");
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*5;
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*5;
float fPX;float fPY;
float fPZ = 0.0;if(GetStringLeft(GetTag(OBJECT_SELF),8)=="tropical"){fPZ = 1.0;}else if((GetStringLeft(GetTag(OBJECT_SELF),6)=="ground")||(GetStringLeft(GetTag(OBJECT_SELF),11)=="ruralcastle")){fPZ = 5.0;}
////////////////////////////////////////////////////////////////////////////////
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterestType = GetStringLeft(sInterest,FindSubString(sInterest,"&1&"));
string sMaster = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")))-FindSubString(sInterest,"&1&")-3);
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
string sVisible = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")))-FindSubString(sInterest,"&3&")-3);
// Slots
string sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_01_"));
string sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_02_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_02_")))-FindSubString(sVar,"_01_")-4);
string sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_03_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_03_")))-FindSubString(sVar,"_02_")-4);
string sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_04_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_04_")))-FindSubString(sVar,"_03_")-4);
string sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_05_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_05_")))-FindSubString(sVar,"_04_")-4);
string sVar6 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_06_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_06_")))-FindSubString(sVar,"_05_")-4);
string sVar7 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_07_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_07_")))-FindSubString(sVar,"_06_")-4);
string sVar8 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_08_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_08_")))-FindSubString(sVar,"_07_")-4);
string sVar9 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_09_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_09_")))-FindSubString(sVar,"_08_")-4);
string sVar10 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_10_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_10_")))-FindSubString(sVar,"_09_")-4);
string sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
// Types & Levels
string sVar1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));string sVar1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);
string sVar2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));string sVar2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);
string sVar3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));string sVar3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);
string sVar4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));string sVar4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);
string sVar5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));string sVar5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);
string sVar6L = GetStringLeft(sVar6,FindSubString(sVar6,"%"));string sVar6R = GetStringRight(sVar6,GetStringLength(sVar6)-FindSubString(sVar6,"%")-1);
string sVar7L = GetStringLeft(sVar7,FindSubString(sVar7,"%"));string sVar7R = GetStringRight(sVar7,GetStringLength(sVar7)-FindSubString(sVar7,"%")-1);
string sVar8L = GetStringLeft(sVar8,FindSubString(sVar8,"%"));string sVar8R = GetStringRight(sVar8,GetStringLength(sVar8)-FindSubString(sVar8,"%")-1);
string sVar9L = GetStringLeft(sVar9,FindSubString(sVar9,"%"));string sVar9R = GetStringRight(sVar9,GetStringLength(sVar9)-FindSubString(sVar9,"%")-1);
string sVar10L = GetStringLeft(sVar10,FindSubString(sVar10,"%"));string sVar10R = GetStringRight(sVar10,GetStringLength(sVar10)-FindSubString(sVar10,"%")-1);
// Var example (type%level)
// sVar = "1%1"+"_1_"+"1%1"+"_2_"etc
////////////////////////////////////////////////////////////////////////////////
int iDomainIni = GetLocalInt(OBJECT_SELF,"Domain_Ini");
string sDomainBuild = GetLocalString(OBJECT_SELF,"Domain_Build");
int iChoice2 = StringToInt(GetStringLeft(sDomainBuild,FindSubString(sDomainBuild,"_+_")));
int iChoice3 = StringToInt(GetStringRight(sDomainBuild,GetStringLength(sDomainBuild)-FindSubString(sDomainBuild,"_+_")-3));
string sDomainRes = GetLocalString(OBJECT_SELF,"Domain_Res");
int iDomainUpgrade = GetLocalInt(OBJECT_SELF,"Domain_Upgrade");
////////////////////////////////////////////////////////////////////////////////
string sBP;float fX;float fY;float fZ;float fF;location lLoc;object oNew;object oPla;object oFlag;string s1;string s2;int iLevel;string sSlot;int iSlot;int iAreaX2;int iAreaY2;string sS;object oItem;int i;
string sRes1;string sRes2;string sRes3;string sRes4;string sRes5;string sRes6;string sRes7;string sRes8;string sRes9;string sRes10;string sRes1L;string sRes2L;string sRes3L;string sRes4L;string sRes5L;string sRes6L;string sRes7L;string sRes8L;string sRes9L;string sRes10L;string sRes1R;string sRes2R;string sRes3R;string sRes4R;string sRes5R;string sRes6R;string sRes7R;string sRes8R;string sRes9R;string sRes10R;
int iRes1;int iRes2;int iRes3;int iRes4;int iRes5;int iRes6;int iRes7;int iRes8;int iRes9;int iRes10;int iGold;int iDS;
////////////////////////////////////////////////////////////////////////////////
// Resources list
string ADAMANTINE = "Adamantine"+"_A_"+"cr_adamantine";
string COAL = "Coal"+"_A_"+"cr_coal";
string COPPER = "Copper"+"_A_"+"cr_copper";
string CRYSTAL = "Crystal"+"_A_"+"cr_crystal";
string DIAMONDINE = "Diamondine"+"_A_"+"cr_diamondine";
string IRON = "Iron"+"_A_"+"cr_iron";
string LEAD = "Lead"+"_A_"+"cr_lead";
string MERCURY = "Mercury"+"_A_"+"cr_mercury";
string MITHRIL = "Mithril"+"_A_"+"cr_mithril";
string PLATINE = "Platine"+"_A_"+"cr_platine";
string SAND = "Sand"+"_A_"+"cr_sand";
string STEEL = "Steel"+"_A_"+"cr_steel";
string STONE = "Stone"+"_A_"+"cr_stone";
string TIN = "Tin"+"_A_"+"cr_tin";
string BASIC_WOOD = "Basic Wood"+"_A_"+"cr_woodbasic";
string IRON_WOOD = "Iron Wood"+"_A_"+"cr_woodiron";
string SOFT_WOOD = "Soft Wood"+"_A_"+"cr_woodsoft";
string STRONG_WOOD = "Strong Wood"+"_A_"+"cr_woodstrong";
string QUARTZ = "Quartz"+"_A_"+"cr_quartz";
//
string NONE = "none"+"_A_"+"none";
////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////
int iTot = 10;if(iChoice2!=0){iTot = iChoice2;iSlot = iChoice2-1;}
////////////////////////////////////////////////////////////////////////////////
while(iSlot<iTot)
 {
iSlot++;
if(iSlot==1){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar1L);}iLevel = StringToInt(sVar1R);iAreaX2 = iAreaX-20;iAreaY2 = iAreaY+20;}
if(iSlot==2){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar2L);}iLevel = StringToInt(sVar2R);iAreaX2 = iAreaX+0;iAreaY2 = iAreaY+20;}
if(iSlot==3){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar3L);}iLevel = StringToInt(sVar3R);iAreaX2 = iAreaX+20;iAreaY2 = iAreaY+20;}
if(iSlot==4){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar4L);}iLevel = StringToInt(sVar4R);iAreaX2 = iAreaX-20;iAreaY2 = iAreaY+0;}
if(iSlot==5){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar5L);}iLevel = StringToInt(sVar5R);iAreaX2 = iAreaX+0;iAreaY2 = iAreaY+0;}
if(iSlot==6){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar6L);}iLevel = StringToInt(sVar6R);iAreaX2 = iAreaX+20;iAreaY2 = iAreaY+0;}
if(iSlot==7){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar7L);}iLevel = StringToInt(sVar7R);iAreaX2 = iAreaX-20;iAreaY2 = iAreaY-20;}
if(iSlot==8){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar8L);}iLevel = StringToInt(sVar8R);iAreaX2 = iAreaX+0;iAreaY2 = iAreaY-20;}
if(iSlot==9){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar9L);}iLevel = StringToInt(sVar9R);iAreaX2 = iAreaX+20;iAreaY2 = iAreaY-20;}
if(iSlot==10){if((iDomainIni==1)||(iDomainUpgrade==1)){iChoice3 = StringToInt(sVar10L);}iLevel = StringToInt(sVar10R);iAreaX2 = iAreaX+0;iAreaY2 = iAreaY+0;}
fPX = IntToFloat(iAreaX2);fPY = IntToFloat(iAreaY2);
////////////////////////////////////////////////////////////////////////////////
if(iChoice3!=0)
  {
////////////////////////////////////////////////////////////////////////////////
// Central Slot
if(iSlot==5)
   {
////////////////////////////////////////////////////////////////////////////////
// Central Place
if(iChoice3==1)
    {
//
sS = "Central Place";
s1 = "The central place is a relaxing place for all domain inhabitants.";
sRes1  = BASIC_WOOD;      iRes1  = 2;
sRes2  = SOFT_WOOD;      iRes2  = 1;
sRes3  = STONE;      iRes3  = 1;
sRes4  = NONE;      iRes4  = 0;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 200;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "pla_bench";fX = -5.0;fY = -2.5;fZ = 0.0;fF = 210.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = -3.0;fY = -5.0;fZ = 0.0;fF = 250.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = 7.0;fY = 1.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_tree022";fX = -8.0;fY = 6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_tree022";fX = 6.0;fY = -8.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "the_ccp_plac020";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(OBJECT_SELF,"Bonus",GetLocalInt(OBJECT_SELF,"Bonus")+1);
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
sBP = "the_ccp_plac006";fX = 0.0;fY = 7.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_statue001";fX = 0.0;fY = 5.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
sBP = "plc_solblue";fX = 0.0;fY = 7.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
sBP = "ccp_floor003";fX = -6.0;fY = -6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = -6.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = -6.0;fY = 6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = 0.0;fY = -6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = 0.0;fY = 6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = 6.0;fY = -6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = 6.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_floor003";fX = 6.0;fY = 6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
   }
////////////////////////////////////////////////////////////////////////////////
// South Slot
else if(iSlot==8)
   {
////////////////////////////////////////////////////////////////////////////////
// Entry
if(iChoice3==1)
    {
//
sS = "Entry";
s1 = "The entry of your domain adds some facilities to your domain.";
sRes1  = STRONG_WOOD;      iRes1  = 2;
sRes2  = STONE;      iRes2  = 2;
sRes3  = NONE;      iRes3  = 0;
sRes4  = NONE;      iRes4  = 0;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 200;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "zep_road005";fX = 0.0;fY = -12.0;fZ = 0.2;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_road005";fX = 0.0;fY = 8.0;fZ = 0.2;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_road006";fX = 0.0;fY = -2.0;fZ = 0.2;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "zep_fence010";fX = -2.2;fY = -9.9;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence010";fX = 2.2;fY = -9.9;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_doors011";if(StringToInt(sVar10R)>=4){sBP = "zep_doors007";}fX = 0.0;fY = -10.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(OBJECT_SELF,"Bonus",GetLocalInt(OBJECT_SELF,"Bonus")+1);
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
sBP = "mailbox";fX = 2.4;fY = -12.5;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(OBJECT_SELF,"Mailbox",oPla);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);SetLocalInt(oPla,"Level",3);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
SetLocalInt(GetLocalObject(OBJECT_SELF,"Mailbox"),"Level",4);
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oPla);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
SetLocalInt(GetLocalObject(OBJECT_SELF,"Mailbox"),"Level",5);
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oPla);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
   }
////////////////////////////////////////////////////////////////////////////////
// Borders
else if(iSlot==10)
   {
////////////////////////////////////////////////////////////////////////////////
// Walls
if(iChoice3==1)
    {
//
sS = "Walls";
s1 = "The walls protect your domain from any danger coming from outside.";
sRes1  = BASIC_WOOD;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 1;
sRes3  = STONE;      iRes3  = 4;
sRes4  = STRONG_WOOD;      iRes4  = 2;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 300;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel==1)))
      {
sBP = "zep_fence002";fX = -30.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -26.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -22.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -18.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -14.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -10.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -6.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -2.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 2.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 6.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 10.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 14.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 18.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 22.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 26.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "zep_fence002";fX = -30.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -26.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -22.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -18.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -14.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -10.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -6.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -2.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 2.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 6.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 10.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 14.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 18.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 22.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 26.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "zep_fence002";fX = -30.0;fY = -30.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = -26.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = -22.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = -18.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = -14.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = -10.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = -6.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = -2.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 2.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 6.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 10.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 14.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 18.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 22.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 26.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = -30.0;fY = 30.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "zep_fence002";fX = 30.0;fY = -30.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -26.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -22.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -18.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -14.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -10.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -6.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = -2.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 2.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 6.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 10.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 14.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 18.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 22.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 26.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence002";fX = 30.0;fY = 30.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel==2)))
      {
if(iDomainIni==0){oPla = GetFirstObjectInArea(OBJECT_SELF);while(GetIsObjectValid(oPla)){if(GetTag(oPla)=="ZEP_FENCE002"){DestroyObject(oPla);}oPla = GetNextObjectInArea(OBJECT_SELF);}}
sBP = "ccp_picketfence";fX = -25.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(OBJECT_SELF,"Bonus",GetLocalInt(OBJECT_SELF,"Bonus")+2);
sBP = "ccp_picketfence";fX = -15.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -7.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 7.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 15.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 25.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "ccp_picketfence";fX = -25.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -15.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -5.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 5.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 15.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 25.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "ccp_picketfence";fX = -30.0;fY = -25.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -30.0;fY = -15.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -30.0;fY = -5.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -30.0;fY = 5.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -30.0;fY = 15.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = -30.0;fY = 25.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "ccp_picketfence";fX = 30.0;fY = -25.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 30.0;fY = -15.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 30.0;fY = -5.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 30.0;fY = 5.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 30.0;fY = 15.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_picketfence";fX = 30.0;fY = 25.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel==3)))
      {
if(iDomainIni==0){oPla = GetFirstObjectInArea(OBJECT_SELF);while(GetIsObjectValid(oPla)){if(GetTag(oPla)=="ccp_picketfence"){DestroyObject(oPla);}oPla = GetNextObjectInArea(OBJECT_SELF);}}
sBP = "codihighspire";fX = -30.2;fY = -30.2;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(OBJECT_SELF,"Bonus",GetLocalInt(OBJECT_SELF,"Bonus")+3);
sBP = "codihighspire";fX = -30.2;fY = 30.2;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "codihighspire";fX = 30.2;fY = -30.2;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "codihighspire";fX = 30.2;fY = 30.2;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "zep_wall002";fX = -27.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -21.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -15.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -9.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -5.5;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 5.5;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 9.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 15.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 21.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 27.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "zep_wall002";fX = -27.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -21.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -15.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -9.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -3.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 3.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 9.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 15.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 21.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 27.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "zep_wall002";fX = -30.0;fY = -27.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = -21.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = -15.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = -9.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = -3.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = 3.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = 9.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = 15.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = 21.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = -30.0;fY = 27.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "zep_wall002";fX = 30.0;fY = -27.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = -21.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = -15.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = -9.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = -3.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = 3.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = 9.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = 15.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = 21.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_wall002";fX = 30.0;fY = 27.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel==4)))
      {
if(iDomainIni==0){oPla = GetFirstObjectInArea(OBJECT_SELF);while(GetIsObjectValid(oPla)){if((GetTag(oPla)=="codihighspire")||(GetTag(oPla)=="ZEP_WALL002")){DestroyObject(oPla);}oPla = GetNextObjectInArea(OBJECT_SELF);}}
sBP = "nwn2wall037";fX = 0.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(OBJECT_SELF,"Costs",GetLocalInt(OBJECT_SELF,"Costs")+5);

sBP = "nwn2wall002";fX = -30.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = -4.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = 4.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = 30.0;fY = -30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "nwn2wall002";fX = 30.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = 10.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = -10.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "nwn2wall002";fX = -30.0;fY = -10.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = -30.0;fY = 10.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = -30.0;fY = 30.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "nwn2wall002";fX = 30.0;fY = 10.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = 30.0;fY = -10.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "nwn2wall002";fX = 30.0;fY = -30.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel==5)))
      {
if(iDomainIni==0){oPla = GetFirstObjectInArea(OBJECT_SELF);while(GetIsObjectValid(oPla)){if((GetTag(oPla)=="NWN2WallM07")||(GetTag(oPla)=="NWN2WallCityA2")){DestroyObject(oPla);}oPla = GetNextObjectInArea(OBJECT_SELF);}}
sBP = "ccp_keeptower";fX = -30.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(OBJECT_SELF,"Costs",GetLocalInt(OBJECT_SELF,"Costs")+10);
sBP = "ccp_keeptower";fX = -30.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_keeptower";fX = 30.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_keeptower";fX = 30.0;fY = 30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "ccp_wall";fX = -20.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = -10.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_keepgate";fX = 0.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 10.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 20.0;fY = -30.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "ccp_wall";fX = -20.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = -10.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 0.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 10.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 20.0;fY = 30.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "ccp_wall";fX = -30.0;fY = -20.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = -30.0;fY = -10.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = -30.0;fY = 0.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = -30.0;fY = 10.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = -30.0;fY = 20.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

sBP = "ccp_wall";fX = 30.0;fY = -20.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 30.0;fY = -10.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 30.0;fY = 0.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 30.0;fY = 10.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "ccp_wall";fX = 30.0;fY = 20.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
   }
////////////////////////////////////////////////////////////////////////////////
// Other slots
else
   {
////////////////////////////////////////////////////////////////////////////////
// Airship
if(iChoice3==1)
    {
//
sS = "Airship";
s1 = "The airship station permits a connection between your domain and the other cities/towns.";
sRes1  = BASIC_WOOD;      iRes1  = 4;
sRes2  = SOFT_WOOD;      iRes2  = 3;
sRes3  = IRON;      iRes3  = 2;
sRes4  = NONE;      iRes4  = 0;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 200;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "planettakeoff";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "lamppostoff";fX = -2.0;fY = -8.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_sign013";fX = -2.8;fY = -8.0;fZ = 0.8;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Airship");
sBP = "pilot";fX = 2.0;fY = -8.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "zep_shelter";fX = -3.5;fY = -3.5;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = -5.6;fY = -5.4;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = -5.6;fY = -4.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
sBP = "zep_shelter";fX = 3.5;fY = -3.5;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = 3.9;fY = -5.6;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = 5.4;fY = -5.6;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Amusement Place
if(iChoice3==2)
    {
//
sS = "Amusement Place";
s1 = "The amusement place lets your people have fun in their free time.";
sRes1  = BASIC_WOOD;      iRes1  = 2;
sRes2  = COAL;      iRes2  = 1;
sRes3  = SAND;      iRes3  = 1;
sRes4  = TIN;      iRes4  = 2;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 150;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "zep_tent001";fX = 6.0;fY = -6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "plc_campfrwpot";fX = 3.0;fY = -5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "player";fX = 4.0;fY = -6.5;fZ = 0.0;fF = 235.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "zep_tent005";fX = 7.0;fY = 5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "plc_campfr";fX = 3.5;fY = 5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "player";fX = 4.5;fY = 3.5;fZ = 0.0;fF = 250.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
sBP = "zep_tent004";fX = -8.0;fY = -5.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "player";fX = -4.0;fY = -5.5;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
sBP = "zep_tent002";fX = -5.0;fY = 6.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "player";fX = -4.5;fY = 1.0;fZ = 0.0;fF = 290.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
sBP = "zep_tent013";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "player";fX = 0.0;fY = -3.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Casern
if(iChoice3==3)
    {
//
sS = "Casern";
s1 = "The Casern generates henchmen, weak and strong.";
sRes1  = COAL;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 1;
sRes3  = LEAD;      iRes3  = 1;
sRes4  = STEEL;      iRes4  = 2;
sRes5  = STRONG_WOOD;      iRes5  = 2;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 500;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "zep_cabin001";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla1",oPla);
sBP = "zep_doorway_dag";fX = -2.0;fY = -2.9;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla2",oPla);SetUseableFlag(oPla,FALSE);
sBP = "zep_sign003";fX = -4.5;fY = -3.7;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla2",oPla);SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Casern");
if(iDomainIni==0){SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter",GetLocalInt(oGoldbag,"Counter"));}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "plc_cmbtdummy";fX = -4.0;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla3",oPla);
sBP = "plc_weaponrack";fX = 1.0;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla4",oPla);
sBP = "x3_plc_archtarg";fX = 2.5;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla5",oPla);
sBP = "x3_plc_archtarg";fX = 4.0;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla6",oPla);
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
sBP = "mn_galactic001";fX = -3.5;fY = -4.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla7",oPla);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
sBP = "mn_galactic001";fX = -0.5;fY = -4.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla8",oPla);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
i=0;while(i<8){i++;oPla = GetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla"+IntToString(i));SetPlotFlag(oPla,FALSE);DestroyObject(oPla);}
sBP = "nwn2house050";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_sign003";fX = -2.0;fY = -5.2;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Casern");
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
sBP = "mn_galactic001";fX = -1.5;fY = -5.5;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
sBP = "mn_galactic001";fX = 2.0;fY = -5.5;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Dungeon
if(iChoice3==4)
    {
//
sS = "Dungeon";
s1 = "The dungeon is a fortified place for adventurers.";
sRes1  = CRYSTAL;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 3;
sRes3  = IRON_WOOD;      iRes3  = 1;
sRes4  = MERCURY;      iRes4  = 2;
sRes5  = STEEL;      iRes5  = 3;
sRes6  = STONE;      iRes6  = 5;
sRes7  = QUARTZ;      iRes7  = 1;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 1000;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "ccp_ziggurattemp";fX = 0.0;fY = -2.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "door005";fX = -1.0;fY = -4.2;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "zep_torch002";fX = -1.5;fY = -4.8;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_torch002";fX = 1.5;fY = -4.8;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "codistatuegargoy";fX = 0.0;fY = -4.2;fZ = 3.2;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
sBP = "zep_tower014";fX = 0.0;fY = 3.0;fZ = 0.0;fF = 225.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
sBP = "the_ccp_plac021";fX = -8.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "the_ccp_plac021";fX = -8.0;fY = 8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "the_ccp_plac021";fX = 8.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "the_ccp_plac021";fX = 8.0;fY = 8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
sBP = "plc_solred";fX = -8.0;fY = -8.0;fZ = 6.7;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "plc_solred";fX = -8.0;fY = 8.0;fZ = 6.7;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "plc_solred";fX = 8.0;fY = -8.0;fZ = 6.7;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "plc_solred";fX = 8.0;fY = 8.0;fZ = 6.7;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Extractor
if(iChoice3==5)
    {
//
sS = "Extractor";
s1 = "The extractor lets you grab rock resources from the planet.";
sRes1  = COAL;      iRes1  = 3;
sRes2  = IRON;      iRes2  = 1;
sRes3  = LEAD;      iRes3  = 1;
sRes4  = STRONG_WOOD;      iRes4  = 3;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 300;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "ccp_windmill";fX = 2.0;fY = 2.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "x2_plc_minewell";fX = 5.0;fY = -3.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_bricole";fX = -7.0;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if((iDomainIni==0)&&(GetLocalInt(OBJECT_SELF,"DomResIni")!=1)){ExecuteScript("area_resources",OBJECT_SELF);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Factory
if(iChoice3==6)
    {
//
sS = "Factory";
s1 = "The factory lets you transform resources or items into new items (crafting).";
sRes1  = COAL;      iRes1  = 5;
sRes2  = IRON;      iRes2  = 2;
sRes3  = LEAD;      iRes3  = 1;
sRes4  = MERCURY;      iRes4  = 1;
sRes5  = STEEL;      iRes5  = 2;
sRes6  = STRONG_WOOD;      iRes6  = 4;
sRes7  = QUARTZ;      iRes7  = 1;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 600;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2building005";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
   }
////////////////////////////////////////////////////////////////////////////////
// Farm
if(iChoice3==7)
    {
//
sS = "Farm";
s1 = "The farm lets you raise livestock.";
sRes1  = BASIC_WOOD;      iRes1  = 3;
sRes2  = COAL;      iRes2  = 1;
sRes3  = SOFT_WOOD;      iRes3  = 3;
sRes4  = STRONG_WOOD;      iRes4  = 2;
sRes5  = TIN;      iRes5  = 1;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 300;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
sVar = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));

if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -9.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "ccp_house6";fX = -4.0;fY = 4.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -7.0;fY = -10.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -3.0;fY = -10.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -7.5;fY = -2.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -3.5;fY = -2.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -9.2;fY = -8.3;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -9.2;fY = -4.3;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -1.3;fY = -7.3;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = -1.3;fY = -3.3;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "farmer";fX = -5.0;fY = -5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}AssignCommand(oPla,ActionRandomWalk());SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
sBP = GetStringLeft(sVar,FindSubString(sVar,"_A_"));if(sBP!=""){i=0;while(i<4){i++;oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),IntToFloat(Random(360))));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Stop",1);SetLocalInt(oNew,"DontSave",1);SetLocalString(oNew,"Master",sMaster);SetLocalInt(oNew,"Slot",iSlot);SetLocalInt(oNew,"Garden",1);SetLocalInt(oNew,"NotFlee",1);SetLocalInt(oNew,"NoReaction",1);DeleteLocalInt(oNew,"Hench");AssignCommand(oNew,ActionRandomWalk());}}
if((iDomainIni==0)&&(GetLocalInt(OBJECT_SELF,"DomResIni")!=1)){ExecuteScript("area_resources",OBJECT_SELF);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "zep_fence012";fX = 4.0;fY = -10.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 8.0;fY = -10.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 3.5;fY = -2.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 7.5;fY = -2.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 1.8;fY = -8.3;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 1.8;fY = -4.3;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 9.7;fY = -7.3;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 9.7;fY = -3.3;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "farmer";fX = 5.0;fY = -5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}AssignCommand(oPla,ActionRandomWalk());SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
sBP = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);if(sBP!=""){i=0;while(i<4){i++;oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),IntToFloat(Random(360))));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Stop",1);SetLocalInt(oNew,"DontSave",1);SetLocalString(oNew,"Master",sMaster);SetLocalInt(oNew,"Slot",iSlot);SetLocalInt(oNew,"Garden",2);SetLocalInt(oNew,"NotFlee",1);SetLocalInt(oNew,"NoReaction",1);DeleteLocalInt(oNew,"Hench");AssignCommand(oNew,ActionRandomWalk());}}

sBP = "zep_fence012";fX = 4.0;fY = 1.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 8.0;fY = 1.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 3.5;fY = 9.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 7.5;fY = 9.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 1.8;fY = 2.7;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 1.8;fY = 6.7;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 9.7;fY = 3.3;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_fence012";fX = 9.7;fY = 7.3;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "farmer";fX = 5.0;fY = 5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}AssignCommand(oPla,ActionRandomWalk());SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
sBP = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);if(sBP!=""){i=0;while(i<4){i++;oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),IntToFloat(Random(360))));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Stop",1);SetLocalInt(oNew,"DontSave",1);SetLocalString(oNew,"Master",sMaster);SetLocalInt(oNew,"Slot",iSlot);SetLocalInt(oNew,"Garden",3);SetLocalInt(oNew,"NotFlee",1);SetLocalInt(oNew,"NoReaction",1);DeleteLocalInt(oNew,"Hench");AssignCommand(oNew,ActionRandomWalk());}}

if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
      }
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Field
if(iChoice3==8)
    {
//
sS = "Field";
s1 = "The field lets you plant and grow vegetal resources.";
sRes1  = BASIC_WOOD;     iRes1  = 3;
sRes2  = STRONG_WOOD;      iRes2  = 2;
sRes3  = NONE;      iRes3  = 0;
sRes4  = NONE;      iRes4  = 0;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 200;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "zep_flrdesgns002";fX = -5.0;fY = -5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_field_crops";fX = -4.5;fY = -6.7;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "farmer";fX = -5.0;fY = -5.0;fZ = -5.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}AssignCommand(oPla,ActionRandomWalk());SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));SetName(oPla,"Gardener");
if((iDomainIni==0)&&(GetLocalInt(OBJECT_SELF,"DomResIni")!=1)){ExecuteScript("area_resources",OBJECT_SELF);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "zep_flrdesgns002";fX = 5.0;fY = -5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_field_crops";fX = 6.5;fY = -6.7;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "farmer";fX = 5.0;fY = -5.0;fZ = -5.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}AssignCommand(oPla,ActionRandomWalk());SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));SetName(oPla,"Gardener");
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
sBP = "zep_flrdesgns002";fX = 5.0;fY = 5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_field_crops";fX = 6.5;fY = 3.5;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "farmer";fX = 5.0;fY = 5.0;fZ = 5.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}AssignCommand(oPla,ActionRandomWalk());SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));SetName(oPla,"Gardener");
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
sBP = "zep_flrdesgns002";fX = -5.0;fY = 5.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_field_crops";fX = -4.5;fY = 3.5;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "farmer";fX = -5.0;fY = 5.0;fZ = 5.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}AssignCommand(oPla,ActionRandomWalk());SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));SetName(oPla,"Gardener");
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
sBP = "zep_outhouse001";fX = 9.0;fY = 0.0;fZ = 0.0;fF = 120.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_apple_dag001";fX = -1.0;fY = -1.0;fZ = 0.0;fF = 0.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Guild
if(iChoice3==9)
    {
//
sS = "Guild";
s1 = "The guild is a corporation for players.";
sRes1  = ADAMANTINE;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 4;
sRes3  = IRON_WOOD;      iRes3  = 2;
sRes4  = LEAD;      iRes4  = 2;
sRes5  = STEEL;      iRes5  = 4;
sRes6  = STONE;      iRes6  = 5;
sRes7  = STRONG_WOOD;      iRes7  = 5;
sRes8  = TIN;      iRes8  = 1;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 1000;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2building013";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "door002";fX = 0.0;fY = -3.8;fZ = 0.8;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Hall
if(iChoice3==10)
    {
//
sS = "Hall";
s1 = "The hall is the main political and economical center of the domain.";
sRes1  = BASIC_WOOD;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 3;
sRes3  = IRON_WOOD;      iRes3  = 2;
sRes4  = MERCURY;      iRes4  = 3;
sRes5  = PLATINE;      iRes5  = 1;
sRes6  = STEEL;      iRes6  = 3;
sRes7  = STONE;      iRes7  = 5;
sRes8  = STRONG_WOOD;      iRes8  = 5;
sRes9  = TIN;      iRes9  = 2;
sRes10 = NONE;      iRes10 = 0;
iGold = 2000;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 2.0;fY = -10.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2building041";fX = 0.0;fY = 2.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "door002";fX = 0.0;fY = -6.7;fZ = 1.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
SetLocalInt(oGoldbag,sPlanet+"&BoardPriv",1);
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// House
if(iChoice3==11)
    {
//
sS = "House";
s1 = "The house is only for visitors. They can rent it and participate to the domain life.";
sRes1  = COAL;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 1;
sRes3  = STRONG_WOOD;      iRes3  = 2;
sRes4  = NONE;      iRes4  = 0;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 200;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "zep_house001";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "door003";fX = -2.0;fY = -3.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Inn
if(iChoice3==12)
    {
//
sS = "Inn";
s1 = "The inn is a resting place for all adventurers.";
sRes1  = COAL;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 1;
sRes3  = LEAD;      iRes3  = 1;
sRes4  = SAND;      iRes4  = 1;
sRes5  = SOFT_WOOD;      iRes5  = 1;
sRes6  = STONE;      iRes6  = 2;
sRes7  = STRONG_WOOD;      iRes7  = 2;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 400;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2building023";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "doorhouse001";fX = -3.95;fY = -3.7;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "zep_sign010";fX = -4.5;fY = -4.4;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Inn");
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Mission Office
if(iChoice3==13)
    {
//
sS = "Mission Office";
s1 = "the mission office offers jobs and missions.";
sRes1  = COPPER;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 2;
sRes3  = STEEL;      iRes3  = 3;
sRes4  = STRONG_WOOD;      iRes4  = 4;
sRes5  = TIN;      iRes5  = 1;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 500;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2house006";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "doorhouse001";fX = -3.35;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "doorhouse001";fX = 1.85;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "doorhouse001";fX = -1.9;fY = 4.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "zep_sign019";fX = 0.5;fY = -4.8;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Mission Office");
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
SetLocalInt(OBJECT_SELF,"Gain",GetLocalInt(OBJECT_SELF,"Gain")+10);
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Personal House
if(iChoice3==14)
    {
//
sS = "Personal House";
s1 = "This is the house of the domain holder.";
sRes1  = BASIC_WOOD;      iRes1  = 2;
sRes2  = COAL;      iRes2  = 2;
sRes3  = IRON;      iRes3  = 2;
sRes4  = STEEL;      iRes4  = 1;
sRes5  = SOFT_WOOD;      iRes5  = 1;
sRes6  = STRONG_WOOD;      iRes6  = 2;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 300;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = -2.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "zep_house001";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla1",oPla);
sBP = "zep_doorway_dag";fX = -2.0;fY = -3.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla2",oPla);SetUseableFlag(oPla,FALSE);
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
i=0;while(i<2){i++;oPla = GetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla"+IntToString(i));SetPlotFlag(oPla,FALSE);DestroyObject(oPla);}
sBP = "nwn2building004";fX = 0.0;fY = 2.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla1",oPla);
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
i=0;while(i<1){i++;oPla = GetLocalObject(OBJECT_SELF,IntToString(iSlot)+"Pla"+IntToString(i));SetPlotFlag(oPla,FALSE);DestroyObject(oPla);}
sBP = "nwn2building025";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Sawmill
if(iChoice3==21)
    {
//
sS = "Sawmill";
s1 = "The sawmill lets you cut trees from the planet.";
sRes1  = COAL;      iRes1  = 2;
sRes2  = IRON;      iRes2  = 1;
sRes3  = LEAD;      iRes3  = 1;
sRes4  = STRONG_WOOD;      iRes4  = 4;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 300;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "ccp_house7";fX = 2.0;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "x0_fallentimber";fX = -2.2;fY = 4.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "x0_fallentimber";fX = -3.0;fY = 5.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "x0_fallentimber";fX = -4.0;fY = 4.0;fZ = 0.0;fF = 190.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}

if((iDomainIni==0)&&(GetLocalInt(OBJECT_SELF,"DomResIni")!=1)){ExecuteScript("area_resources",OBJECT_SELF);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// School
if(iChoice3==15)
    {
//
sS = "School";
s1 = "The school lets players learn or teach.";
sRes1  = BASIC_WOOD;      iRes1  = 1;
sRes2  = COAL;      iRes2  = 1;
sRes3  = COPPER;      iRes3  = 1;
sRes4  = IRON;      iRes4  = 2;
sRes5  = SOFT_WOOD;      iRes5  = 2;
sRes6  = STONE;      iRes6  = 2;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 300;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2house003";fX = 0.0;fY = 0.0;fZ = -0.5;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "doorhouse001";fX = -0.7;fY = -3.2;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "doorhouse001";fX = 0.7;fY = 4.6;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "zep_sign024";fX = -1.8;fY = -6.1;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"School");
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Shop
if(iChoice3==16)
    {
//
sS = "Shop";
s1 = "The shop contains one special shop.";
sRes1  = BASIC_WOOD;      iRes1  = 2;
sRes2  = COPPER;      iRes2  = 1;
sRes3  = IRON;      iRes3  = 2;
sRes4  = LEAD;      iRes4  = 1;
sRes5  = MERCURY;      iRes5  = 1;
sRes6  = SOFT_WOOD;      iRes6  = 4;
sRes7  = STONE;      iRes7  = 2;
sRes8  = TIN;      iRes8  = 1;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 400;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sVar = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));
if((sVar=="")||(sVar=="000")){sVar = "Shop";}else if(sVar=="001"){sVar = "General Shop";}else if(sVar=="002"){sVar = "Weaponsmith";}else if(sVar=="003"){sVar = "Armorsmith";}else if(sVar=="004"){sVar = "Arcane shop";}else if(sVar=="005"){sVar = "Alchemist shop";}else if(sVar=="006"){sVar = "Jeweler";}else if(sVar=="007"){sVar = "Rogue shop";}else if(sVar=="008"){sVar = "Tailor";}else if(sVar=="009"){sVar = "Library";}else if(sVar=="010"){sVar = "Bank";}else if(sVar=="011"){sVar = "Animal shop";}else if(sVar=="012"){sVar = "Blacksmith";}else if(sVar=="013"){sVar = "Tavern";}else if(sVar=="014"){sVar = "Inn";}else if(sVar=="015"){sVar = "Temple";}else if(sVar=="016"){sVar = "Architect";}else if(sVar=="017"){sVar = "Trainer";}

sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2building018";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "doorhouse001";fX = -0.7;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "zep_sign019";fX = -2.2;fY = -5.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,sVar);SetLocalObject(oFlag,"ShopSign",oPla);
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Starship
if(iChoice3==17)
    {
//
sS = "Starship";
s1 = "The airship station permits a connection between your domain and the other planets.";
sRes1  = COAL;      iRes1  = 1;
sRes2  = IRON_WOOD;      iRes2  = 4;
sRes3  = MERCURY;      iRes3  = 1;
sRes4  = MITHRIL;      iRes4  = 1;
sRes5  = QUARTZ;      iRes5  = 2;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 500;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "planettakeoff";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "plc_solwhite";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "lamppostoff";fX = -2.0;fY = -8.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "zep_sign013";fX = -2.8;fY = -8.0;fZ = 0.8;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Starship");
sBP = "pilot";fX = 2.0;fY = -8.0;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,"pilot2");SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalInt(oPla,"Stop",1);SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
if(iDomainIni==0)
       {
iDS = GetPersistentInt(oModule,sPlanet+"_DS")+1;
SetPersistentString(oModule,sPlanet+"_DS_"+IntToString(iDS),sArea+"&001&"+sVar11+"&002&");
SetPersistentInt(oModule,sPlanet+"_DS",iDS);
       }
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
sBP = "zep_shelter";fX = -3.5;fY = -3.5;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = -5.6;fY = -5.4;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = -5.6;fY = -4.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
sBP = "zep_shelter";fX = 3.5;fY = -3.5;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = 3.9;fY = -5.6;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "pla_bench";fX = 5.4;fY = -5.6;fZ = 0.0;fF = 270.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);AssignCommand(oPla,SetIsDestroyable(TRUE,FALSE,FALSE));
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Tavern
if(iChoice3==18)
    {
//
sS = "Tavern";
s1 = "The tavern is a refreshing place for all adventurers.";
sRes1  = BASIC_WOOD;      iRes1  = 2;
sRes2  = COAL;      iRes2  = 1;
sRes3  = COPPER;      iRes3  = 0;
sRes4  = STONE;      iRes4  = 2;
sRes5  = NONE;      iRes5  = 0;
sRes6  = NONE;      iRes6  = 0;
sRes7  = NONE;      iRes7  = 0;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 200;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 0.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2building021";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "doorhouse001";fX = -0.7;fY = -4.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "zep_sign009";fX = -2.2;fY = -5.0;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Tavern");
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Temple
if(iChoice3==19)
    {
//
sS = "Temple";
s1 = "The temple is a praying place containing a special shop for monks and clerics.";
sRes1  = IRON;      iRes1  = 3;
sRes2  = LEAD;      iRes2  = 1;
sRes3  = MERCURY;      iRes3  = 1;
sRes4  = STEEL;      iRes4  = 2;
sRes5  = STONE;      iRes5  = 3;
sRes6  = STRONG_WOOD;      iRes6  = 1;
sRes7  = TIN;      iRes7  = 1;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 300;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 4.0;fY = -8.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "nwn2building029";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
sBP = "doorhouse001";fX = -0.75;fY = -7.4;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetUseableFlag(oPla,FALSE);
sBP = "zep_sign";fX = -1.55;fY = -8.4;fZ = 0.0;fF = 180.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetPlotFlag(oPla,TRUE);SetUseableFlag(oPla,TRUE);SetName(oPla,"Temple");
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
// Tower
if(iChoice3==20)
    {
//
sS = "Tower";
s1 = "The tower is a huge building which content is similar to the dungeons.";
sRes1  = CRYSTAL;      iRes1  = 1;
sRes2  = IRON;      iRes2  = 3;
sRes3  = IRON_WOOD;      iRes3  = 1;
sRes4  = MERCURY;      iRes4  = 2;
sRes5  = STEEL;      iRes5  = 3;
sRes6  = STONE;      iRes6  = 5;
sRes7  = QUARTZ;      iRes7  = 1;
sRes8  = NONE;      iRes8  = 0;
sRes9  = NONE;      iRes9  = 0;
sRes10 = NONE;      iRes10 = 0;
iGold = 800;

iRes1 = iRes1*(iLevel+1);iRes2 = iRes2*(iLevel+1);iRes3 = iRes3*(iLevel+1);iRes4 = iRes4*(iLevel+1);iRes5 = iRes5*(iLevel+1);iRes6 = iRes6*(iLevel+1);iRes7 = iRes7*(iLevel+1);iRes8 = iRes8*(iLevel+1);iRes9 = iRes9*(iLevel+1);iRes10 = iRes10*(iLevel+1);iGold = iGold*(iLevel+1);
//
if((sDomainRes!="")||(iDomainIni==1))
     {
if(((iDomainIni==0)&&(iLevel==0))||((iDomainIni==1)&&(iLevel>0)))
      {
sBP = "structureflag";fX = 4.0;fY = -9.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}SetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot),oPla);SetName(oPla,sS+" level "+IntToString(iLevel));oFlag = oPla;
sBP = "ccp_lighttower";fX = 0.0;fY = 0.0;fZ = 0.0;fF = 90.0;lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPla,"StructureFlag",oFlag);SetLocalString(oPla,"Master",sMaster);SetLocalInt(oPla,"Slot",iSlot);SetLocalInt(oPla,"Structure",iChoice3);SetLocalInt(oPla,"DontSave",1);if(iDomainIni==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);}
      }
if(((iDomainIni==0)&&(iLevel==1))||((iDomainIni==1)&&(iLevel>1)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==2))||((iDomainIni==1)&&(iLevel>2)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==3))||((iDomainIni==1)&&(iLevel>3)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
if(((iDomainIni==0)&&(iLevel==4))||((iDomainIni==1)&&(iLevel>4)))
      {
if(iDomainIni==0){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),oFlag);}
      }
     }
//
    }
////////////////////////////////////////////////////////////////////////////////
   }
////////////////////////////////////////////////////////////////////////////////
  }
////////////////////////////////////////////////////////////////////////////////
     if(iSlot==1){sVar1L = IntToString(iChoice3);sVar1R = IntToString(iLevel+1);}
else if(iSlot==2){sVar2L = IntToString(iChoice3);sVar2R = IntToString(iLevel+1);}
else if(iSlot==3){sVar3L = IntToString(iChoice3);sVar3R = IntToString(iLevel+1);}
else if(iSlot==4){sVar4L = IntToString(iChoice3);sVar4R = IntToString(iLevel+1);}
else if(iSlot==5){sVar5L = IntToString(iChoice3);sVar5R = IntToString(iLevel+1);}
else if(iSlot==6){sVar6L = IntToString(iChoice3);sVar6R = IntToString(iLevel+1);}
else if(iSlot==7){sVar7L = IntToString(iChoice3);sVar7R = IntToString(iLevel+1);}
else if(iSlot==8){sVar8L = IntToString(iChoice3);sVar8R = IntToString(iLevel+1);}
else if(iSlot==9){sVar9L = IntToString(iChoice3);sVar9R = IntToString(iLevel+1);}
else if(iSlot==10){sVar10L = IntToString(iChoice3);sVar10R = IntToString(iLevel+1);}
//
 }
////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////
// Execute action
if(iDomainIni==0)
 {
iGold = iGold-(iGold*GetLocalInt(OBJECT_SELF,"Costs")/100);
if(sDomainRes!="")
  {
oFlag = GetLocalObject(OBJECT_SELF,"StructureFlag"+IntToString(iSlot));
SetName(oFlag,sS+" level "+IntToString(iLevel+1));
//
sRes1R = GetStringRight(sRes1,GetStringLength(sRes1)-FindSubString(sRes1,"_A_")-3);sRes2R = GetStringRight(sRes2,GetStringLength(sRes2)-FindSubString(sRes2,"_A_")-3);sRes3R = GetStringRight(sRes3,GetStringLength(sRes3)-FindSubString(sRes3,"_A_")-3);sRes4R = GetStringRight(sRes4,GetStringLength(sRes4)-FindSubString(sRes4,"_A_")-3);sRes5R = GetStringRight(sRes5,GetStringLength(sRes5)-FindSubString(sRes5,"_A_")-3);sRes6R = GetStringRight(sRes6,GetStringLength(sRes6)-FindSubString(sRes6,"_A_")-3);sRes7R = GetStringRight(sRes7,GetStringLength(sRes7)-FindSubString(sRes7,"_A_")-3);sRes8R = GetStringRight(sRes8,GetStringLength(sRes8)-FindSubString(sRes8,"_A_")-3);sRes9R = GetStringRight(sRes9,GetStringLength(sRes9)-FindSubString(sRes9,"_A_")-3);sRes10R = GetStringRight(sRes10,GetStringLength(sRes10)-FindSubString(sRes10,"_A_")-3);
if(!GetIsDM(oPC))
   {
oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem))
    {
     if((GetTag(oItem)==sRes1R)&&(iRes1>0)){iRes1--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes2R)&&(iRes2>0)){iRes2--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes3R)&&(iRes3>0)){iRes3--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes4R)&&(iRes4>0)){iRes4--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes5R)&&(iRes5>0)){iRes5--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes6R)&&(iRes6>0)){iRes6--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes7R)&&(iRes7>0)){iRes7--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes8R)&&(iRes8>0)){iRes8--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes9R)&&(iRes9>0)){iRes9--;DestroyObject(oItem);}
else if((GetTag(oItem)==sRes10R)&&(iRes10>0)){iRes10--;DestroyObject(oItem);}
oItem = GetNextItemInInventory(oPC);
    }
AssignCommand(oPC,TakeGoldFromCreature(iGold,oPC,TRUE));
   }
//
sVar = sVar1L+"%"+sVar1R+"_01_"+sVar2L+"%"+sVar2R+"_02_"+sVar3L+"%"+sVar3R+"_03_"+sVar4L+"%"+sVar4R+"_04_"+sVar5L+"%"+sVar5R+"_05_"+sVar6L+"%"+sVar6R+"_06_"+sVar7L+"%"+sVar7R+"_07_"+sVar8L+"%"+sVar8R+"_08_"+sVar9L+"%"+sVar9R+"_09_"+sVar10L+"%"+sVar10R+"_10_"+sVar11+"_11_";
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests",sInterestType+"&1&"+sMaster+"&2&"+sVar+"&3&"+sVisible+"&4&");
if(iLevel==0){FloatingTextStringOnCreature("Structure built",oPC);}else{FloatingTextStringOnCreature("Structure upgraded",oPC);}
DeleteLocalString(OBJECT_SELF,"Domain_Build");
DeleteLocalString(OBJECT_SELF,"Domain_Res");
DeleteLocalInt(OBJECT_SELF,"Domain_Upgrade");
  }
//
else
  {
sRes1L = GetStringLeft(sRes1,FindSubString(sRes1,"_A_"));sRes2L = GetStringLeft(sRes2,FindSubString(sRes2,"_A_"));sRes3L = GetStringLeft(sRes3,FindSubString(sRes3,"_A_"));sRes4L = GetStringLeft(sRes4,FindSubString(sRes4,"_A_"));sRes5L = GetStringLeft(sRes5,FindSubString(sRes5,"_A_"));sRes6L = GetStringLeft(sRes6,FindSubString(sRes6,"_A_"));sRes7L = GetStringLeft(sRes7,FindSubString(sRes7,"_A_"));sRes8L = GetStringLeft(sRes8,FindSubString(sRes8,"_A_"));sRes9L = GetStringLeft(sRes9,FindSubString(sRes9,"_A_"));sRes10L = GetStringLeft(sRes10,FindSubString(sRes10,"_A_"));
sRes1R = GetStringRight(sRes1,GetStringLength(sRes1)-FindSubString(sRes1,"_A_")-3);sRes2R = GetStringRight(sRes2,GetStringLength(sRes2)-FindSubString(sRes2,"_A_")-3);sRes3R = GetStringRight(sRes3,GetStringLength(sRes3)-FindSubString(sRes3,"_A_")-3);sRes4R = GetStringRight(sRes4,GetStringLength(sRes4)-FindSubString(sRes4,"_A_")-3);sRes5R = GetStringRight(sRes5,GetStringLength(sRes5)-FindSubString(sRes5,"_A_")-3);sRes6R = GetStringRight(sRes6,GetStringLength(sRes6)-FindSubString(sRes6,"_A_")-3);sRes7R = GetStringRight(sRes7,GetStringLength(sRes7)-FindSubString(sRes7,"_A_")-3);sRes8R = GetStringRight(sRes8,GetStringLength(sRes8)-FindSubString(sRes8,"_A_")-3);sRes9R = GetStringRight(sRes9,GetStringLength(sRes9)-FindSubString(sRes9,"_A_")-3);sRes10R = GetStringRight(sRes10,GetStringLength(sRes10)-FindSubString(sRes10,"_A_")-3);
if((sRes1L!="none")&&(iRes1!=0)){s2 = s2+IntToString(iRes1)+" "+sRes1L;}if((sRes2L!="none")&&(iRes2!=0)){s2 = s2+", "+IntToString(iRes2)+" "+sRes2L;}if((sRes3L!="none")&&(iRes3!=0)){s2 = s2+", "+IntToString(iRes3)+" "+sRes3L;}if((sRes4L!="none")&&(iRes4!=0)){s2 = s2+", "+IntToString(iRes4)+" "+sRes4L;}if((sRes5L!="none")&&(iRes5!=0)){s2 = s2+", "+IntToString(iRes5)+" "+sRes5L;}if((sRes6L!="none")&&(iRes6!=0)){s2 = s2+", "+IntToString(iRes6)+" "+sRes6L;}if((sRes7L!="none")&&(iRes7!=0)){s2 = s2+", "+IntToString(iRes7)+" "+sRes7L;}if((sRes8L!="none")&&(iRes8!=0)){s2 = s2+", "+IntToString(iRes8)+" "+sRes8L;}if((sRes9L!="none")&&(iRes9!=0)){s2 = s2+", "+IntToString(iRes9)+" "+sRes9L;}if((sRes10L!="none")&&(iRes10!=0)){s2 = s2+", "+IntToString(iRes10)+" "+sRes10L;}if(iGold!=0){s2 = s2+", "+IntToString(iGold)+" gold pieces";}
//
SetCustomToken(10065,s1);SetCustomToken(10066,s2);
SetLocalString(OBJECT_SELF,"Domain_Res",sRes1R+"_001_"+sRes2R+"_002_"+sRes3R+"_003_"+sRes4R+"_004_"+sRes5R+"_005_"+sRes6R+"_006_"+sRes7R+"_007_"+sRes8R+"_008_"+sRes9R+"_009_"+sRes10R+"_010_"+IntToString(iRes1)+"_011_"+IntToString(iRes2)+"_012_"+IntToString(iRes3)+"_013_"+IntToString(iRes4)+"_014_"+IntToString(iRes5)+"_015_"+IntToString(iRes6)+"_016_"+IntToString(iRes7)+"_017_"+IntToString(iRes8)+"_018_"+IntToString(iRes9)+"_019_"+IntToString(iRes10)+"_020_"+IntToString(iGold)+"_021_");
  }
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(OBJECT_SELF,"Domain_Ini");
////////////////////////////////////////////////////////////////////////////////
}
