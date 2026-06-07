#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastKiller();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}else if(GetStringRight(sArea,5)=="_Ship"){sArea = GetStringLeft(sArea,GetStringLength(sArea)-5);}
string sTot = GetPersistentString(oModule,sPlanet);
string sResources = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&005&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&005&")))-FindSubString(sTot,"&004&")-5);if(sResources=="self"){sResources = sPlanet;}
int iResources = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&008&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&008&")))-FindSubString(sTot,"&007&")-5));
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
int iMountain = GetLocalInt(OBJECT_SELF,"Mountain");
//
string sAreaBP = GetResRef(OBJECT_SELF);
string sTag = GetTag(OBJECT_SELF);
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;
float fZ = 0.0;if(GetStringLeft(GetTag(OBJECT_SELF),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(OBJECT_SELF),6)=="ground")||(GetStringLeft(GetTag(OBJECT_SELF),11)=="ruralcastle")){fZ = 5.0;}
int iRandom1;int iRandom2;string sBP;string sBP2;object oNew;object oCre;int iPlant;int iTree;int iRock;string sPla;int iPlanetResNbr;float fAX;float fAY;float fX;float fY;float fF;int iRandom;location lLoc;int iNum;int iNum1;int iNum2;int iNum3;int iCheck;int i;
// Resource mountain
if(iMountain==1){iPlanetResNbr = Random(21)+20;}
// Domain extractor & field
else if(GetStringLeft(sInterests,1)=="D"){iPlanetResNbr = 60;iNum = 1;}
// Normal
else if(iResources>0){iPlanetResNbr = Random(10)+1;if(iPlanetResNbr<6){iPlanetResNbr = -iPlanetResNbr;}else{iPlanetResNbr = iPlanetResNbr-5;}iPlanetResNbr = iResources+iPlanetResNbr;}
if(iPlanetResNbr<0){iPlanetResNbr = 0;}
//
string ASTEROID = "pla_asteroid";
string PLANT = "pla_plant";
string ROCK = "pla_rock";
string TREE = "pla_tree";
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Resource cut
if(((sTag==ASTEROID)||(sTag==PLANT)||(sTag==ROCK)||(sTag==TREE))&&(GetLocalInt(OBJECT_SELF,"Destroyed")!=1))
 {
oPC = GetLocalObject(OBJECT_SELF,"Killer");
sResources = GetLocalString(OBJECT_SELF,"Var");

iRandom1 = Random(10)+1;if(iRandom1<7){iRandom1 = 1;}else if(iRandom1<10){iRandom1 = 2;}else{iRandom1 = 3;}
while(iRandom1>0){iRandom1--;oNew = CreateObject(OBJECT_TYPE_ITEM,sResources,GetLocation(OBJECT_SELF));}
int n;int iXP = 5;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
GiveXPToCreature(oPC,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
// First
int a = 17;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Space asteroids
else if(GetStringLeft(GetTag(OBJECT_SELF),6)=="space0")
 {
fX = IntToFloat(iAreaX/2);
fY = IntToFloat(iAreaY/2);
i = Random(40)+20;
while(i>0)
  {
fAX = IntToFloat(Random(iAreaX));
fAY = IntToFloat(Random(iAreaY));
if(((fAX<fX-10.0)||(fAX>fX+10.0))&&((fAY<fY-10.0)||(fAY>fY+10.0))){i--;iRandom = Random(100)+1;if(GetStringLeft(GetTag(OBJECT_SELF),6)=="space0"){if(iRandom==1){sBP = "pla_spacedung001";}else if(iRandom==2){sBP = "pla_spacedung002";}}if(iRandom<12){sBP = "pla_asteroid";}else{sBP = "asteroid00"+IntToString(Random(3)+1);}oNew = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,Location(OBJECT_SELF,Vector(fAX,fAY,fZ),IntToFloat(Random(360))));}

if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(11)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_lavafusion";}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_mana";}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_coal";}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_copper";}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_iron";}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_lead";}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_mercury";}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_stone";}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_tin";}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_quartz";}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_thunderstone";}

