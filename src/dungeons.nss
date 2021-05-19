#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
// Dungeons
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
int iPlacedDungeon;int iInt;
//
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));iInt++;}
string sLeftTag = GetStringLeft(GetTag(OBJECT_SELF),2);
//
string sTot = GetPersistentString(oModule,sPlanet);
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));if(iLevel<1){iLevel = 1;}
//
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterestsLeft = GetStringLeft(sInterests,FindSubString(sInterests,"_C_")+3);
string sInterestsRight = GetStringRight(sInterests,GetStringLength(sInterests)-FindSubString(sInterests,"&1&"));
string sFamily = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"_D_")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"_D_")))-FindSubString(sInterests,"_C_")-3);
//
string sDungeonCreNbr = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"_E_")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"_E_")))-FindSubString(sInterests,"_D_")-3);
//
int iDungeonLevel = GetLocalInt(OBJECT_SELF,"DungeonLevel");if(iDungeonLevel>0){if(iDungeonLevel==10){iLevel = 0;}else{iLevel = iDungeonLevel;}iPlacedDungeon = 1;sFamily = "";}
int iDungeonFamily = GetLocalInt(OBJECT_SELF,"DungeonFamily");
object oEntry = GetLocalObject(OBJECT_SELF,"CampEntry");
//
int iPoint = GetLocalInt(OBJECT_SELF,"DungeonRespawn");if((iPoint==1)&&(GetLocalInt(oModule,sPlanet+"_"+sArea+"&Ready")!=1)){iPoint = 0;}
object oPoint = GetLocalObject(OBJECT_SELF,"DungeonRespawnPoint");
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;
float fZ = 0.0;if(GetStringLeft(GetTag(OBJECT_SELF),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(OBJECT_SELF),6)=="ground")||(GetStringLeft(GetTag(OBJECT_SELF),11)=="ruralcastle")){fZ = 5.0;}
string sBP;int iFaction;object oNew;object oPla;int iDungeonFamNbr;int iCampFamNbr;int iDungeonCreNbr;location lLoc;object oDoor;int iRandom1;
// Creatures number
int iCreNbr = Random(61)+60;
if(sDungeonCreNbr!=""){iCreNbr = StringToInt(sDungeonCreNbr);}
iDungeonCreNbr = iCreNbr;
// Dungeon exterior
if(iInt==0){iDungeonCreNbr = iDungeonCreNbr/3;}
// Spawn creatures in front of dungeon door
if(iPoint==1){if(Random(4)==0){iDungeonCreNbr = 2;}else{iDungeonCreNbr = 1;}}
// Camps
if(iPoint==2){iDungeonCreNbr = Random(6)+5;sFamily = "";}else if(iPoint==3){iDungeonCreNbr = Random(21)+20;sFamily = "";}else if(iPoint==4){iDungeonCreNbr = Random(31)+50;sFamily = "";}else if(iPoint==5){iDungeonCreNbr = Random(6)+5;sFamily = "";}
// Home interiors
if(GetStringLeft(GetTag(OBJECT_SELF),2)=="h_"){iDungeonCreNbr = 0;iPoint = -1;}
// Domains dungeons
if(GetLocalInt(OBJECT_SELF,"DDLevel")==1){iLevel = 1;}else if(GetLocalInt(OBJECT_SELF,"DDLevel")==2){iLevel = Random(2)+2;}else if(GetLocalInt(OBJECT_SELF,"DDLevel")==3){iLevel = Random(2)+4;}else if(GetLocalInt(OBJECT_SELF,"DDLevel")==4){iLevel = Random(2)+6;}else if(GetLocalInt(OBJECT_SELF,"DDLevel")==5){iLevel = Random(1)+8;}
// Space towers
     if(GetLocalString(OBJECT_SELF,"Master")=="1"){iLevel = 9;iDungeonCreNbr = Random(31)+30;sFamily = "Space Dungeon";}
