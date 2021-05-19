#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
string sTot = GetPersistentString(oModule,sPlanet);
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;
object oCreatures = GetFirstObjectInArea(OBJECT_SELF);
int iRandom1;string sBP;int iFaction;object oNew;int i;
////////////////////////////////////////////////////////////////////////////////
while(GetIsObjectValid(oCreatures)){if(GetLocalInt(oCreatures,"Sewer")==1){i++;}oCreatures = GetNextObjectInArea(OBJECT_SELF);}
int iSewerCreatures = 25-i;
////////////////////////////////////////////////////////////////////////////////
if(iLevel==1){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_bat001";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_rat001";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_spider002";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_spider001";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_ooze003";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_spider009";iFaction = STANDARD_FACTION_MERCHANT;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Flee",1);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==2){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(13)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_spider009";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=4)&&(iRandom1<=5)){sBP = "mn_beetle009";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=6)&&(iRandom1<=7)){sBP = "mn_beetle007";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=8)&&(iRandom1<=9)){sBP = "mn_beetle010";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=10)&&(iRandom1<=11)){sBP = "mn_beetle008";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_crab001";iFaction = STANDARD_FACTION_MERCHANT;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "mn_crab004";iFaction = STANDARD_FACTION_MERCHANT;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Flee",1);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==3){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(20)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_crab001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_crab004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_crab003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_ooze008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_ooze006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "mn_spider003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "mn_beetle003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "mn_beetle004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "mn_ooze004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "mn_snake002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "mn_spider006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "mn_spider005";iFaction = STANDARD_FACTION_HOSTILE;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==4){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(17)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_ooze004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_snake002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_spider006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_spider005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "mn_ooze007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "mn_ooze005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "mn_rust001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "mn_spider010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "mn_spider004";iFaction = STANDARD_FACTION_HOSTILE;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==5){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(13)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_rust001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_spider010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_spider004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_beetle006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_snake003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_spider008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_spider012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "mn_ant003";iFaction = STANDARD_FACTION_HOSTILE;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==6){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_spider008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_spider012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_ant003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_spider011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_spider014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_ooze001";iFaction = STANDARD_FACTION_HOSTILE;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==7){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(15)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_spider015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_ooze001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=9)){sBP = "mn_beetle012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=12)){sBP = "mn_spider013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "mn_crab002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "mn_crab005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "mn_beetle014";iFaction = STANDARD_FACTION_HOSTILE;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==8){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_crab002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_crab005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_beetle014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_spider007";iFaction = STANDARD_FACTION_HOSTILE;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////
else if(iLevel==9){while(iSewerCreatures>0){iSewerCreatures--;
//
iRandom1 = Random(6)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_spider007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_scorpion012";iFaction = STANDARD_FACTION_HOSTILE;}
//
oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0),FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);SetLocalInt(oNew,"Sewer",1);}}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}
