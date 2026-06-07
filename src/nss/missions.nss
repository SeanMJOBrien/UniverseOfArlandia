#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();if(oPC==OBJECT_INVALID){oPC = OBJECT_SELF;}if(GetIsObjectValid(GetMaster(oPC))){oPC = GetMaster(oPC);}
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
int iAreaX = GetAreaSize(AREA_WIDTH,oArea)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,oArea)*10;
string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);
int iX;if(GetStringLeft(sX,1)=="m"){iX = -StringToInt(GetStringRight(sX,GetStringLength(sX)-1));}else{iX = StringToInt(sX);}
int iY;if(GetStringLeft(sY,1)=="m"){iY = -StringToInt(GetStringRight(sY,GetStringLength(sY)-1));}else{iY = StringToInt(sY);}
//
string sVar = GetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX));
//
string sTot = GetPersistentString(oModule,sPlanet);
string sPlanetPlace = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
int iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5));
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));
int iPlanetHalfSize = iPlanetSize/2;
//
int iMissionsDay = GetLocalInt(oModule,sPlanet+sArea+"MissionsDay");
int iMission = GetLocalInt(oPC,"Mission");
int iMissionToPlace = GetLocalInt(oPC,"MissionToPlace");
object oMissionObject = GetLocalObject(oPC,"MissionObject");
//
int MissionType1 = 10;SetLocalInt(oModule,"MissionType1",MissionType1);
int MissionType2 = 20;SetLocalInt(oModule,"MissionType2",MissionType2);
int MissionType3 = 30;SetLocalInt(oModule,"MissionType3",MissionType3);
int MissionType4 = 40;SetLocalInt(oModule,"MissionType4",MissionType4);
int MissionType5 = 50;SetLocalInt(oModule,"MissionType5",MissionType5);
//
object oFaction;object oItems;string sMission;string sMaster;int iRandom1;int iRandom2;int iMissX;int iMissY;string sMissX;string sMissY;string sMissArea;string sProvArea;float fX;float fY;float fDist;int iDist;int f;int i;int j;int iTot;int jTot;string sSystem;string sMissPlanet;int iType;string sBP;string sTag;int iNumber;int iXP;int iGP;string sTitle;string sDes;string sMissPlanetPlace;int iMissPlanetSize;object oCre;object oNew;string sInterests;string sName;string sCount1;string sCount2;string sNewArea;
////////////////////////////////////////////////////////////////////////////////
ExecuteScript("conv_dm_varempty",OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
// Area_enter : place mission
if(iMissionToPlace==1)
 {
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iMission));
// Mission variables
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);
sTag = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&006&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&006&")))-FindSubString(sMission,"&005&")-5);
iNumber = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&007&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&007&")))-FindSubString(sMission,"&006&")-5));
////////////////////////////////////////////////////////////////////////////////
// Check if mission already done :
i=0;j=0;
////////////////////////////////////////////////////////////////////////////////
// Take back items
if((iType>=1)&&(iType<=MissionType1))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if(GetLocalString(oItems,"Var")==sMission){i++;break;}
oItems = GetNextItemInInventory(oPC);
   }
  }
////////////////////////////////////////////////////////////////////////////////
// Find resources
else if((iType>=MissionType1+1)&&(iType<=MissionType2))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if(GetResRef(oItems)==sBP){j++;}
oItems = GetNextItemInInventory(oPC);
   }
if(j>=iNumber){i++;}
  }
////////////////////////////////////////////////////////////////////////////////
// Bring note
else if((iType>=MissionType2+1)&&(iType<=MissionType3))
  {
i++;
  }
////////////////////////////////////////////////////////////////////////////////
// Take back creature
else if((iType>=MissionType3+1)&&(iType<=MissionType4))
  {
if(GetLocalInt(oGoldbag,"MissionSuccess"+IntToString(iMission))!=0){i++;}
  }
////////////////////////////////////////////////////////////////////////////////
// Kill monster
else if((iType>=MissionType4+1)&&(iType<=MissionType5))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if(GetLocalString(oItems,"Var")==sMission){i++;break;}
oItems = GetNextItemInInventory(oPC);
   }
  }