else if(GetLocalString(OBJECT_SELF,"Master")=="2"){iLevel = 9;iDungeonCreNbr = Random(10)+1;sFamily = "Space Dungeon";}
// Leader
int iLeader = 4; //*// Creatures have 1 chance on iLeader to be a leader
// Enigms
int iEnigm = 20; //*// 1 chance on iEnigm to have an enigm for each creature placed
int iEnigmPla = 1; //*// number of available enigm placeables
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Special
// Change monster family ?
if((iInt==0)&&(iPoint==0)&&(iPlacedDungeon==0)&&(sFamily!="")&&(Random(10)==0)){sFamily = "";}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
if(iLevel==1){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(6)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(8)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Abandonned Dungeon Weak")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Abandonned Dungeon Weak";
iRandom1 = Random(18)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_bat001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_rat001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_spider002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_stirge001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_ooze003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_snake001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_spider009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "mn_beetle009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "mn_beetle007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "mn_beetle010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "mn_beetle008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "mn_ooze008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "mn_ooze006";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Goblins Brown")||(iDungeonFamNbr==2)||(iCampFamNbr==1)){iDungeonFamNbr = 2;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Goblins Brown";
iRandom1 = Random(15)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_goblin010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_goblin009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=8)){sBP = "mn_goblin007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_goblin011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=14)){sBP = "mn_goblin008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "mn_goblin012";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Goblins Yellow")||(iDungeonFamNbr==3)||(iCampFamNbr==2)){iDungeonFamNbr = 3;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Goblins Yellow";
iRandom1 = Random(14)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_goblin004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_goblin006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_goblin003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=8)){sBP = "mn_goblin001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_goblin005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=14)){sBP = "mn_goblin002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kobolds Blue")||(iDungeonFamNbr==4)||(iCampFamNbr==3)){iDungeonFamNbr = 4;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kobolds Blue";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_kobold007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_kobold008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_kobold010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_kobold009";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kobolds Brown")||(iDungeonFamNbr==5)||(iCampFamNbr==4)){iDungeonFamNbr = 5;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kobolds Brown";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_kobold002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_kobold001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_kobold004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_kobold003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Lizardfolks Brown")||(iDungeonFamNbr==6)||(iCampFamNbr==5)){iDungeonFamNbr = 6;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Lizardfolks Brown";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_lizard005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_lizard008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_lizard007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_lizard010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_lizard009";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Lizardfolks Green")||(iDungeonFamNbr==7)||(iCampFamNbr==6)){iDungeonFamNbr = 7;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Lizardfolks Green";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_lizard001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_lizard003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_lizard002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_lizard005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_lizard004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Skeletons Weak")||(iDungeonFamNbr==8)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Skeletons Weak";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_squel002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_squel003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_squel004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=10)){sBP = "mn_squel001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==2){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(11)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(18)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Abandonned Dungeon Strong")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Abandonned Dungeon Strong";
iRandom1 = Random(14)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_beetle003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_beetle004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_ooze004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_snake002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_spider006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "mn_spider005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "mn_ooze007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "mn_ooze005";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Animated Weapons Weak")||(iDungeonFamNbr==2)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Animated Weapons Weak";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_animated001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_animated004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_animated002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_animated003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Bandits Weak")||(iDungeonFamNbr==3)||(iCampFamNbr==1)){iDungeonFamNbr = 3;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Bandits Weak";
iRandom1 = Random(12)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_bandit007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=4)){sBP = "mn_bandit002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_bandit001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_bandit006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_bandit004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_bandit003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_bandit012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_bandit005";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Beetles Weak")||(iDungeonFamNbr==4)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Beetles Weak";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_beetle009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_beetle007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_beetle0010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_beetle008";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Bugbears Brown")||(iDungeonFamNbr==5)||(iCampFamNbr==2)){iDungeonFamNbr = 5;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Bugbears Brown";
iRandom1 = Random(19)+1;
     if((iRandom1>=1)&&(iRandom1<=6)){sBP = "mn_bugbear007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_bugbear009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=14)){sBP = "mn_bugbear006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "mn_bugbear008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "mn_bugbear010";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Bugbears Green")||(iDungeonFamNbr==6)||(iCampFamNbr==3)){iDungeonFamNbr = 6;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Bugbears Green";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_bugbear001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_bugbear004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_bugbear002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_bugbear003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_bugbear005";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gipsys")||(iDungeonFamNbr==7)||(iCampFamNbr==4)){iDungeonFamNbr = 7;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gipsys";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_bandit013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_bandit014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=5)){sBP = "mn_bandit015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=8)){sBP = "mn_bandit016";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gnolls Normal")||(iDungeonFamNbr==8)||(iCampFamNbr==5)){iDungeonFamNbr = 8;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gnolls Normal";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_gnoll026";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_gnoll027";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_gnoll028";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_gnoll029";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gnolls Yellow")||(iDungeonFamNbr==9)||(iCampFamNbr==6)){iDungeonFamNbr = 9;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gnolls Yellow";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_gnoll014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_gnoll015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_gnoll016";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_gnoll017";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kobolds Vampiric")||(iDungeonFamNbr==10)||(iCampFamNbr==7)){iDungeonFamNbr = 10;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kobolds Vampiric";
iRandom1 = Random(7)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_kobold017";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=3)){sBP = "mn_kobold016";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=7)){sBP = "mn_kobold015";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Leprechauns")||(iDungeonFamNbr==11)||(iCampFamNbr==8)){iDungeonFamNbr = 11;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Leprechauns";
iRandom1 = Random(2)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_leprechfemale";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_leprechmale";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Naroks")||(iDungeonFamNbr==12)||(iCampFamNbr==9)){iDungeonFamNbr = 12;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Naroks";
iRandom1 = Random(13)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_narok006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_narok001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_narok005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_narok004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=11)){sBP = "mn_narok002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=13)){sBP = "mn_narok003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Nomads")||(iDungeonFamNbr==13)||(iCampFamNbr==10)){iDungeonFamNbr = 13;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Nomads";
iRandom1 = Random(5)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_humanomad008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=3)){sBP = "mn_humanomad007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=5)){sBP = "mn_humanomad006";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Orcs Green")||(iDungeonFamNbr==14)||(iCampFamNbr==11)){iDungeonFamNbr = 14;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Orcs Green";
iRandom1 = Random(17)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_orc001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_orc003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_orc004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_orc011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_orc013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=15)){sBP = "mn_orc002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=17)){sBP = "mn_orc005";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Skeletons Strong")||(iDungeonFamNbr==15)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Skeletons Strong";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_squel005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_squel009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_squel010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_squel006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=9)){sBP = "mn_squel007";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Spiders Weak")||(iDungeonFamNbr==16)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Spiders Weak";
iRandom1 = Random(16)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_spider009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=8)){sBP = "mn_spider003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_spider006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_spider005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=16)){sBP = "mn_spider001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Troglodytes Weak")||(iDungeonFamNbr==17)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Troglodytes Weak";
iRandom1 = Random(6)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_trog001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_trog003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_trog004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_trog002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Undeads Weak")||(iDungeonFamNbr==18)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Undeads Weak";
iRandom1 = Random(6)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_squel002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_squel001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_squel003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_squel004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_zombie001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==3){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(22)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(34)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Energies")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Energies";
iRandom1 = Random(5)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_energy002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=5)){sBP = "mn_energy001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Animated objects")||(iDungeonFamNbr==2)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Animated objects";
iRandom1 = Random(5)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_animated012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_animated010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_animated009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_animated011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_animated013";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Ankhegs")||(iDungeonFamNbr==3)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Ankhegs";
iRandom1 = Random(12)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_ankheg003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=4)){sBP = "mn_ankheg002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=12)){sBP = "mn_ankheg001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Ants")||(iDungeonFamNbr==4)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Ants";
iRandom1 = Random(30)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_ant006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_ant003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_ant004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=20)){sBP = "mn_ant005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=21)&&(iRandom1<=24)){sBP = "mn_ant002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=25)&&(iRandom1<=30)){sBP = "mn_ant001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Bandits Desert")||(iDungeonFamNbr==5)||(iCampFamNbr==1)){iDungeonFamNbr = 5;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Bandits Desert";
iRandom1 = Random(6)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_bandit011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_bandit010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_bandit009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_bandit008";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Beetles Medium")||(iDungeonFamNbr==6)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Beetles Medium";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_beetle005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_beetle003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_beetle006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_beetle004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Demons Weak")||(iDungeonFamNbr==7)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Demons Weak";
iRandom1 = Random(19)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_dretch001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_fiendwar001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_devil001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=12)){sBP = "mn_hellhound001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=16)){sBP = "mn_fiend001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "mn_sucubus001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "mn_vrock001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Drainiders")||(iDungeonFamNbr==8)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Drainiders";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_death007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=4)){sBP = "mn_death006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=10)){sBP = "mn_death005";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Drones")||(iDungeonFamNbr==9)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Drones";
iRandom1 = Random(12)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_drone005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_drone002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=9)){sBP = "mn_drone001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=11)){sBP = "mn_drone003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_drone004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gnolls Army")||(iDungeonFamNbr==10)||(iCampFamNbr==2)){iDungeonFamNbr = 10;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gnolls Army";
iRandom1 = Random(11)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_gnoll001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_gnoll013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_gnoll002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=9)){sBP = "mn_gnoll004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=11)){sBP = "mn_gnoll003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gnolls Black")||(iDungeonFamNbr==11)||(iCampFamNbr==3)){iDungeonFamNbr = 11;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gnolls Black";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_gnoll018";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_gnoll019";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_gnoll020";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_gnoll021";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gnolls Ice")||(iDungeonFamNbr==12)||(iCampFamNbr==4)){iDungeonFamNbr = 12;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gnolls Ice";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_gnoll009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_gnoll010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_gnoll011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_gnoll012";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gnolls Red")||(iDungeonFamNbr==13)||(iCampFamNbr==5)){iDungeonFamNbr = 13;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gnolls Red";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_gnoll005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_gnoll006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_gnoll007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_gnoll008";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Goblins Cave")||(iDungeonFamNbr==14)||(iCampFamNbr==6)){iDungeonFamNbr = 14;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Goblins Cave";
iRandom1 = Random(14)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_cavegoblin001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_cavegoblin005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_cavegoblin003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=10)){sBP = "mn_cavegoblin002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_cavegoblin004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=14)){sBP = "mn_cavegoblin006";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Goblins Snow")||(iDungeonFamNbr==15)||(iCampFamNbr==7)){iDungeonFamNbr = 15;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Goblins Snow";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_snowgoblin001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_snowgoblin004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_snowgoblin003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=8)){sBP = "mn_snowgoblin002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Humans Tribe")||(iDungeonFamNbr==16)||(iCampFamNbr==8)){iDungeonFamNbr = 16;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Humans Tribe";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_mountribe007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_mountribe010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_mountribe001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_mountribe009";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kenkus Gold")||(iDungeonFamNbr==17)||(iCampFamNbr==9)){iDungeonFamNbr = 17;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kenkus Gold";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_kenku007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_kenku010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_kenku008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_kenku009";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kenkus Grey")||(iDungeonFamNbr==18)||(iCampFamNbr==10)){iDungeonFamNbr = 18;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kenkus Grey";
iRandom1 = Random(20)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_kenku011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_kenku014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_kenku012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_kenku013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=14)){sBP = "mn_kenku015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "mn_kenku018";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=19)){sBP = "mn_kenku016";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "mn_kenku017";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kobolds Ice")||(iDungeonFamNbr==19)||(iCampFamNbr==11)){iDungeonFamNbr = 19;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kobolds Ice";
iRandom1 = Random(11)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_kobold011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=8)){sBP = "mn_kobold012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_kobold014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=11)){sBP = "mn_kobold013";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kyoths Brown")||(iDungeonFamNbr==20)||(iCampFamNbr==12)){iDungeonFamNbr = 20;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kyoths Brown";
iRandom1 = Random(12)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_kyoth014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_kyoth016";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_kyoth018";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=10)){sBP = "mn_kyoth013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_kyoth017";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_kyoth015";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kyoths Fox")||(iDungeonFamNbr==21)||(iCampFamNbr==13)){iDungeonFamNbr = 21;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kyoths Fox";
iRandom1 = Random(14)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_kyoth008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_kyoth010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_kyoth012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=10)){sBP = "mn_kyoth007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_kyoth011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_kyoth019";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "mn_kyoth009";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Lizardfolks Great Blue")||(iDungeonFamNbr==22)||(iCampFamNbr==14)){iDungeonFamNbr = 22;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Lizardfolks Great Blue";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_lizard016";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_lizard018";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_lizard017";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_lizard020";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_lizard019";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Lizardfolks Great Brown")||(iDungeonFamNbr==23)||(iCampFamNbr==15)){iDungeonFamNbr = 23;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Lizardfolks Great Brown";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_lizard011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_lizard013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_lizard012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_lizard015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_lizard014";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Lizardfolks Great Underwater")||(iDungeonFamNbr==24)||(iCampFamNbr==16)){iDungeonFamNbr = 24;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Lizardfolks Great Underwater";
iRandom1 = Random(14)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_lizard026";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=6)){sBP = "mn_lizard028";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_lizard027";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=12)){sBP = "mn_lizard030";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "mn_lizard029";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Ogres Weak")||(iDungeonFamNbr==25)||(iCampFamNbr==17)){iDungeonFamNbr = 25;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Ogres Weak";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_ogre002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_ogre005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_ogre001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_ogre007";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Orcs Army")||(iDungeonFamNbr==26)||(iCampFamNbr==18)){iDungeonFamNbr = 26;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Orcs Army";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_orcarmy001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_orcarmy003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_orcarmy002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Orcs Blue")||(iDungeonFamNbr==27)||(iCampFamNbr==19)){iDungeonFamNbr = 27;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Orcs Blue";
iRandom1 = Random(19)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_orc006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_orc008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_orc009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_orc012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_orc014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=17)){sBP = "mn_orc007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=18)&&(iRandom1<=19)){sBP = "mn_orc010";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Orcs Mountain")||(iDungeonFamNbr==28)||(iCampFamNbr==20)){iDungeonFamNbr = 28;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Orcs Mountain";
iRandom1 = Random(16)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_orcmount002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_orcmount006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_orcmount004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=14)){sBP = "mn_orcmount001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "mn_orcmount003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "mn_orcmount005";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Pygmies")||(iDungeonFamNbr==29)||(iCampFamNbr==21)){iDungeonFamNbr = 29;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Pygmies";
iRandom1 = Random(12)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_pygme004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=3)){sBP = "mn_pygme002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_pygme003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=12)){sBP = "mn_pygme001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Spiders Medium")||(iDungeonFamNbr=30)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Spiders Medium";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_spider003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_spider004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_spider008";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Troglodytes Army")||(iDungeonFamNbr==31)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Troglodytes Army";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_trog006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_trog007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_trog005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=10)){sBP = "mn_trog008";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Trolls Weak")||(iDungeonFamNbr==32)||(iCampFamNbr==22)){iDungeonFamNbr = 32;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Trolls Weak";
iRandom1 = Random(5)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_troll001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_troll002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Zombies")||(iDungeonFamNbr==33)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Zombies";
iRandom1 = Random(17)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_zombie001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=7)){sBP = "mn_zombie004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_zombie007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=11)){sBP = "mn_zombie002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=13)){sBP = "mn_zombie005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "mn_zombie006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=17)){sBP = "mn_zombie003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Undeads Medium")||(iDungeonFamNbr==34)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Undeads Medium";
iRandom1 = Random(11)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_shadow";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_squel005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_squel006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_zombie002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_zombie003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_death008";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==4){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(13)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(22)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Amazons")||(iDungeonFamNbr==1)||(iCampFamNbr==1)){iDungeonFamNbr = 1;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Amazons";
iRandom1 = Random(14)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_humaamaz002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_humaamaz005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=9)){sBP = "mn_humaamaz006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=12)){sBP = "mn_humaamaz001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=13)){sBP = "mn_humaamaz003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "mn_humaamaz004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Animated Weapons Strong")||(iDungeonFamNbr==2)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Animated Weapons Strong";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_animated005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_animated008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_animated006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_animated007";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Bugbears Artic")||(iDungeonFamNbr==3)||(iCampFamNbr==2)){iDungeonFamNbr = 3;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Bugbears Artic";
iRandom1 = Random(11)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_bugbear011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=8)){sBP = "mn_bugbear012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_bugbear014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=11)){sBP = "mn_bugbear013";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Bugbears Tiger")||(iDungeonFamNbr==4)||(iCampFamNbr==3)){iDungeonFamNbr = 4;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Bugbears Tiger";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_bugbear015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=8)){sBP = "mn_bugbear016";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_bugbear017";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Duergars")||(iDungeonFamNbr==5)||(iCampFamNbr==4)){iDungeonFamNbr = 5;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Duergars";
iRandom1 = Random(5)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_duergar003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=4)){sBP = "mn_duergar001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_duergar002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Elementals")||(iDungeonFamNbr==6)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Elementals";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_elemair001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_elemearth001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_elemfire001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_elemwater001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Followers Black Hand")||(iDungeonFamNbr==7)||(iCampFamNbr==5)){iDungeonFamNbr = 7;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Followers Black Hand";
iRandom1 = Random(17)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_follower003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_follower004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=11)){sBP = "mn_follower001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=16)){sBP = "mn_follower002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "mn_follower005";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Giants")||(iDungeonFamNbr==8)||(iCampFamNbr==6)){iDungeonFamNbr = 8;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Giants";
iRandom1 = Random(5)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_giant002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=5)){sBP = "mn_giant004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gnolls Silvermoon")||(iDungeonFamNbr==9)||(iCampFamNbr==7)){iDungeonFamNbr = 9;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gnolls Silvermoon";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_gnoll022";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_gnoll023";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_gnoll024";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_gnoll025";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kenkus Raven")||(iDungeonFamNbr==10)||(iCampFamNbr==8)){iDungeonFamNbr = 10;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kenkus Raven";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_kenku019";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_kenku022";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_kenku020";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_kenku021";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kyoths Leopard")||(iDungeonFamNbr==11)||(iCampFamNbr==9)){iDungeonFamNbr = 11;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kyoths Leopard";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_kyoth002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_kyoth004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_kyoth006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_kyoth001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_kyoth005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_kyoth003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Lizardfolks Great Ice")||(iDungeonFamNbr==12)||(iCampFamNbr==10)){iDungeonFamNbr = 12;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Lizardfolks Great Ice";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_lizard021";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_lizard023";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=7)){sBP = "mn_lizard022";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_lizard025";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "mn_lizard024";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Ogres Strong")||(iDungeonFamNbr==13)||(iCampFamNbr==11)){iDungeonFamNbr = 13;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Ogres Strong";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_ogre004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_ogre003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_ogre008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_ogre006";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Oozes")||(iDungeonFamNbr==14)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Oozes";
iRandom1 = Random(12)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_ooze008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=5)){sBP = "mn_ooze007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=8)){sBP = "mn_ooze006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_ooze005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_ooze004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=12)){sBP = "mn_ooze001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Orcs Faerun")||(iDungeonFamNbr==15)||(iCampFamNbr==12)){iDungeonFamNbr = 15;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Orcs Faerun";
iRandom1 = Random(18)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_orcfaerun002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_orcfaerun005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=9)){sBP = "mn_orcfaerun004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=15)){sBP = "mn_orcfaerun001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=18)){sBP = "mn_orcfaerun003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Orcs Snow")||(iDungeonFamNbr==16)||(iCampFamNbr==13)){iDungeonFamNbr = 16;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Orcs Snow";
iRandom1 = Random(13)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_snoworc001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_snoworc003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_snoworc005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=11)){sBP = "mn_snoworc002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=13)){sBP = "mn_snoworc004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Scorpions Black")||(iDungeonFamNbr==17)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Scorpions Black";
iRandom1 = Random(26)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_scorpion012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=6)){sBP = "mn_scorpion006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=11)){sBP = "mn_scorpion009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=16)){sBP = "mn_scorpion005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=21)){sBP = "mn_scorpion004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=22)&&(iRandom1<=26)){sBP = "mn_scorpion001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Scorpions Green")||(iDungeonFamNbr==18)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Scorpions Green";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_scorpion007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_scorpion010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=10)){sBP = "mn_scorpion002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Scorpions Red")||(iDungeonFamNbr==19)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Scorpions Red";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_scorpion008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_scorpion011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=10)){sBP = "mn_scorpion003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Shadows")||(iDungeonFamNbr==20)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Shadows";
iRandom1 = Random(19)+1;
     if((iRandom1>=1)&&(iRandom1<=10)){sBP = "mn_shadow";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_dagma02";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=15)){sBP = "mn_shadfiend";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=19)){sBP = "mn_shadeservant";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Vampires Weak")||(iDungeonFamNbr==21)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Vampires Weak";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_vampire004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_vampire001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_vampire005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "mn_vampire002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Undeads Strong")||(iDungeonFamNbr==22)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Undeads Strong";