SetLocalString(oNew,"Var",sBP);
  }
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Place resources
else if((sResources!="")&&(sResources!="none")&&(GetStringLeft(GetTag(OBJECT_SELF),6)!="clouds"))
 {
while(iPlanetResNbr>0){iPlanetResNbr--;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Underwater
if(GetStringLeft(GetTag(OBJECT_SELF),10)=="underwater")
  {
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(11)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_entzun";sPla = PLANT;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_kalagkoth";sPla = PLANT;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_kizguth";sPla = PLANT;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_samshak";sPla = PLANT;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_sand";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_quartz";sPla = ROCK;}
  }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if((sResources=="Arland")||(sResources=="Alderan")){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(68)+1;}
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "cr_apple";sPla = PLANT;} // PLANT ROCK TREE
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "cr_banana";sPla = PLANT;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "cr_cereal";sPla = PLANT;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "cr_cherry";sPla = PLANT;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "cr_grape";sPla = PLANT;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "cr_jelly";sPla = PLANT;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=20)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=22)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=23)&&(iRandom1<=24)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=25)&&(iRandom1<=26)){sBP = "cr_woodbasic";sPla = TREE;}
else if((iRandom1>=27)&&(iRandom1<=28)){sBP = "cr_woodsoft";sPla = TREE;}
else if((iRandom1>=29)&&(iRandom1<=30)){sBP = "cr_woodstrong";sPla = TREE;}
else if((iRandom1>=31)&&(iRandom1<=32)){sBP = "cr_arabano";sPla = PLANT;}
else if((iRandom1>=33)&&(iRandom1<=34)){sBP = "cr_astrakan";sPla = PLANT;}
else if((iRandom1>=35)&&(iRandom1<=40)){sBP = "cr_barbazun";sPla = PLANT;}
else if((iRandom1>=41)&&(iRandom1<=41)){sBP = "cr_bouzkashi";sPla = PLANT;}
else if((iRandom1>=42)&&(iRandom1<=42)){sBP = "cr_clover";sPla = PLANT;}
else if((iRandom1>=43)&&(iRandom1<=43)){sBP = "cr_cotton";sPla = PLANT;}
else if((iRandom1>=44)&&(iRandom1<=44)){sBP = "cr_hino";sPla = PLANT;}
else if((iRandom1>=45)&&(iRandom1<=45)){sBP = "cr_jinja";sPla = PLANT;}
else if((iRandom1>=46)&&(iRandom1<=46)){sBP = "cr_mika";sPla = PLANT;}
else if((iRandom1>=47)&&(iRandom1<=47)){sBP = "cr_shosho";sPla = PLANT;}
else if((iRandom1>=48)&&(iRandom1<=48)){sBP = "cr_sokol";sPla = PLANT;}
else if((iRandom1>=49)&&(iRandom1<=49)){sBP = "cr_tiaranwe";sPla = PLANT;}
else if((iRandom1>=50)&&(iRandom1<=50)){sBP = "cr_strawberry";sPla = PLANT;}
else if((iRandom1>=51)&&(iRandom1<=51)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=52)&&(iRandom1<=52)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=53)&&(iRandom1<=53)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=54)&&(iRandom1<=54)){sBP = "cr_gem010";sPla = ROCK;}
else if((iRandom1>=55)&&(iRandom1<=55)){sBP = "cr_gem011";sPla = ROCK;}
else if((iRandom1>=56)&&(iRandom1<=56)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=57)&&(iRandom1<=68)){sBP = "cr_plantcommon";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if((sResources=="Astdin")||(sResources=="Beleth")){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(48)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_apple";sPla = TREE;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_banana";sPla = TREE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_cereal";sPla = PLANT;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_grape";sPla = PLANT;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_woodsoft";sPla = TREE;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_woodstrong";sPla = TREE;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_arabano";sPla = PLANT;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_astrakan";sPla = PLANT;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_barbazun";sPla = PLANT;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_bouzkashi";sPla = PLANT;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_cajun";sPla = PLANT;}
else if((iRandom1>=26)&&(iRandom1<=26)){sBP = "cr_clover";sPla = PLANT;}
else if((iRandom1>=27)&&(iRandom1<=27)){sBP = "cr_cotton";sPla = PLANT;}
else if((iRandom1>=28)&&(iRandom1<=28)){sBP = "cr_hino";sPla = PLANT;}
else if((iRandom1>=29)&&(iRandom1<=29)){sBP = "cr_jinja";sPla = PLANT;}
else if((iRandom1>=30)&&(iRandom1<=30)){sBP = "cr_sokol";sPla = PLANT;}
else if((iRandom1>=31)&&(iRandom1<=31)){sBP = "cr_tiaranwe";sPla = PLANT;}
else if((iRandom1>=32)&&(iRandom1<=32)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=33)&&(iRandom1<=33)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=34)&&(iRandom1<=34)){sBP = "cr_strawberry";sPla = PLANT;}
else if((iRandom1>=35)&&(iRandom1<=35)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=36)&&(iRandom1<=36)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=37)&&(iRandom1<=37)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=38)&&(iRandom1<=38)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=39)&&(iRandom1<=39)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=40)&&(iRandom1<=40)){sBP = "cr_gem010";sPla = ROCK;}
else if((iRandom1>=41)&&(iRandom1<=41)){sBP = "cr_gem011";sPla = ROCK;}
else if((iRandom1>=42)&&(iRandom1<=42)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=43)&&(iRandom1<=43)){sBP = "cr_gem015";sPla = ROCK;}
else if((iRandom1>=44)&&(iRandom1<=48)){sBP = "cr_plantcommon";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if((sResources=="Brillar")||(sResources=="Kleth")){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(13)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_copper";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_astrakan";sPla = PLANT;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_barbazun";sPla = PLANT;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_belvedere";sPla = PLANT;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_elhuin";sPla = PLANT;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_garlic";sPla = PLANT;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_hashbushin";sPla = PLANT;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_hino";sPla = PLANT;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_mika";sPla = PLANT;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_shosho";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if((sResources=="Delendil")||(sResources=="Narn")){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(44)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_apple";sPla = TREE;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_banana";sPla = TREE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_cereal";sPla = PLANT;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_cherry";sPla = TREE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_garlic";sPla = PLANT;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_grape";sPla = PLANT;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_jelly";sPla = PLANT;}
else if((iRandom1>=8)&&(iRandom1<=10)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=13)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=16)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "cr_woodbasic";sPla = TREE;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_astrakan";sPla = PLANT;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_barbazun";sPla = PLANT;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_clover";sPla = PLANT;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_hino";sPla = PLANT;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_jinja";sPla = PLANT;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_mika";sPla = PLANT;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_shosho";sPla = PLANT;}
else if((iRandom1>=26)&&(iRandom1<=26)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=27)&&(iRandom1<=27)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=28)&&(iRandom1<=28)){sBP = "cr_strawberry";sPla = PLANT;}
else if((iRandom1>=29)&&(iRandom1<=29)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=30)&&(iRandom1<=30)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=31)&&(iRandom1<=31)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=32)&&(iRandom1<=32)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=33)&&(iRandom1<=33)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=34)&&(iRandom1<=34)){sBP = "cr_gem010";sPla = ROCK;}
else if((iRandom1>=35)&&(iRandom1<=35)){sBP = "cr_gem011";sPla = ROCK;}
else if((iRandom1>=36)&&(iRandom1<=36)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=37)&&(iRandom1<=37)){sBP = "cr_gem015";sPla = ROCK;}
else if((iRandom1>=38)&&(iRandom1<=44)){sBP = "cr_plantcommon";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Galaxia"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(45)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_apple";sPla = TREE;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_bronze";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_gold";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_cereal";sPla = PLANT;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_garlic";sPla = PLANT;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_steel";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_woodsoft";sPla = TREE;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_woodstrong";sPla = TREE;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_woodiron";sPla = TREE;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_arabano";sPla = PLANT;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_astrakan";sPla = PLANT;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_belvedere";sPla = PLANT;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_bouzkashi";sPla = PLANT;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_elhuin";sPla = PLANT;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_hashbushin";sPla = PLANT;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_hino";sPla = PLANT;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_rainbow";sPla = PLANT;}
else if((iRandom1>=26)&&(iRandom1<=26)){sBP = "cr_tiaranwe";sPla = PLANT;}
else if((iRandom1>=27)&&(iRandom1<=27)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=28)&&(iRandom1<=28)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=29)&&(iRandom1<=29)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=30)&&(iRandom1<=30)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=31)&&(iRandom1<=31)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=32)&&(iRandom1<=32)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=33)&&(iRandom1<=33)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=34)&&(iRandom1<=34)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=35)&&(iRandom1<=35)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=36)&&(iRandom1<=36)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=37)&&(iRandom1<=37)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=38)&&(iRandom1<=38)){sBP = "cr_gem015";sPla = ROCK;}
else if((iRandom1>=39)&&(iRandom1<=45)){sBP = "cr_plantcommon";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Hinz"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(26)+1;}
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_crystal";sPla = ROCK;}
else if((iRandom1>=8)&&(iRandom1<=10)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=26)&&(iRandom1<=26)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Kartac"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(25)+1;}
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "cr_banana";sPla = TREE;} // PLANT ROCK TREE
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "cr_grape";sPla = TREE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=9)){sBP = "cr_woodbasic";sPla = TREE;}
else if((iRandom1>=10)&&(iRandom1<=12)){sBP = "cr_woodsoft";sPla = TREE;}
else if((iRandom1>=13)&&(iRandom1<=15)){sBP = "cr_woodstrong";sPla = TREE;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_woodiron";sPla = TREE;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_clover";sPla = PLANT;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_shosho";sPla = PLANT;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_gem010";sPla = ROCK;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_gem011";sPla = ROCK;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_plantcommon";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Khanyo"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(20)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_iron";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_arabano";sPla = PLANT;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_astrakan";sPla = PLANT;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_barbazun";sPla = PLANT;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_bouzkashi";sPla = PLANT;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_cajun";sPla = PLANT;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_clover";sPla = PLANT;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_hino";sPla = PLANT;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_jinja";sPla = PLANT;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_mika";sPla = PLANT;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_shosho";sPla = PLANT;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_sokol";sPla = PLANT;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_tiaranwe";sPla = PLANT;}
else if((iRandom1>=15)&&(iRandom1<=17)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=20)){sBP = "cr_plantcommon";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Mo1"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(21)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_gold";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Mo2"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(21)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_gold";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_steel";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Mo3"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(36)+1;}
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "cr_gold";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=9)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=12)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=15)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_adamantine";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_crystal";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=20)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_platine";sPla = ROCK;}
else if((iRandom1>=23)&&(iRandom1<=25)){sBP = "cr_steel";sPla = ROCK;}
else if((iRandom1>=26)&&(iRandom1<=27)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=28)&&(iRandom1<=28)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=29)&&(iRandom1<=29)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=30)&&(iRandom1<=30)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=31)&&(iRandom1<=31)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=32)&&(iRandom1<=32)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=33)&&(iRandom1<=33)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=34)&&(iRandom1<=34)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=35)&&(iRandom1<=35)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=36)&&(iRandom1<=36)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if((sResources=="Otun")||(sResources=="Sterign")){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(16)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_gem010";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_gem011";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_gem012";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if((sResources=="Ozgurbur")||(sResources=="Kah")){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(16)+1;}
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "cr_crystal";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Ronde"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(14)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_gold";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_adamantine";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_crystal";sPla = ROCK;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_platine";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Sand"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(29)+1;}
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "cr_bronze";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=20)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_gem003";sPla = ROCK;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=26)&&(iRandom1<=26)){sBP = "cr_gem010";sPla = ROCK;}
else if((iRandom1>=27)&&(iRandom1<=27)){sBP = "cr_gem011";sPla = ROCK;}
else if((iRandom1>=28)&&(iRandom1<=28)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=29)&&(iRandom1<=29)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Tend"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(60)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_apple";sPla = TREE;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_banana";sPla = TREE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_bronze";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_gold";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_cereal";sPla = PLANT;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_garlic";sPla = PLANT;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_grape";sPla = PLANT;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_adamantine";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_coal";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_crystal";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_mercury";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_mithril";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_platine";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_sand";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_stone";sPla = ROCK;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_woodbasic";sPla = TREE;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_woodiron";sPla = TREE;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_woodsoft";sPla = TREE;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_woodstrong";sPla = TREE;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_arabano";sPla = PLANT;}
else if((iRandom1>=26)&&(iRandom1<=26)){sBP = "cr_astrakan";sPla = PLANT;}
else if((iRandom1>=27)&&(iRandom1<=27)){sBP = "cr_barbazun";sPla = PLANT;}
else if((iRandom1>=28)&&(iRandom1<=28)){sBP = "cr_belvedere";sPla = PLANT;}
else if((iRandom1>=29)&&(iRandom1<=29)){sBP = "cr_bouzkashi";sPla = PLANT;}
else if((iRandom1>=30)&&(iRandom1<=30)){sBP = "cr_cajun";sPla = PLANT;}
else if((iRandom1>=31)&&(iRandom1<=31)){sBP = "cr_clover";sPla = PLANT;}
else if((iRandom1>=32)&&(iRandom1<=32)){sBP = "cr_cotton";sPla = PLANT;}
else if((iRandom1>=33)&&(iRandom1<=33)){sBP = "cr_elhuin";sPla = PLANT;}
else if((iRandom1>=34)&&(iRandom1<=34)){sBP = "cr_hashbushin";sPla = PLANT;}
else if((iRandom1>=35)&&(iRandom1<=35)){sBP = "cr_hino";sPla = PLANT;}
else if((iRandom1>=36)&&(iRandom1<=36)){sBP = "cr_jinja";sPla = PLANT;}
else if((iRandom1>=37)&&(iRandom1<=37)){sBP = "cr_mika";sPla = PLANT;}
else if((iRandom1>=38)&&(iRandom1<=38)){sBP = "cr_rainbow";sPla = PLANT;}
else if((iRandom1>=39)&&(iRandom1<=39)){sBP = "cr_shosho";sPla = PLANT;}
else if((iRandom1>=30)&&(iRandom1<=40)){sBP = "cr_sokol";sPla = PLANT;}
else if((iRandom1>=41)&&(iRandom1<=41)){sBP = "cr_tiaranwe";sPla = PLANT;}
else if((iRandom1>=42)&&(iRandom1<=42)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=43)&&(iRandom1<=43)){sBP = "cr_strawberry";sPla = PLANT;}
else if((iRandom1>=44)&&(iRandom1<=44)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=45)&&(iRandom1<=45)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=46)&&(iRandom1<=46)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=47)&&(iRandom1<=47)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=48)&&(iRandom1<=48)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=49)&&(iRandom1<=49)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=50)&&(iRandom1<=50)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=51)&&(iRandom1<=51)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=52)&&(iRandom1<=52)){sBP = "cr_gem015";sPla = ROCK;}
else if((iRandom1>=53)&&(iRandom1<=60)){sBP = "cr_plantcommon";sPla = PLANT;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Terlation"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(22)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_diamond";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_gold";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_lavafusion";sPla = ROCK;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_adamantine";sPla = ROCK;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_crystal";sPla = ROCK;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_diamondine";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_mithril";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_platine";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_belvedere";sPla = PLANT;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_elhuin";sPla = PLANT;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_hashbushin";sPla = PLANT;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_rainbow";sPla = PLANT;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_gem006";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_gem013";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Washisch"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(21)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_silver";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "cr_coldstone";sPla = ROCK;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "cr_atraktkot";sPla = PLANT;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "cr_gadnar";sPla = PLANT;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "cr_kalagkoth";sPla = PLANT;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "cr_roparz";sPla = PLANT;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "cr_vewyn";sPla = PLANT;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "cr_copper";sPla = ROCK;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "cr_iron";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "cr_lead";sPla = ROCK;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "cr_tin";sPla = ROCK;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "cr_cajun";sPla = PLANT;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "cr_rainbow";sPla = PLANT;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "cr_gem002";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_gem008";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_gem012";sPla = ROCK;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
}else if(sResources=="Wyderl"){
////////////////////////////////////////////////////////////////////////////////
if(iNum!=0){iRandom1 = iNum;}else{iRandom1 = Random(38)+1;}
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "cr_diamond";sPla = ROCK;} // PLANT ROCK TREE
else if((iRandom1>=2)&&(iRandom1<=3)){sBP = "cr_gold";sPla = ROCK;}
else if((iRandom1>=4)&&(iRandom1<=7)){sBP = "cr_silver";sPla = ROCK;}
else if((iRandom1>=8)&&(iRandom1<=9)){sBP = "cr_adamantine";sPla = ROCK;}
else if((iRandom1>=10)&&(iRandom1<=12)){sBP = "cr_lavafusion";sPla = ROCK;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "cr_crystal";sPla = ROCK;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "cr_diamondine";sPla = ROCK;}
else if((iRandom1>=16)&&(iRandom1<=17)){sBP = "cr_mithril";sPla = ROCK;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "cr_platine";sPla = ROCK;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "cr_atraktkot";sPla = PLANT;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "cr_entzun";sPla = PLANT;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "cr_gadnar";sPla = PLANT;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "cr_kalagkoth";sPla = PLANT;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "cr_kizguth";sPla = PLANT;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "cr_roparz";sPla = PLANT;}
else if((iRandom1>=25)&&(iRandom1<=25)){sBP = "cr_samshak";sPla = PLANT;}
else if((iRandom1>=26)&&(iRandom1<=26)){sBP = "cr_vewyn";sPla = PLANT;}
else if((iRandom1>=27)&&(iRandom1<=27)){sBP = "cr_belvedere";sPla = PLANT;}
else if((iRandom1>=28)&&(iRandom1<=28)){sBP = "cr_powder";sPla = ROCK;}
else if((iRandom1>=29)&&(iRandom1<=29)){sBP = "cr_quartz";sPla = ROCK;}
else if((iRandom1>=30)&&(iRandom1<=30)){sBP = "cr_thunderstone";sPla = ROCK;}
else if((iRandom1>=31)&&(iRandom1<=31)){sBP = "cr_gem001";sPla = ROCK;}
else if((iRandom1>=32)&&(iRandom1<=32)){sBP = "cr_gem004";sPla = ROCK;}
else if((iRandom1>=33)&&(iRandom1<=33)){sBP = "cr_gem005";sPla = ROCK;}
else if((iRandom1>=34)&&(iRandom1<=34)){sBP = "cr_gem007";sPla = ROCK;}
else if((iRandom1>=35)&&(iRandom1<=35)){sBP = "cr_gem009";sPla = ROCK;}
else if((iRandom1>=36)&&(iRandom1<=36)){sBP = "cr_gem013";sPla = ROCK;}
else if((iRandom1>=37)&&(iRandom1<=37)){sBP = "cr_gem014";sPla = ROCK;}
else if((iRandom1>=38)&&(iRandom1<=38)){sBP = "cr_gem015";sPla = ROCK;}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
if(iMountain==1)
  {
if(sPla==ROCK)
   {
iRandom = Random(3)+1;
     if(iRandom==1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX/2)),IntToFloat(Random(iAreaY/2)+(iAreaY/2)),0.0),0.0);}