////////////////////////////////////////////////////////////////////////////////
if(i==0)
  {
if((iType>=MissionType3+1)&&(iType<=MissionType4)){i = 1;}if(iType<=MissionType1){iType = OBJECT_TYPE_ITEM;}else if(iType>=MissionType3+1){iType = OBJECT_TYPE_CREATURE;}

while(iNumber>0)
   {
oCre = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",Location(oArea,Vector(IntToFloat(Random(iAreaX-5)+5),IntToFloat(Random(iAreaY/2-5)+5),0.0),DIRECTION_NORTH));
oNew = CreateObject(iType,sBP,GetLocation(oCre),FALSE,sTag);DestroyObject(oCre);
DelayCommand(0.5,SetName(oNew,GetName(oNew)+"*"));
SetLocalInt(oNew,"Mission",iMission);
SetLocalString(oNew,"Var",sMission);
SetLocalString(oNew,"Master",GetName(oPC));
SetLocalString(oNew,"Tag","mission");
SetLocalInt(oNew,"DontSave",1);
if(GetObjectType(oNew)==OBJECT_TYPE_ITEM){SetIdentified(oNew,TRUE);SetPlotFlag(oNew,TRUE);SetDroppableFlag(oNew,FALSE);}
else if(i==1){ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetPlotFlag(oNew,TRUE);}

iNumber--;
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Creature death or Item acquired
else if(iMissionToPlace==2)
 {
sMaster = GetLocalString(oMissionObject,"Master");
sMission = GetLocalString(oMissionObject,"Var");
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);
sTag = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&006&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&006&")))-FindSubString(sMission,"&005&")-5);
f = GetLocalInt(oArea,"PartyMembers");while(f>0){oFaction = GetLocalObject(oArea,IntToString(f)+"PartyMember");if(GetName(oFaction)==sMaster){f = -1;break;}f--;}

if((iType>=MissionType3+1)&&(iType<=MissionType4)){i = 1;}if(iType<=MissionType1){iType = OBJECT_TYPE_ITEM;}else if(iType>=MissionType3+1){iType = OBJECT_TYPE_CREATURE;}

if(((GetName(oPC)==sMaster)||(f==-1))&&(i!=1))
  {
if(GetObjectType(oMissionObject)==OBJECT_TYPE_CREATURE)
   {
oPC = oFaction;
oNew = CreateItemOnObject("cr_head",oPC);
SetName(oNew,GetName(oMissionObject)+" remain");
SetLocalInt(oNew,"Mission",iMission);
SetLocalString(oNew,"Var",sMission);
SetLocalString(oNew,"Master",sMaster);
SetIdentified(oNew,TRUE);SetPlotFlag(oNew,TRUE);SetDroppableFlag(oNew,FALSE);
   }
  }
else if(i==1)
  {
SetLocalInt(GetItemPossessedBy(GetLocalObject(OBJECT_SELF,"PC"),"goldbag"),"MissionSuccess"+IntToString(iMission),2);
if(GetObjectType(oMissionObject)==OBJECT_TYPE_CREATURE){SetImmortal(oMissionObject,FALSE);SetPlotFlag(oMissionObject,FALSE);AssignCommand(oMissionObject,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oMissionObject,1.0);}
  }
else
  {
oCre = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",Location(oArea,Vector(IntToFloat(Random(iAreaX-5)+5),IntToFloat(Random(iAreaY/2-5)+5),0.0),DIRECTION_NORTH));
oNew = CreateObject(iType,sBP,GetLocation(oCre),FALSE,sTag);DestroyObject(oCre);
DelayCommand(0.5,SetName(oNew,GetName(oNew)+"*"));
SetLocalInt(oNew,"Mission",iMission);
SetLocalString(oNew,"Var",sMission);
SetLocalString(oNew,"Master",sMaster);
SetLocalString(oNew,"Tag","mission");
SetLocalInt(oNew,"DontSave",1);
if(GetObjectType(oNew)==OBJECT_TYPE_ITEM){SetIdentified(oNew,TRUE);SetPlotFlag(oNew,TRUE);SetDroppableFlag(oNew,FALSE);}
if(GetObjectType(oMissionObject)==OBJECT_TYPE_CREATURE){SetImmortal(oMissionObject,FALSE);SetPlotFlag(oMissionObject,FALSE);AssignCommand(oMissionObject,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oMissionObject,1.0);}
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Check missions
int iPCMissions = GetLocalInt(oGoldbag,"Missions");

while(iPCMissions>0)
 {
i=0;j=0;
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iPCMissions));
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
sProvArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&003&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&003&")))-FindSubString(sMission,"&002&")-5);
sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);
sTag = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&006&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&006&")))-FindSubString(sMission,"&005&")-5);
iNumber = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&007&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&007&")))-FindSubString(sMission,"&006&")-5));
iXP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&008&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&008&")))-FindSubString(sMission,"&007&")-5));
iGP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&009&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&009&")))-FindSubString(sMission,"&008&")-5));
iDist = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&010&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&010&")))-FindSubString(sMission,"&009&")-5));
sTitle = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&011&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&011&")))-FindSubString(sMission,"&010&")-5);
sDes = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&012&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&012&")))-FindSubString(sMission,"&011&")-5);

if((sMissPlanet==sPlanet)&&((iType>=MissionType2+1)&&(iType<=MissionType3)&&(sArea==sMissArea))||(((iType<MissionType2+1)||(iType>MissionType3))&&(sProvArea==sArea)))
  {
////////////////////////////////////////////////////////////////////////////////
// Take back items
if((iType>=1)&&(iType<=MissionType1))
   {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
    {
if(GetLocalString(oItems,"Var")==sMission){i++;break;}
oItems = GetNextItemInInventory(oPC);
    }
   }
////////////////////////////////////////////////////////////////////////////////
// Find resources
else if((iType>=MissionType1+1)&&(iType<=MissionType2))
   {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
    {
if(GetResRef(oItems)==sBP){j++;}
oItems = GetNextItemInInventory(oPC);
    }
if(j>=iNumber){i++;}
   }
////////////////////////////////////////////////////////////////////////////////
// Bring note
else if((iType>=MissionType2+1)&&(iType<=MissionType3))
   {
if(sArea==sMissArea){i++;}
   }
////////////////////////////////////////////////////////////////////////////////
// Take back creature
else if((iType>=MissionType3+1)&&(iType<=MissionType4))
   {
while(j<GetMaxHenchmen())
    {
j++;
oItems = GetHenchman(oPC,j);
if((GetResRef(oItems)==sBP)&&(GetLocalInt(oItems,"Mission")==iPCMissions)){i++;break;}
    }
   }
////////////////////////////////////////////////////////////////////////////////
// Kill monster
else if((iType>=MissionType4+1)&&(iType<=MissionType5))
   {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
    {
if(GetLocalString(oItems,"Var")==sMission){i++;break;}
oItems = GetNextItemInInventory(oPC);
    }
   }
////////////////////////////////////////////////////////////////////////////////
  }
if(i>0){SetLocalInt(OBJECT_SELF,"MS"+IntToString(iPCMissions),1);}else{DeleteLocalInt(OBJECT_SELF,"MS"+IntToString(iPCMissions));}
iPCMissions--;
 }