iRandom1 = Random(18)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_squel015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_squel007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=9)){sBP = "mn_zombie005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_death003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "mn_shadfiend";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "mn_squel009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "mn_zombie004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=17)){sBP = "mn_shadeservant";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "mn_squel010";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==5){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(5)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(12)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Driders")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Driders";
iRandom1 = Random(21)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_drider001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_drider003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=13)){sBP = "mn_drider004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "mn_drider005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=15)){sBP = "mn_drider006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=21)){sBP = "mn_drider002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Gorochems")||(iDungeonFamNbr==2)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Gorochems";
iRandom1 = Random(11)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_gorochem001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_gorochem004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_gorochem003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=11)){sBP = "mn_gorochem002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Kaldals")||(iDungeonFamNbr==3)||(iCampFamNbr==1)){iDungeonFamNbr = 3;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Kaldals";
iRandom1 = Random(6)+1;
     if((iRandom1>=1)&&(iRandom1<=5)){sBP = "mn_kaldisciple";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_kalwitch";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Lizardfolks Great Underdark")||(iDungeonFamNbr==4)||(iCampFamNbr==2)){iDungeonFamNbr = 4;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Lizardfolks Great Underdark";
iRandom1 = Random(3)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_lizard031";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_lizard033";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_lizard032";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_lizard035";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=11)){sBP = "mn_lizard034";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Mummies")||(iDungeonFamNbr==5)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Mummies";
iRandom1 = Random(16)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_mummy002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=5)){sBP = "mn_mummy003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=15)){sBP = "mn_mummy001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=16)){sBP = "mn_mummy004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Myconids")||(iDungeonFamNbr==6)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Myconids";
iRandom1 = Random(15)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_myconid003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=6)){sBP = "mn_myconid002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_myconid004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=15)){sBP = "mn_myconid001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Orcs Underdark")||(iDungeonFamNbr==7)||(iCampFamNbr==3)){iDungeonFamNbr = 7;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Orcs Underdark";
iRandom1 = Random(14)+1;
     if((iRandom1>=1)&&(iRandom1<=4)){sBP = "mn_orcunder005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=5)){sBP = "mn_orcunder006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=7)){sBP = "mn_orcunder003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=11)){sBP = "mn_orcunder001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=13)){sBP = "mn_orcunder002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=14)){sBP = "mn_orcunder004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Salamander")||(iDungeonFamNbr==8)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Salamander";
iRandom1 = Random(10)+1;
     if((iRandom1>=1)&&(iRandom1<=3)){sBP = "mn_salamander002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_salamander003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=10)){sBP = "mn_salamander001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Skeletons Very Strong")||(iDungeonFamNbr==9)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Skeletons Very Strong";
iRandom1 = Random(15)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_squeldev";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=3)){sBP = "mn_squel008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_squel011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_squel012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_squel016";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_squel014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=9)){sBP = "mn_mohrg";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=13)){sBP = "mn_squel015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=15)){sBP = "mn_squel013";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Tiklits")||(iDungeonFamNbr==10)||(iCampFamNbr==4)){iDungeonFamNbr = 10;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Tiklits";
iRandom1 = Random(20)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_tiklit004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=5)){sBP = "mn_tiklit002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_tiklit003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=20)){sBP = "mn_tiklit001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Trolls Strong")||(iDungeonFamNbr==11)||(iCampFamNbr==5)){iDungeonFamNbr = 11;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Trolls Strong";
iRandom1 = Random(3)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_troll003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=3)){sBP = "mn_troll004";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Undeads Very Strong")||(iDungeonFamNbr==12)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Undeads Very Strong";
iRandom1 = Random(24)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_zombie006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=4)){sBP = "mn_mummy001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_squel008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_mohrg";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=10)){sBP = "mn_squel013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=12)){sBP = "mn_vampire001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=13)&&(iRandom1<=14)){sBP = "mn_zombie007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=15)&&(iRandom1<=16)){sBP = "mn_bodak001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=17)&&(iRandom1<=18)){sBP = "mn_squel012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=19)&&(iRandom1<=20)){sBP = "mn_squel014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=21)&&(iRandom1<=21)){sBP = "mn_visage001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=22)&&(iRandom1<=22)){sBP = "mn_squel011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=23)&&(iRandom1<=23)){sBP = "mn_vampire005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=24)&&(iRandom1<=24)){sBP = "mn_vampire002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==6){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(1)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(2)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Shield Guardians")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Shield Guardians";
iRandom1 = Random(8)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_guardian_003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=6)){sBP = "mn_guardian_001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=8)){sBP = "mn_guardian_002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Vampires Strong")||(iDungeonFamNbr==2)||(iCampFamNbr==1)){iDungeonFamNbr = 2;while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Vampires Strong";
iRandom1 = Random(4)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_vampire008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_vampire006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_vampire007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_vampire003";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==7){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(0)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(5)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Crabs")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Crabs";
iRandom1 = Random(45)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_crab005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=9)){sBP = "mn_crab003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_crab002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=20)){sBP = "mn_crab001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=21)&&(iRandom1<=30)){sBP = "mn_crab004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=31)&&(iRandom1<=45)){sBP = "mn_crab009";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Demons Strong")||(iDungeonFamNbr==2)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Demons Strong";
iRandom1 = Random(7)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_balrog001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_balrog002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_cornugon_001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_glabrezu001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_marilith001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_osyluth001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_pitfiend001";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Golems")||(iDungeonFamNbr==3)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Golems";
iRandom1 = Random(30)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_golem002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=4)){sBP = "mn_golem009";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=6)){sBP = "mn_golem010";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=11)){sBP = "mn_golem008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=12)&&(iRandom1<=13)){sBP = "mn_golem007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=14)&&(iRandom1<=15)){sBP = "mn_golem006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=16)&&(iRandom1<=17)){sBP = "mn_golem003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=18)&&(iRandom1<=18)){sBP = "mn_golem001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=19)&&(iRandom1<=19)){sBP = "mn_golem013";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=20)&&(iRandom1<=20)){sBP = "mn_golem012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=21)&&(iRandom1<=23)){sBP = "mn_golem004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=24)&&(iRandom1<=28)){sBP = "mn_golem005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=29)&&(iRandom1<=30)){sBP = "mn_golem011";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Maugs")||(iDungeonFamNbr==4)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Maugs";
iRandom1 = Random(15)+1;
     if((iRandom1>=1)&&(iRandom1<=7)){sBP = "mn_maug001";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=9)){sBP = "mn_maug003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=10)&&(iRandom1<=10)){sBP = "mn_maug004";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=11)&&(iRandom1<=15)){sBP = "mn_maug002";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
else if((sFamily=="Spiders Strong")||(iDungeonFamNbr==5)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Spiders Strong";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_spider007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=5)){sBP = "mn_spider015";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=9)){sBP = "mn_spider013";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==8){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(0)+1;iDungeonFamNbr = 0;}else{iDungeonFamNbr = Random(1)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Beetles Strong")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Beetles Strong";
iRandom1 = Random(7)+1;
     if((iRandom1>=1)&&(iRandom1<=2)){sBP = "mn_beetle011";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=5)){sBP = "mn_beetle012";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_beetle014";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "mn_beetle013";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==9){if(iDungeonFamily>0){iDungeonFamNbr = iDungeonFamily;}else if(sFamily==""){if(iPoint>1){iCampFamNbr = Random(1)+1;iDungeonFamNbr = 1;}else{iDungeonFamNbr = Random(1)+1;}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
if((sFamily=="Space Dungeon")||(iDungeonFamNbr==1)){while(iDungeonCreNbr>0){iDungeonCreNbr--;sBP = "";
////////////////////////////////////////////////////////////////////////////////
sFamily = "Space Dungeon";
iRandom1 = Random(9)+1;
     if((iRandom1>=1)&&(iRandom1<=1)){sBP = "mn_animated005";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=2)&&(iRandom1<=2)){sBP = "mn_animated008";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=3)&&(iRandom1<=3)){sBP = "mn_animated006";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=4)&&(iRandom1<=4)){sBP = "mn_animated007";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=5)&&(iRandom1<=5)){sBP = "mn_maug002";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=6)&&(iRandom1<=6)){sBP = "mn_maug003";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=7)&&(iRandom1<=7)){sBP = "nw_minogon";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=8)&&(iRandom1<=8)){sBP = "nw_helmhorr";iFaction = STANDARD_FACTION_HOSTILE;}