else if(iRandom==2){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX/2)),IntToFloat(Random(iAreaY/2)),0.0),0.0);}
else if(iRandom==3){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX/2)+(iAreaX/2)),IntToFloat(Random(iAreaY/2)+(iAreaY/2)),0.0),0.0);}
iCheck = 0;
   }
else
   {
iPlanetResNbr++;
iCheck = 1;
   }
  }
else
  {
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(80)+80),IntToFloat(Random(80)+80),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.2),0.0);}
  }
//
if(GetStringLeft(sInterests,1)=="D")
  {
SetLocalInt(OBJECT_SELF,"DomResIni",1);
     if((sPla==PLANT)&&(sBP!=sBP2)){iNum1++;oNew = CreateObject(OBJECT_TYPE_ITEM,sBP,lLoc);SetLocalString(oModule,sPlanet+"Plant"+IntToString(iNum1),sBP+"%"+GetName(oNew));DestroyObject(oNew);sBP2 = sBP;}
else if((sPla==ROCK)&&(sBP!=sBP2)) {iNum2++;oNew = CreateObject(OBJECT_TYPE_ITEM,sBP,lLoc);SetLocalString(oModule,sPlanet+"Rock"+IntToString(iNum2),sBP+"%"+GetName(oNew));DestroyObject(oNew);sBP2 = sBP;}
else if((sPla==TREE)&&(sBP!=sBP2)&&((sBP=="cr_woodbasic")||(sBP=="cr_woodiron")||(sBP=="cr_woodsoft")||(sBP=="cr_woodstrong"))){iNum3++;oNew = CreateObject(OBJECT_TYPE_ITEM,sBP,lLoc);SetLocalString(oModule,sPlanet+"Tree"+IntToString(iNum3),sBP+"%"+GetName(oNew)); DestroyObject(oNew);sBP2 = sBP;}
iNum++;
  }
else if(iCheck==0)
  {
oCre = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",lLoc);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,sPla,GetLocation(oCre));
SetLocalString(oNew,"Var",sBP);
DestroyObject(oCre);
if(iMountain==1){SetLocalInt(oNew,"DontSave",1);SetPlotFlag(oNew,TRUE);}
  }
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}}