////////////////////////////////////////////////////////////////////////////////
// Mission conversation
if(iMissionsDay!=GetCalendarDay())
 {
if(GetLocalInt(oModule,sPlanet+"MissIni")!=1){SetLocalInt(oModule,sPlanet+"MissIni",1);SetLocalString(oModule,"MissIniPlanet",sPlanet);ExecuteScript("missions_ini",oModule);}

SetLocalInt(oModule,sPlanet+sArea+"MissionsDay",GetCalendarDay());
jTot = StringToInt(GetLocalString(oModule,"Systems"));j=0;while(j<jTot){j++;sSystem = GetLocalString(oModule,"System"+IntToString(j));if(sSystem!=""){iTot = StringToInt(GetLocalString(oModule,sSystem+"Planets"));i=0;while(i<iTot){i++;sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(i));sMissPlanet = GetStringLeft(sTot,FindSubString(sTot,"&0001&"));if(sMissPlanet==sPlanet){break;break;}}}}
////////////////////////////////////////////////////////////////////////////////
iRandom1 = Random(7)+6; // Missions number
SetLocalInt(oModule,sPlanet+sArea+"Missions",iRandom1);
while(iRandom1>0)
  {
////////////////////////////////////////////////////////////////////////////////
iRandom2 = Random(50)+1; // Missions types
////////////////////////////////////////////////////////////////////////////////
// Mission area
if(Random(2)==0){iMissX = iX-Random(5)-1;}else{iMissX = iX+Random(5)+1;}if(iMissX>iPlanetHalfSize){iMissX = iMissX-iPlanetHalfSize*2;}else if(iMissX<-iPlanetHalfSize){iMissX = iMissX+iPlanetHalfSize*2;}
if(Random(2)==0){iMissY = iY-Random(5)-1;}else{iMissY = iY+Random(5)+1;}if(iMissY>iPlanetHalfSize){iMissY = iMissY-iPlanetHalfSize*2;}else if(iMissY<-iPlanetHalfSize){iMissY = iMissY+iPlanetHalfSize*2;}
sMissX = IntToString(iMissX);if(iMissX<0){sMissX = "m"+GetStringRight(IntToString(iMissX),GetStringLength(IntToString(iMissX))-1);}
sMissY = IntToString(iMissY);if(iMissY<0){sMissY = "m"+GetStringRight(IntToString(iMissY),GetStringLength(IntToString(iMissY))-1);}
sMissArea = sMissX+"_"+sMissY;
//
if(iY<=-10){sCount1 = "-"+IntToString(-iY);}else if(iY<0){sCount1 = "-0"+IntToString(-iY);}else if(iY<10){sCount1 = "+0"+IntToString(iY);}else{sCount1 = "+"+IntToString(iY);}sCount1 = "&"+sCount1+"&";
if(iY-1<=-10){sCount2 = "-"+IntToString(-iY+1);}else if(iY-1<0){sCount2 = "-0"+IntToString(-iY+1);}else if(iY-1<10){sCount2 = "+0"+IntToString(iY-1);}else{sCount2 = "+"+IntToString(iY-1);}sCount2 = "&"+sCount2+"&";
if(iY==-iPlanetSize/2){sNewArea = GetStringLeft(sVar,FindSubString(sVar,sCount1));}else{sNewArea = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,sCount1)),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,sCount1)))-FindSubString(sVar,sCount2)-5);}
//
fX = IntToFloat(iMissX)-IntToFloat(iX);if(fX<0.0){fX = -fX;}if(fX>IntToFloat(iPlanetHalfSize)){fX = IntToFloat(iPlanetHalfSize-(FloatToInt(fX)-iPlanetHalfSize));}
fY = IntToFloat(iMissY)-IntToFloat(iY);if(fY<0.0){fY = -fY;}if(fY>IntToFloat(iPlanetHalfSize)){fY = IntToFloat(iPlanetHalfSize-(FloatToInt(fY)-iPlanetHalfSize));}
fDist = sqrt((fX*fX)+(fY*fY));iDist = FloatToInt(fDist);
////////////////////////////////////////////////////////////////////////////////
// No mission on ocean areas
if(GetStringLeft(sNewArea,2)=="12")
 {
sMissArea = "";
 }
