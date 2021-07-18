#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");if(GetStringRight(sArea,5)=="_Ship"){sArea = GetStringLeft(sArea,GetStringLength(sArea)-5);}
string sTot = GetPersistentString(oModule,sPlanet);
string sCreatures = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&004&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&004&")))-FindSubString(sTot,"&003&")-5);if(sCreatures=="self"){sCreatures = sPlanet;}
int iCreatures = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&007&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&007&")))-FindSubString(sTot,"&006&")-5));
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));
//
string sAreaBP = GetResRef(OBJECT_SELF);
int iNoCamp = GetLocalInt(OBJECT_SELF,"NoCamp");
int iCampSize = GetLocalInt(OBJECT_SELF,"CampSize");
//
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;
float fX = IntToFloat(iAreaX/2);
float fY = IntToFloat(iAreaY/2);
float fZ = 0.0;if(GetStringLeft(GetTag(OBJECT_SELF),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(OBJECT_SELF),6)=="ground")||(GetStringLeft(GetTag(OBJECT_SELF),11)=="ruralcastle")){fZ = 5.0;}

int iRandom1;int iRandom2;string sBP;int iFaction;object oNew;int iPlanetCreNbr;location lLoc;int DEFAULT = 5;
// Leader
int iLeader = 4; //*// Creatures have 1 chance on iLeader to be a leader
//
if(iCreatures>0){iPlanetCreNbr = Random(10)+1;if(iPlanetCreNbr<6){iPlanetCreNbr = -iPlanetCreNbr;}else{iPlanetCreNbr = iPlanetCreNbr-5;}iPlanetCreNbr = iCreatures+iPlanetCreNbr;}if(iPlanetCreNbr<0){iPlanetCreNbr = 0;}
////////////////////////////////////////////////////////////////////////////////
if(iCampSize==0){
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Space
if(GetStringLeft(GetTag(OBJECT_SELF),6)=="space0"){iPlanetCreNbr = 1;while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
if(Random(10)==0){sBP = "mn_spacepirat001";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
// Clouds
else if(GetStringLeft(GetTag(OBJECT_SELF),6)=="clouds"){iPlanetCreNbr = 10;while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";

if(iLevel<4)
  {
iRandom1 = Random(7)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_bird001";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_bird002";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_bird003";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_eagle001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_falcon001";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_owl002";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_raven001";iFaction = DEFAULT;}
  }
else if(iLevel<7)
  {
iRandom1 = Random(3)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_elemair001";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_griffon001";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_livcloud001";iFaction = DEFAULT;}
  }
else
  {
iRandom1 = Random(2)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_djinni001";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_djinni002";iFaction = DEFAULT;}
  }
////////////////////////////////////////////////////////////////////////////////
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
// Underwater
else if(GetStringLeft(GetTag(OBJECT_SELF),10)=="underwater"){iPlanetCreNbr = 12;while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";

if(iLevel<4)
  {
iRandom1 = Random(21)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_fish001";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_fish002";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_spider001";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_jellyfish001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_crab001";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_crab004";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_crab008";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_fish003";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_crab003";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_crab007";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_amphibia002";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_barracuda003";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_jellyfish002";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_ray001";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_amphibia003";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_dryad001";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_shark002";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_jellyfish003";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_octopus001";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_dolphin001";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_eal001";iFaction = DEFAULT;}
  }
else if(iLevel<7)
  {
iRandom1 = Random(21)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_amphibia002";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_barracuda003";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_jellyfish002";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_ray001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_amphibia003";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_dryad001";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_shark002";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_jellyfish003";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_octopus001";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_barracuda001";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=11))  {sBP = "mn_shark003";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_dolphin001";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_jellyfish004";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_octopus002";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_nereid001";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_nereid002";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_shark004";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_barracuda002";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_aboleth001";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_shark001";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_eal002";iFaction = DEFAULT;}
  }
else
  {
iRandom1 = Random(12)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_jellyfish004";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_octopus002";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_nereid001";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_nereid002";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_shark004";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_barracuda002";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_aboleth001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_shark001";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_octopus003";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_octopus004";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_crab002";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_crab005";iFaction = DEFAULT;}
  }
////////////////////////////////////////////////////////////////////////////////
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if((sCreatures=="Arland")||(sCreatures=="Alderan")){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(29)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_small_ani002";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_small_ani001";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_bear006";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_beetle009";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_beetle010";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_beetle002";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_boar001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_boar002";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_boar003";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_butterfly";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_deer003";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_deer002";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_deer001";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_falcon001";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_small_ani003";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_small_ani004";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_frog001";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_small_ani005";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_owl001";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_small_ani006";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_rat001";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_raven001";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_small_ani008";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_small_ani009";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_spider002";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_stirge001";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_small_ani010";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_wolf001";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_small_ani011";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if((sCreatures=="Astdin")||(sCreatures=="Beleth")){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(30)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_humaamaz002";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_humaamaz001";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_humaamaz003";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_humaamaz004";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_wildbeef001";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_wildbeef003";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_wildbeef002";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_antelope003";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_antelope002";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_badgerdire";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_basilik001";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_bear002";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_bear004";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_beetle005";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_beetle003";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_beetle006";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_beetle004";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_bird001";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_direboar001";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_mammouth006";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_goat001";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_feline008";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_snake008";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_snake007";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_spider010";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_spider003";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_spider005";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_feline002";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_wasp001";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_direwolf";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if((sCreatures=="Brillar")||(sCreatures=="Kleth")){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(3)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_golem004";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_golem005";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_golem008";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if((sCreatures=="Delendil")||(sCreatures=="Narn")){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(45)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_vines01";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_badgerdire";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_bandit007";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_bandit006";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_bandit012";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_bandit005";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_bear001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_bear002";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_beetle005";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_beetle003";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_beetle006";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_beetle004";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_beetle009";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_beetle007";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_beetle010";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_beetle008";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_bird004";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_direboar001";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_centipede001";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_centipede002";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_feline001";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_deer003";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_deer002";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_deer001";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_falcon001";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_bandit016";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_bandit015";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_bandit014";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_bandit013";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_goat001";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_anilizard003";iFaction = DEFAULT;}
else if((iRandom1>=32)&&(iRandom1<=32))  {sBP = "mn_anilizard002";iFaction = DEFAULT;}
else if((iRandom1>=33)&&(iRandom1<=33))  {sBP = "mn_anilizard001";iFaction = DEFAULT;}
else if((iRandom1>=34)&&(iRandom1<=34))  {sBP = "mn_humanomad001";iFaction = DEFAULT;}
else if((iRandom1>=35)&&(iRandom1<=35))  {sBP = "mn_humanomad002";iFaction = DEFAULT;}
else if((iRandom1>=36)&&(iRandom1<=36))  {sBP = "mn_humanomad003";iFaction = DEFAULT;}
else if((iRandom1>=37)&&(iRandom1<=37))  {sBP = "mn_feline008";iFaction = DEFAULT;}
else if((iRandom1>=38)&&(iRandom1<=38))  {sBP = "mn_snake005";iFaction = DEFAULT;}
else if((iRandom1>=39)&&(iRandom1<=39))  {sBP = "mn_spider010";iFaction = DEFAULT;}
else if((iRandom1>=40)&&(iRandom1<=40))  {sBP = "mn_spider004";iFaction = DEFAULT;}
else if((iRandom1>=41)&&(iRandom1<=41))  {sBP = "mn_stirge002";iFaction = DEFAULT;}
else if((iRandom1>=42)&&(iRandom1<=42))  {sBP = "mn_feline002";iFaction = DEFAULT;}
else if((iRandom1>=43)&&(iRandom1<=43))  {sBP = "mn_wasp001";iFaction = DEFAULT;}
else if((iRandom1>=44)&&(iRandom1<=44))  {sBP = "mn_direwolf";iFaction = DEFAULT;}
else if((iRandom1>=45)&&(iRandom1<=45))  {sBP = "mn_worg001";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Galaxia"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(31)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_basilik002";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_bear004";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_beast001";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_chimera001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_follower003";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_follower004";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_follower001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_follower002";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_follower005";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_ghost";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_ghostfemale";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_gorochem001";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_kaldisciple";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_kalwitch";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_kenku019";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_kenku022";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_kenku020";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_kenku021";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_manticore002";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_rust001";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_shadow";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_dagma02";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_shadfiend";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_shadeservant";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_spider015";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_spider011";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_spider008";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_stirge005";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_wyvern003";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_wyvern002";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_wyvern001";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Hinz"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(30)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_bear005";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_bugbear011";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_bugbear012";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_bugbear014";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_bugbear013";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_deer006";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_deer005";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_deer004";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_elemair001";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_gnoll009";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_gnoll010";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_gnoll011";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_gnoll012";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_snowgoblin001";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_snowgoblin004";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_snowgoblin003";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_snowgoblin002";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_kobold011";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_kobold012";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_kobold014";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_kobold013";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_lizard021";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_lizard023";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_lizard022";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_lizard025";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_lizard024";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_mammouth001";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_mammouth002";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_mammouth003";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_small_ani005";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Kartac"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(31)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_badgerdire";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_bear001";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_bear002";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_bird003";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_direboar001";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_centaur002";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_centaur001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_centipede003";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_centipede002";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_centipede001";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_deer003";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_deer002";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_deer001";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_dragonfly001";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_humanomad001";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_humanomad002";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_humanomad003";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_feline008";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_snake009";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_snake008";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_snake007";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_spider010";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_spider003";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_spider006";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_spider005";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_stirge004";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_stirge003";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_treant";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_unicorn001";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_wolf001";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_direwolf";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Khanyo"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(6)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_crab003";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_crab001";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_crab004";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_crab007";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_crab008";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_spider001";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Mo1"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(42)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_energy001";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_ankheg003";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_ankheg002";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_ankheg001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_basilik002";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_drider001";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_drider003";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_drider004";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_drider002";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_cavegoblin001";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_cavegoblin005";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_cavegoblin003";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_cavegoblin002";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_cavegoblin004";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_cavegoblin006";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_gorochem001";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_gorochem002";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_lizard031";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_lizard033";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_lizard032";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_lizard035";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_lizard034";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_otyugh002";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_okyun";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_ooze005";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_orcunder005";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_orcunder006";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_orcunder003";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_orcunder001";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_orcunder002";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_orcunder004";iFaction = DEFAULT;}
else if((iRandom1>=32)&&(iRandom1<=32))  {sBP = "mn_otyugh001";iFaction = DEFAULT;}
else if((iRandom1>=33)&&(iRandom1<=33))  {sBP = "mn_phyrexian002";iFaction = DEFAULT;}
else if((iRandom1>=34)&&(iRandom1<=34))  {sBP = "mn_rust001";iFaction = DEFAULT;}
else if((iRandom1>=35)&&(iRandom1<=35))  {sBP = "mn_spider015";iFaction = DEFAULT;}
else if((iRandom1>=36)&&(iRandom1<=36))  {sBP = "mn_spider011";iFaction = DEFAULT;}
else if((iRandom1>=37)&&(iRandom1<=37))  {sBP = "mn_stirge005";iFaction = DEFAULT;}
else if((iRandom1>=38)&&(iRandom1<=38))  {sBP = "mn_stogoth2";iFaction = DEFAULT;}
else if((iRandom1>=39)&&(iRandom1<=39))  {sBP = "mn_stogoth";iFaction = DEFAULT;}
else if((iRandom1>=40)&&(iRandom1<=40))  {sBP = "mn_ultroloth";iFaction = DEFAULT;}
else if((iRandom1>=41)&&(iRandom1<=41))  {sBP = "mn_umberhulk001";iFaction = DEFAULT;}
else if((iRandom1>=42)&&(iRandom1<=42))  {sBP = "mn_xorn";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Mo2"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(42)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_energy001";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_ankheg003";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_ankheg002";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_ankheg001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_basilik002";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_drider001";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_drider003";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_drider004";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_drider002";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_cavegoblin001";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_cavegoblin005";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_cavegoblin003";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_cavegoblin002";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_cavegoblin004";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_cavegoblin006";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_gorochem001";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_gorochem002";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_lizard031";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_lizard033";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_lizard032";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_lizard035";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_lizard034";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_otyugh002";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_okyun";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_ooze005";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_orcunder005";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_orcunder006";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_orcunder003";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_orcunder001";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_orcunder002";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_orcunder004";iFaction = DEFAULT;}
else if((iRandom1>=32)&&(iRandom1<=32))  {sBP = "mn_otyugh001";iFaction = DEFAULT;}
else if((iRandom1>=33)&&(iRandom1<=33))  {sBP = "mn_phyrexian002";iFaction = DEFAULT;}
else if((iRandom1>=34)&&(iRandom1<=34))  {sBP = "mn_rust001";iFaction = DEFAULT;}
else if((iRandom1>=35)&&(iRandom1<=35))  {sBP = "mn_spider015";iFaction = DEFAULT;}
else if((iRandom1>=36)&&(iRandom1<=36))  {sBP = "mn_spider011";iFaction = DEFAULT;}
else if((iRandom1>=37)&&(iRandom1<=37))  {sBP = "mn_stirge005";iFaction = DEFAULT;}
else if((iRandom1>=38)&&(iRandom1<=38))  {sBP = "mn_stogoth2";iFaction = DEFAULT;}
else if((iRandom1>=39)&&(iRandom1<=39))  {sBP = "mn_stogoth";iFaction = DEFAULT;}
else if((iRandom1>=40)&&(iRandom1<=40))  {sBP = "mn_ultroloth";iFaction = DEFAULT;}
else if((iRandom1>=41)&&(iRandom1<=41))  {sBP = "mn_umberhulk001";iFaction = DEFAULT;}
else if((iRandom1>=42)&&(iRandom1<=42))  {sBP = "mn_xorn";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Mo3"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(41)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_basilik002";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_duergar003";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_duergar001";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_duergar002";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_cavegoblin001";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_cavegoblin005";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_cavegoblin003";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_cavegoblin002";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_cavegoblin004";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_cavegoblin006";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_gorochem001";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_gorochem002";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_lizard031";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_lizard033";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_lizard032";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_lizard035";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_lizard034";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_otyugh002";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_okyun";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_ooze005";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_orcunder005";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_orcunder006";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_orcunder003";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_orcunder001";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_orcunder002";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_orcunder004";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_otyugh001";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_phyrexian002";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_rust001";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_spider015";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_spider011";iFaction = DEFAULT;}
else if((iRandom1>=32)&&(iRandom1<=32))  {sBP = "mn_stirge005";iFaction = DEFAULT;}
else if((iRandom1>=33)&&(iRandom1<=33))  {sBP = "mn_stogoth2";iFaction = DEFAULT;}
else if((iRandom1>=34)&&(iRandom1<=34))  {sBP = "mn_stogoth";iFaction = DEFAULT;}
else if((iRandom1>=35)&&(iRandom1<=35))  {sBP = "mn_ultroloth";iFaction = DEFAULT;}
else if((iRandom1>=36)&&(iRandom1<=36))  {sBP = "mn_umberhulk001";iFaction = DEFAULT;}
else if((iRandom1>=37)&&(iRandom1<=37))  {sBP = "mn_vampire008";iFaction = DEFAULT;}
else if((iRandom1>=38)&&(iRandom1<=38))  {sBP = "mn_vampire006";iFaction = DEFAULT;}
else if((iRandom1>=39)&&(iRandom1<=39))  {sBP = "mn_vampire007";iFaction = DEFAULT;}
else if((iRandom1>=40)&&(iRandom1<=40))  {sBP = "mn_vampire003";iFaction = DEFAULT;}
else if((iRandom1>=41)&&(iRandom1<=41))  {sBP = "mn_xorn";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if((sCreatures=="Otun")||(sCreatures=="Sterign")){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(19)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_beetle005";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_beetle003";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_beetle004";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_gnoll026";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_gnoll027";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_gnoll028";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_gnoll029";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_kobold007";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_kobold008";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_kobold010";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_kobold009";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_larva";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_plant001";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_shrieker01";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_snake002";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_snake001";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_spider009";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_stirge005";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_stogoth";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if((sCreatures=="Ozgurbur")||(sCreatures=="Kah")){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(15)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_fog";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_beast001";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_bird002";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_djinni001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_dragon006";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_death007";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_death006";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_death005";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_eagle001";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_goldeagle001";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_elemair001";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_livcloud001";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_owl001";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_wyvern002";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_wyvern001";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Ronde"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(34)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_basilik002";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_duergar003";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_duergar001";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_duergar002";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_golem002";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_golem003";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_golem001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_golem004";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_golem011";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_gorochem001";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_gorochem004";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_gorochem003";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_gorochem002";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_maug001";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_maug003";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_maug004";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_maug002";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_otyugh002";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_okyun";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_ooze005";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_otyugh001";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_phyrexian002";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_rust001";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_guardian_003";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_guardian_001";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_guardian_002";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_spider015";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_spider011";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_stirge005";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_stogoth2";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_stogoth";iFaction = DEFAULT;}
else if((iRandom1>=32)&&(iRandom1<=32))  {sBP = "mn_ultroloth";iFaction = DEFAULT;}
else if((iRandom1>=33)&&(iRandom1<=33))  {sBP = "mn_umberhulk001";iFaction = DEFAULT;}
else if((iRandom1>=34)&&(iRandom1<=34))  {sBP = "mn_xorn";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Sand"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(22)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_drone005";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_drone002";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_drone001";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_drone003";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_drone004";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_narok006";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_narok001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_narok005";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_narok004";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_narok002";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_narok003";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_plant001";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_shrieker01";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_snake003";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_snake002";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_snake001";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_snake002";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_snake001";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_spider008";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_spider009";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_stirge005";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_stogoth";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Tend"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_dino009";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_dino010";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_dino008";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_dino005";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_dino006";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_dino007";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_dino002";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_dino004";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_dino003";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_dino001";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Terlation"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(36)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_ant006";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_ant003";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_ant004";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_ant005";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_ant002";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_ant001";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_azer001";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_beetle011";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_beetle012";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_beetle014";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_beetle013";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_behirmist";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_chimera001";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_crab005";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_crab002";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_gargoyle001";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_giant003";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_golem009";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_golem010";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_gorochem004";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_hyena002";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_hyena001";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_feline009";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_feline011";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_firemephit";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_magmamephit";iFaction = DEFAULT;}
else if((iRandom1>=27)&&(iRandom1<=27))  {sBP = "mn_salamander002";iFaction = DEFAULT;}
else if((iRandom1>=28)&&(iRandom1<=28))  {sBP = "mn_salamander003";iFaction = DEFAULT;}
else if((iRandom1>=29)&&(iRandom1<=29))  {sBP = "mn_salamander001";iFaction = DEFAULT;}
else if((iRandom1>=30)&&(iRandom1<=30))  {sBP = "mn_scorpion012";iFaction = DEFAULT;}
else if((iRandom1>=31)&&(iRandom1<=31))  {sBP = "mn_scorpion006";iFaction = DEFAULT;}
else if((iRandom1>=32)&&(iRandom1<=32))  {sBP = "mn_scorpion009";iFaction = DEFAULT;}
else if((iRandom1>=33)&&(iRandom1<=33))  {sBP = "mn_scorpion005";iFaction = DEFAULT;}
else if((iRandom1>=34)&&(iRandom1<=34))  {sBP = "mn_scorpion004";iFaction = DEFAULT;}
else if((iRandom1>=35)&&(iRandom1<=35))  {sBP = "mn_scorpion001";iFaction = DEFAULT;}
else if((iRandom1>=36)&&(iRandom1<=36))  {sBP = "mn_troll002";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Washisch"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(15)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_bear005";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_elemair001";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_giant005";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_giant002";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_mammouth001";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_mammouth002";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_mammouth003";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_mammouth004";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_mammouth005";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_goat002";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_tiklit004";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_tiklit002";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_tiklit003";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_tiklit001";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_small_ani011";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
else if(sCreatures=="Wyderl"){while(iPlanetCreNbr>0){iPlanetCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(26)+1;
     if((iRandom1>=1)&&(iRandom1<=1))  {sBP = "mn_balrog001";iFaction = DEFAULT;}
else if((iRandom1>=2)&&(iRandom1<=2))  {sBP = "mn_balrog002";iFaction = DEFAULT;}
else if((iRandom1>=3)&&(iRandom1<=3))  {sBP = "mn_cornugon_001";iFaction = DEFAULT;}
else if((iRandom1>=4)&&(iRandom1<=4))  {sBP = "mn_glabrezu001";iFaction = DEFAULT;}
else if((iRandom1>=5)&&(iRandom1<=5))  {sBP = "mn_marilith001";iFaction = DEFAULT;}
else if((iRandom1>=6)&&(iRandom1<=6))  {sBP = "mn_pitfiend001";iFaction = DEFAULT;}
else if((iRandom1>=7)&&(iRandom1<=7))  {sBP = "mn_dragon007";iFaction = DEFAULT;}
else if((iRandom1>=8)&&(iRandom1<=8))  {sBP = "mn_dragon002";iFaction = DEFAULT;}
else if((iRandom1>=9)&&(iRandom1<=9))  {sBP = "mn_dragon009";iFaction = DEFAULT;}
else if((iRandom1>=10)&&(iRandom1<=10))  {sBP = "mn_dragon004";iFaction = DEFAULT;}
else if((iRandom1>=11)&&(iRandom1<=11))  {sBP = "mn_dragon008";iFaction = DEFAULT;}
else if((iRandom1>=12)&&(iRandom1<=12))  {sBP = "mn_dragon003";iFaction = DEFAULT;}
else if((iRandom1>=13)&&(iRandom1<=13))  {sBP = "mn_dragon010";iFaction = DEFAULT;}
else if((iRandom1>=14)&&(iRandom1<=14))  {sBP = "mn_dragon015";iFaction = DEFAULT;}
else if((iRandom1>=15)&&(iRandom1<=15))  {sBP = "mn_dragon006";iFaction = DEFAULT;}
else if((iRandom1>=16)&&(iRandom1<=16))  {sBP = "mn_dragon001";iFaction = DEFAULT;}
else if((iRandom1>=17)&&(iRandom1<=17))  {sBP = "mn_dragon011";iFaction = DEFAULT;}
else if((iRandom1>=18)&&(iRandom1<=18))  {sBP = "mn_dragon012";iFaction = DEFAULT;}
else if((iRandom1>=19)&&(iRandom1<=19))  {sBP = "mn_golem002";iFaction = DEFAULT;}
else if((iRandom1>=20)&&(iRandom1<=20))  {sBP = "mn_golem001";iFaction = DEFAULT;}
else if((iRandom1>=21)&&(iRandom1<=21))  {sBP = "mn_golem013";iFaction = DEFAULT;}
else if((iRandom1>=22)&&(iRandom1<=22))  {sBP = "mn_gorgon001";iFaction = DEFAULT;}
else if((iRandom1>=23)&&(iRandom1<=23))  {sBP = "mn_hydra001";iFaction = DEFAULT;}
else if((iRandom1>=24)&&(iRandom1<=24))  {sBP = "mn_legendary003";iFaction = DEFAULT;}
else if((iRandom1>=25)&&(iRandom1<=25))  {sBP = "mn_spider007";iFaction = DEFAULT;}
else if((iRandom1>=26)&&(iRandom1<=26))  {sBP = "mn_troll005";iFaction = DEFAULT;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(OBJECT_SELF),5)=="river"){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(60)+100),IntToFloat(Random(60)+100),0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);if(iFaction!=DEFAULT){ChangeToStandardFaction(oNew,iFaction);}if((Random(iLeader)==0)&&(GetChallengeRating(oNew)<12.0)){SetLocalInt(oNew,"Leader",1);}}}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////
}else{iNoCamp = 0;}
////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////
// Monster camps
////////////////////////////////////////////////////////////////////////////////
if((iNoCamp==0)&&(!GetIsAreaInterior(OBJECT_SELF))&&(GetStringLeft(GetTag(OBJECT_SELF),6)!="clouds")&&(GetStringLeft(GetTag(OBJECT_SELF),3)!="gaz")&&(GetStringLeft(GetTag(OBJECT_SELF),5)!="ocean")&&(GetStringLeft(GetTag(OBJECT_SELF),5)!="space")&&(GetStringLeft(GetTag(OBJECT_SELF),7)!="airship")){if(iCampSize==1){iRandom1 = 1;}else if(iCampSize==2){iRandom1 = 6;}else if(iCampSize==3){iRandom1 = 9;}else{iRandom1 = Random(45)+1;}
////////////////////////////////////////////////////////////////////////////////
if(iRandom1<6) // Little camp
 {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_campfire002",Location(OBJECT_SELF,Vector(fX,fY,fZ),0.0));SetLocalInt(oNew,"Camp",1);CreateItemOnObject("cr_meat",oNew);CreateItemOnObject("cr_plantcommon",oNew);

SetLocalInt(OBJECT_SELF,"DungeonRespawn",2);ExecuteScript("dungeons",OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////
else if(iRandom1<9) // Big camp
 {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-3.0,fZ),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);SetLocalObject(OBJECT_SELF,"CampEntry",oNew);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent03",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_lootbag2",Location(OBJECT_SELF,Vector(fX+15.78,fY-12.05,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_lootbag2",Location(OBJECT_SELF,Vector(fX+4.32,fY-2.81,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_lootbag2",Location(OBJECT_SELF,Vector(fX-8.10,fY+5.77,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_barrel",Location(OBJECT_SELF,Vector(fX-14.77,fY-3.82,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_barrel",Location(OBJECT_SELF,Vector(fX-13.81,fY-4.58,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_barrel",Location(OBJECT_SELF,Vector(fX-15.10,fY-5.06,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_crate1",Location(OBJECT_SELF,Vector(fX+6.12,fY-22.51,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_crate2",Location(OBJECT_SELF,Vector(fX+7.79,fY-22.09,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_crate3",Location(OBJECT_SELF,Vector(fX+5.46,fY-24.49,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
//
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_fullwagon",Location(OBJECT_SELF,Vector(fX+5.81,fY-0.42,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_fullwagon",Location(OBJECT_SELF,Vector(fX+3.65,fY-23.81,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfrwspit",Location(OBJECT_SELF,Vector(fX-8.81,fY-12.74,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_campfire002",Location(OBJECT_SELF,Vector(fX-0.50,fY-10.21,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfr",Location(OBJECT_SELF,Vector(fX+14.67,fY-18.86,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfr",Location(OBJECT_SELF,Vector(fX+13.34,fY+2.71,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent01",Location(OBJECT_SELF,Vector(fX+11.66,fY-4.12,fZ),293.9+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent01",Location(OBJECT_SELF,Vector(fX-11.45,fY-2.98,fZ),42.2+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent01",Location(OBJECT_SELF,Vector(fX-9.78,fY-24.30,fZ),137.8+90.0));SetLocalInt(oNew,"Camp",1);
//
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent01",Location(OBJECT_SELF,Vector(fX-3.11,fY-27.85,fZ),165.9+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent01",Location(OBJECT_SELF,Vector(fX-0.44,fY+13.44,fZ),4.2+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent01",Location(OBJECT_SELF,Vector(fX+9.40,fY+12.35,fZ),331.9+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent009",Location(OBJECT_SELF,Vector(fX+11.98,fY-12.08,fZ),316.4+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent009",Location(OBJECT_SELF,Vector(fX+4.31,fY-19.22,fZ),194.1+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent009",Location(OBJECT_SELF,Vector(fX+18.18,fY-19.59,fZ),233.4+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent009",Location(OBJECT_SELF,Vector(fX-10.22,fY+6.79,fZ),39.4+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent009",Location(OBJECT_SELF,Vector(fX-18.28,fY-16.78,fZ),98.4+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent010",Location(OBJECT_SELF,Vector(fX-10.9,fY-10.10,fZ),167.3+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent010",Location(OBJECT_SELF,Vector(fX-7.05,fY-17.21,fZ),240.5+90.0));SetLocalInt(oNew,"Camp",1);
//
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent010",Location(OBJECT_SELF,Vector(fX+21.44,fY-2.73,fZ),33.7+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent010",Location(OBJECT_SELF,Vector(fX+16.22,fY+4.06,fZ),67.5+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_emptywagon",Location(OBJECT_SELF,Vector(fX+5.79,fY+3.61,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_emptywagon",Location(OBJECT_SELF,Vector(fX+8.37,fY+3.27,fZ),0.0+90.0));SetLocalInt(oNew,"Camp",1);

SetLocalInt(OBJECT_SELF,"DungeonRespawn",3);ExecuteScript("dungeons",OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////
else if((iRandom1<10)&&(iLevel>=3))// Fort
 {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",Location(OBJECT_SELF,Vector(fX+0.0,fY-3.0,fZ),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);SetLocalObject(OBJECT_SELF,"CampEntry",oNew);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_campfire002",Location(OBJECT_SELF,Vector(fX+0.0,fY-10.0,fZ),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent03",Location(OBJECT_SELF,Vector(fX+0.0,fY+0.0,fZ),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent03",Location(OBJECT_SELF,Vector(fX+12.0,fY+12.0,fZ),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent03",Location(OBJECT_SELF,Vector(fX+12.0,fY-12.0,fZ),0.0-90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent03",Location(OBJECT_SELF,Vector(fX-12.0,fY+12.0,fZ),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_tent03",Location(OBJECT_SELF,Vector(fX-12.0,fY-12.0,fZ),0.0-90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_lootbag2",Location(OBJECT_SELF,Vector(fX+4.32,fY-2.81,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_lootbag2",Location(OBJECT_SELF,Vector(fX-8.10,fY+5.77,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_barrel",Location(OBJECT_SELF,Vector(fX-14.77,fY-3.82,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_barrel",Location(OBJECT_SELF,Vector(fX-13.81,fY-4.58,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"x2_easy_barrel",Location(OBJECT_SELF,Vector(fX-15.10,fY-5.06,fZ),0.0+90.0));SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
// North
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+19.5,fY+22.5,fZ-0.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+13.0,fY+22.5,fZ-0.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+6.5,fY+22.5,fZ-0.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-6.5,fY+22.5,fZ-0.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-13.0,fY+22.5,fZ-0.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-19.5,fY+22.5,fZ-0.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+19.5,fY+22.5,fZ+2.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+13.0,fY+22.5,fZ+2.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+6.5,fY+22.5,fZ+2.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+0.0,fY+22.5,fZ+2.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-6.5,fY+22.5,fZ+2.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-13.0,fY+22.5,fZ+2.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-19.5,fY+22.5,fZ+2.5),0.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
// South
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+19.5,fY-22.5,fZ-0.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+13.0,fY-22.5,fZ-0.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+6.5,fY-22.5,fZ-0.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-6.5,fY-22.5,fZ-0.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-13.0,fY-22.5,fZ-0.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-19.5,fY-22.5,fZ-0.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+19.5,fY-22.5,fZ+2.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+13.0,fY-22.5,fZ+2.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+6.5,fY-22.5,fZ+2.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+0.0,fY-22.5,fZ+2.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-6.5,fY-22.5,fZ+2.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-13.0,fY-22.5,fZ+2.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-19.5,fY-22.5,fZ+2.5),180.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
//East
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY+19.5,fZ-0.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY+13.0,fZ-0.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY+6.5,fZ-0.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY-6.5,fZ-0.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY-13.0,fZ-0.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY-19.5,fZ-0.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY+19.5,fZ+2.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY+13.0,fZ+2.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY+6.5,fZ+2.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY+0.0,fZ+2.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY-6.5,fZ+2.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY-13.0,fZ+2.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX+22.5,fY-19.5,fZ+2.5),270.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
// West
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY+19.5,fZ-0.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY+13.0,fZ-0.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY+6.5,fZ-0.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY-6.5,fZ-0.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY-13.0,fZ-0.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY-19.5,fZ-0.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY+19.5,fZ+2.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY+13.0,fZ+2.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY+6.5,fZ+2.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY+0.0,fZ+2.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY-6.5,fZ+2.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY-13.0,fZ+2.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_fort",Location(OBJECT_SELF,Vector(fX-22.5,fY-19.5,fZ+2.5),90.0+90.0));SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
// North
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+18.0,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+13.5,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+9.0,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+4.5,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-4.5,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-9.0,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-13.5,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-18.0,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY+22.5,fZ),180.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
// South
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+18.0,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+13.5,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+9.0,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+4.5,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-4.5,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-9.0,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-13.5,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-18.0,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY-22.5,fZ),0.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
// East
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY+22.5,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY+18.0,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY+13.5,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY+9.0,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY+4.5,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY-4.5,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY-9.0,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY-13.5,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY-18.0,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX+22.5,fY-22.5,fZ),90.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
// West
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY+22.5,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY+18.0,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY+13.5,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY+9.0,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY+4.5,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY-4.5,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY-9.0,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY-13.5,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY-18.0,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_gateblock001",Location(OBJECT_SELF,Vector(fX-22.5,fY-22.5,fZ),270.0+90.0),FALSE,"gateblock");SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Camp",1);
// Cannons
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cannon001",Location(OBJECT_SELF,Vector(fX+22.0,fY+22.0,fZ+5.5),315.0+90.0));SetPlotFlag(oNew,TRUE);SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cannon001",Location(OBJECT_SELF,Vector(fX+22.0,fY-22.0,fZ+5.5),225.0+90.0));SetPlotFlag(oNew,TRUE);SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cannon001",Location(OBJECT_SELF,Vector(fX-22.0,fY+22.0,fZ+5.5),45.0+90.0));SetPlotFlag(oNew,TRUE);SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"zep_cannon001",Location(OBJECT_SELF,Vector(fX-22.0,fY-22.0,fZ+5.5),135.0+90.0));SetPlotFlag(oNew,TRUE);SetUseableFlag(oNew,FALSE);SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_cannon",Location(OBJECT_SELF,Vector(fX+23.7,fY+23.7,fZ+5.5),135.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_cannon",Location(OBJECT_SELF,Vector(fX+23.7,fY-23.7,fZ+5.5),45.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_cannon",Location(OBJECT_SELF,Vector(fX-23.7,fY+23.7,fZ+5.5),315.0+90.0));SetLocalInt(oNew,"Camp",1);
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_cannon",Location(OBJECT_SELF,Vector(fX-23.7,fY-23.7,fZ+5.5),225.0+90.0));SetLocalInt(oNew,"Camp",1);

SetLocalInt(OBJECT_SELF,"DungeonRespawn",4);ExecuteScript("dungeons",OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}DeleteLocalInt(OBJECT_SELF,"NoCamp");DeleteLocalInt(OBJECT_SELF,"CampSize");
////////////////////////////////////////////////////////////////////////////////
}