else if((iRandom1>=9)&&(iRandom1<=9)){sBP = "nw_bathorror";iFaction = STANDARD_FACTION_HOSTILE;}
////////////////////////////////////////////////////////////////////////////////
if(iPoint==1){lLoc = GetLocation(oPoint);}else if(iPoint==5){lLoc = Location(OBJECT_SELF,Vector(10.0,14.0,0.0),0.0);}else if(iPoint>1){lLoc = Location(OBJECT_SELF,Vector(IntToFloat(iAreaX/2)-0.0,IntToFloat(iAreaY/2)-5.0,0.0),0.0);}else{lLoc = Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0);}oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc,FALSE,sBP);ChangeToStandardFaction(oNew,iFaction);if(iPoint>1){SetLocalInt(oNew,"Camp",1);}else if(Random(iLeader)==0){SetLocalInt(oNew,"Leader",1);}if(iPoint>1){if(Random(2)==1){SetLocalInt(oNew,"Stop",1);AssignCommand(oNew,ActionRandomWalk());}}ExecuteScript("creatures_heart",oNew);if((sLeftTag=="d_")&&(iPoint==0)&&(Random(iEnigm)==0)){oPla = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm00"+IntToString(Random(iEnigmPla)+1),GetLocation(oNew));SetName(oPla,GetStringRight(GetName(oPla),GetStringLength(GetName(oPla))-8));ExecuteScript("enigms",oPla);}}if(((sLeftTag=="d_")||(sLeftTag=="h_"))&&(iPoint==0)){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF)+IntToString(Random(4)+1))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);ExecuteScript("traps",OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
if(GetIsObjectValid(oEntry)){SetLocalString(oEntry,"Var",IntToString(iDungeonFamNbr)+"&"+IntToString(iLevel));}
if(GetStringLeft(GetTag(OBJECT_SELF),8)=="d_castle"){sFamily = "";}
if((iInt==0)&&(iPoint==0)&&(sPlanet!="")&&(sArea!="")&&(sInterestsLeft!="")&&(sInterestsRight!="")&&(sFamily!="")){SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests",sInterestsLeft+sFamily+"_D_"+IntToString(iCreNbr)+"_E_"+sInterestsRight);}
////////////////////////////////////////////////////////////////////////////////
// Dungeon placeables
if(iPoint<1)
 {
////////////////////////////////////////////////////////////////////////////////
// Castle Underground
if(GetStringLeft(GetTag(OBJECT_SELF),9)=="d_castle1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker002",Location(OBJECT_SELF,Vector(23.5,238.5,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(147.0,297.0,fZ+0.0),DIRECTION_WEST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker005",Location(OBJECT_SELF,Vector(317.0,298.5,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
// Castle Interior
else if(GetStringLeft(GetTag(OBJECT_SELF),9)=="h_castle1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"lever001",Location(OBJECT_SELF,Vector(133.0,179.0,fZ+0.0),DIRECTION_WEST),FALSE,"lever1");SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13)+" 1");oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"lever001",Location(OBJECT_SELF,Vector(133.0,181.0,fZ+0.0),DIRECTION_WEST),FALSE,"lever2");SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13)+" 2");oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"lever001",Location(OBJECT_SELF,Vector(139.0,187.0,fZ+0.0),DIRECTION_NORTH),FALSE,"lever3");SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13)+" 3");oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"lever001",Location(OBJECT_SELF,Vector(141.0,187.0,fZ+0.0),DIRECTION_NORTH),FALSE,"lever4");SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13)+" 4");oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"lever001",Location(OBJECT_SELF,Vector(147.0,181.0,fZ+0.0),DIRECTION_EAST),FALSE,"lever5");SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13)+" 5");oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"lever001",Location(OBJECT_SELF,Vector(147.0,179.0,fZ+0.0),DIRECTION_EAST),FALSE,"lever6");SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13)+" 6");oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker004",Location(OBJECT_SELF,Vector(145.0,199.0,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"chest00"+IntToString(iLevel),GetLocation(GetWaypointByTag("wp_"+GetTag(OBJECT_SELF))));SetName(oNew,"Chest");ExecuteScript("traps",oNew);
  }
////////////////////////////////////////////////////////////////////////////////
// Cave
else if(GetStringLeft(GetTag(OBJECT_SELF),7)=="d_cave1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker005",Location(OBJECT_SELF,Vector(167.0,314.0,fZ+0.0),DIRECTION_WEST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker005",Location(OBJECT_SELF,Vector(305.0,265.0,fZ+0.0),DIRECTION_WEST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(56.5,307.0,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker005",Location(OBJECT_SELF,Vector(30.0,74.0,fZ+0.0),DIRECTION_WEST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
// Crypt
else if(GetStringLeft(GetTag(OBJECT_SELF),8)=="d_crypt1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker002",Location(OBJECT_SELF,Vector(37.0,288.0,fZ+0.2),DIRECTION_SOUTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker002",Location(OBJECT_SELF,Vector(147.0,147.0,fZ+0.2),DIRECTION_SOUTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker002",Location(OBJECT_SELF,Vector(127.0,33.0,fZ+0.2),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker002",Location(OBJECT_SELF,Vector(23.0,33.0,fZ+0.2),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
// Dungeon
else if(GetStringLeft(GetTag(OBJECT_SELF),7)=="d_dung1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker002",Location(OBJECT_SELF,Vector(2.5,13.5,fZ+0.0),DIRECTION_SOUTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker004",Location(OBJECT_SELF,Vector(147.5,207.5,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker005",Location(OBJECT_SELF,Vector(287.0,64.8,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
// Old Castle
else if(GetStringLeft(GetTag(OBJECT_SELF),12)=="d_oldcastle1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(286.5,177.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(307.0,203.0,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker002",Location(OBJECT_SELF,Vector(36.5,282.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker004",Location(OBJECT_SELF,Vector(14.0,195.0,fZ+0.0),DIRECTION_SOUTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
// Pyramid
else if(GetStringLeft(GetTag(OBJECT_SELF),10)=="d_pyramid1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(317.0,307.0,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker003",Location(OBJECT_SELF,Vector(210.0,287.5,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(116.5,288.0,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker004",Location(OBJECT_SELF,Vector(45.0,296.0,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
// Temple
else if(GetStringLeft(GetTag(OBJECT_SELF),9)=="d_temple1")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(231.5,187.0,fZ+0.0),DIRECTION_WEST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker001",Location(OBJECT_SELF,Vector(307.0,183.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker004",Location(OBJECT_SELF,Vector(305.0,307.5,fZ+0.0),DIRECTION_SOUTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker003",Location(OBJECT_SELF,Vector(6.5,282.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
// Domain Tower
else if(GetStringLeft(GetTag(OBJECT_SELF),7)=="h_tower")
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm002",Location(OBJECT_SELF,Vector(65.0,70.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-8));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm002",Location(OBJECT_SELF,Vector(65.0,80.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-8));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm002",Location(OBJECT_SELF,Vector(65.0,90.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-8));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm002",Location(OBJECT_SELF,Vector(70.0,65.0,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-8));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm002",Location(OBJECT_SELF,Vector(70.0,95.0,fZ+0.0),DIRECTION_SOUTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-8));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm002",Location(OBJECT_SELF,Vector(75.0,70.0,fZ+0.0),DIRECTION_WEST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-8));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_enigm002",Location(OBJECT_SELF,Vector(75.0,80.0,fZ+0.0),DIRECTION_WEST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-8));
  }
////////////////////////////////////////////////////////////////////////////////
// Tower
else if((GetStringLeft(GetTag(OBJECT_SELF),9)=="d_towerb1")||(GetStringLeft(GetTag(OBJECT_SELF),9)=="d_towerw1"))
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker004",Location(OBJECT_SELF,Vector(253.0,135.0,fZ+0.0),DIRECTION_EAST));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"enigmmaker003",Location(OBJECT_SELF,Vector(23.5,187.5,fZ+0.0),DIRECTION_NORTH));SetPlotFlag(oNew,TRUE);SetName(oNew,GetStringRight(GetName(oNew),GetStringLength(GetName(oNew))-13));oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
}