////////////////////////////////////////////////////////////////////////////////
// Take back items
else if(iRandom2==1) {sBP = "book";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the book";sDes = "I have borrowed a precious book from a friend. But on the way here I was attacked by a furious beast. I dropped the book to flee. Can you get it back to me?";}
else if(iRandom2==2) {sBP = "tent001";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the tent";sDes = "With friends, we did a little meal in the nature, but we forgot to take back our small tent. I can not leave this place now. Would you be so nice to get it back for me?";}
else if(iRandom2==3) {sBP = "cr_globewater";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the globe";sDes = "A powerful wizard gave me a globe of water, containing all the power of the water element. But I forgot it somewhere. The wizard will be upset if he can't get his globe back. Would you be so nice and try to find it for me?";}
else if(iRandom2==4) {sBP = "cr_eggs";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the eggs";sDes = "Oh, damn, I lost my eggs. Too bad, I had the plan to prepare a good meal with them. Could you find them for me ?";}
else if(iRandom2==5) {sBP = "nw_it_torch001";iNumber = 3;iXP = 120;iGP = 60;sTitle = "Find the torches";sDes = "Last day we went to the nearest forest and cut some trees to make torches. But our carriage was overloaded and some torches felt to the ground. Maybe you can grab them back ?";}
else if(iRandom2==6) {sBP = "nw_it_mmidmisc09";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the map";sDes = "Traveling from the nearest town to this place, I forgot a map somewhere. I'm angry because this map is important to me. Would you be so nice and try to get it for me?";}
else if(iRandom2==7) {sBP = "nw_it_trap040";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the trap kit";sDes = "A friend of mine, a rogue, is a champion in crafting trap kits. He places them everywhere, especially to catch animals. But he forgot one high leveled trap in the near areas. If you can find it, he would be very happy!";}
else if(iRandom2==8) {sBP = "x2_it_mpotion002";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the potion";sDes = "I had 4 potions of Death Armor in my bag, and only 3 are left now. That means I forgot one somewhere. Can you find it ?";}
else if(iRandom2==9) {sBP = "nw_ashto001";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the shield";sDes = "A friend of mine who is living far far away came to visit me a few days ago. Then he left but forgot his tower shield. Would you be so nice and try to find it ?";}
else if(iRandom2==10){sBP = "helm_q";iNumber = 1;iXP = 100;iGP = 50;sTitle = "Find the crown";sDes = "The first prize of the most recent tournament was a very expensive helmet called the 'Crown of Thorns'. Unfortunately, I left it somewhere and forgot to bring it back. It is most important that somebody bring it back to me as soon as possible!";}
////////////////////////////////////////////////////////////////////////////////
// Find resources
else if((iRandom2>=11)&&(iRandom2<=20))
 {
sMissArea = sArea;
     if(iRandom2==11){sBP = "cr_woodbasic";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find wood";sDes = "I need some basic wood for my house. Can you give me some planks ?";}
else if(iRandom2==12){sBP = "cr_iron";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find iron";sDes = "I need some iron for the nearest town. Can you give me some bars ?";}
else if(iRandom2==13){sBP = "cr_steel";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find steel";sDes = "I need some steel for the nearest town. Can you give me some bars ?";}
else if(iRandom2==14){sBP = "cr_plantcommon";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find common plants";sDes = "I need some common plants for my next meals. Can you find and give me some ?";}
else if(iRandom2==15){sBP = "cr_nail";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find nails";sDes = "I need some nails to make clothes. Can you find and give me some ?";}
else if(iRandom2==16){sBP = "cr_skinherbivore";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find herbivore skins";sDes = "I need some herbivore skins to make clothes. Can you find and give me some ?";}
else if(iRandom2==17){sBP = "cr_hair";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find hairs";sDes = "I need some hairs to make clothes. Can you find and give me some ?";}
else if(iRandom2==18){sBP = "cr_feathers";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find feathers";sDes = "I need a few feathers to write my letters. Can you find and give me some ?";}
else if(iRandom2==19){sBP = "cr_sandwich";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find sandwiches";sDes = "I need sandwiches for my next meals for my visitors. Do you have some ?";}
else if(iRandom2==20){sBP = "cr_poison";iNumber = Random(3)+3;iXP = iNumber*5;iGP = iNumber*5;sTitle = "Find poison";sDes = "I need some poison, not for me but for my master who is making new potions. Hem. Do you have some ?";}
 }
////////////////////////////////////////////////////////////////////////////////
// Bring note
else if((iRandom2>=21)&&(iRandom2<=30))
   {
if(GetLocalInt(oModule,sPlanet+"Towns")<2)
    {
sMissArea = "";
    }
else
    {
sMissArea = GetLocalString(oModule,sPlanet+"Towns"+IntToString(Random(GetLocalInt(oModule,sPlanet+"Towns"))+1));while(sMissArea==sArea){sMissArea = GetLocalString(oModule,sPlanet+"Towns"+IntToString(Random(GetLocalInt(oModule,sPlanet+"Towns"))+1));}
//
sX = GetStringLeft(sMissArea,FindSubString(sMissArea,"_"));
sY = GetStringRight(sMissArea,GetStringLength(sMissArea)-FindSubString(sMissArea,"_")+1);
if(GetStringLeft(sX,1)=="m"){sX = "-"+GetStringRight(sX,GetStringLength(sX)-1);}iMissX = StringToInt(sX);
if(GetStringLeft(sY,1)=="m"){sY = "-"+GetStringRight(sY,GetStringLength(sY)-1);}iMissY = StringToInt(sY);
fX = IntToFloat(iMissX)-IntToFloat(iX);if(fX<0.0){fX = -fX;}if(fX>IntToFloat(iPlanetHalfSize)){fX = IntToFloat(iPlanetHalfSize-(FloatToInt(fX)-iPlanetHalfSize));}
fY = IntToFloat(iMissY)-IntToFloat(iY);if(fY<0.0){fY = -fY;}if(fY>IntToFloat(iPlanetHalfSize)){fY = IntToFloat(iPlanetHalfSize-(FloatToInt(fY)-iPlanetHalfSize));}
fDist = sqrt((fX*fX)+(fY*fY));iDist = FloatToInt(fDist);
//
sInterests = GetPersistentString(oModule,sPlanet+"&"+sMissArea+"&Interests");
sName = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")))-FindSubString(sInterests,"&1&")-3);if(sName==""){sName = "his castle";}
SetLocalString(oModule,sPlanet+"TownName"+IntToString(iRandom1),sName);
sBP = "scroll001";iNumber = 1;iXP = 30;iGP = 30;sTitle = "Bring a note";sDes = "I have to bring a note to my colleague in "+sName+" but I can not leave this place. Could you do it for me ?";
    }
   }
////////////////////////////////////////////////////////////////////////////////
// Take back creatures
else if(iRandom2==31){sBP = "mn_bear001";iNumber = 1;iXP = 120;iGP = 100;sTitle = "Take back the bear";sDes = "A bear escaped from the nearest circus. Would you be so glad and try to get it back here ? No worry, he is not dangerous.";}
else if(iRandom2==32){sBP = "mn_bird002";iNumber = 1;iXP = 140;iGP = 100;sTitle = "Take back the bird";sDes = "I had a beautiful singing bird but it escaped. Could you find it ?";}
else if(iRandom2==33){sBP = "mn_boar002";iNumber = 1;iXP = 100;iGP = 100;sTitle = "Take back the boar";sDes = "I need a boar for my next meal. I've heard there is one somewhere who is nearly aslept. Maybe you can get it back for me ?";}
else if(iRandom2==34){sBP = "mn_wildchicken";iNumber = 1;iXP = 160;iGP = 100;sTitle = "Take back the chicken";sDes = "Damned, I lost my chicken and I need them for my next meal. Would you be so glad and get them back for me ?";}
else if(iRandom2==35){sBP = "mn_deer001";iNumber = 1;iXP = 140;iGP = 100;sTitle = "Take back the deer";sDes = "I need a deer for my next meal. I've heard there is one somewhere who is nearly aslept. Maybe you can get it back for me ?";}
else if(iRandom2==36){sBP = "mn_wolf001";iNumber = 1;iXP = 100;iGP = 100;sTitle = "Take back the wolf";sDes = "A wolf escaped from the nearest circus. Would you be so glad and try to get it back here ? No worry, he is not dangerous.";}
else if(iRandom2==37){sBP = "mn_wildhorse004";iNumber = 1;iXP = 100;iGP = 100;sTitle = "Take back the horse";sDes = "A horse escaped from the nearest circus. Would you be so glad and try to get it back here ? No worry, he is not dangerous.";}
else if(iRandom2==38){sBP = "mn_feline011";iNumber = 1;iXP = 100;iGP = 100;sTitle = "Take back the lion";sDes = "A lion escaped from the nearest circus. Would you be so glad and try to get it back here ? No worry, he is not dangerous.";}
else if(iRandom2==39){sBP = "mn_ogre002";iNumber = 1;iXP = 100;iGP = 100;sTitle = "Take back the ogre";sDes = "An ogre escaped from the nearest circus. Would you be so glad and try to get it back here ? No worry, he is not dangerous.";}
else if(iRandom2==40){sBP = "mn_feline008";iNumber = 1;iXP = 100;iGP = 100;sTitle = "Take back the panther";sDes = "A panther escaped from the nearest circus. Would you be so glad and try to get it back here ? No worry, he is not dangerous.";}
////////////////////////////////////////////////////////////////////////////////
// Kill monsters
else if((iRandom2>=41)&&(iRandom2<=50))
   {
if(iLevel==1){sBP = "mn_goblin011";iNumber = 1;iXP = 100;iGP = 100;sTitle = "Kill the goblin";sDes = "A goblin is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==2){sBP = "mn_orc011";iNumber = 1;iXP = 100;iGP = 120;sTitle = "Kill the orc";sDes = "An orc is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==3){sBP = "mn_ogre005";iNumber = 1;iXP = 100;iGP = 140;sTitle = "Kill the ogre";sDes = "An ogre is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==4){sBP = "mn_giant002";iNumber = 1;iXP = 100;iGP = 200;sTitle = "Kill the giant";sDes = "A giant is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==5){sBP = "mn_gorochem003";iNumber = 1;iXP = 100;iGP = 300;sTitle = "Kill the gorochem";sDes = "A gorochem is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==6){sBP = "mn_vampire008";iNumber = 1;iXP = 200;iGP = 400;sTitle = "Kill the vampire";sDes = "A vampire is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==7){sBP = "mn_marilith001";iNumber = 1;iXP = 200;iGP = 600;sTitle = "Kill the marilith";sDes = "A marilith is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==8){sBP = "mn_golem002";iNumber = 1;iXP = 200;iGP = 800;sTitle = "Kill the golem";sDes = "A golem is making trouble in the nearest areas. I need somebody to stop it.";}
if(iLevel==9){sBP = "mn_dragon002";iNumber = 1;iXP = 200;iGP = 1000;sTitle = "Kill the dragon";sDes = "A dragon is making trouble in the nearest areas. I need somebody to stop it.";}
   }
////////////////////////////////////////////////////////////////////////////////
sTag = "*"+sBP+"*";
//
if(sMissArea!="")
   {
SetLocalString(oModule,sPlanet+sArea+"Mission"+IntToString(iRandom1),IntToString(iRandom2)+"&001&"+sPlanet+"&002&"+sArea+"&003&"+sMissArea+"&004&"+sBP+"&005&"+sTag+"&006&"+IntToString(iNumber)+"&007&"+IntToString(iXP)+"&008&"+IntToString(iGP)+"&009&"+IntToString(iDist)+"&010&"+sTitle+"&011&"+sDes+"&012&");
DeleteLocalInt(OBJECT_SELF,"MT"+IntToString(iRandom1));
iRandom1--;
   }
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
ExecuteScript("conv_dm_varempty",OBJECT_SELF);
DeleteLocalInt(oPC,"MissionToPlace");
DeleteLocalInt(oArea,"PartyMembers");
////////////////////////////////////////////////////////////////////////////////
// First
int a = 13;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
////////////////////////////////////////////////////////////////////////////////
}
