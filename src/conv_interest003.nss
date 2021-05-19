#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPos = GetLocalString(OBJECT_SELF,"Word");
int iLevel = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
object oItems = GetFirstItemInInventory(oPC);
effect eEffects = GetFirstEffect(oPC);
//
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
string sX = IntToString(FloatToInt(GetPosition(OBJECT_SELF).x));
string sY = IntToString(FloatToInt(GetPosition(OBJECT_SELF).y));
float fZ = 0.0;if(GetStringLeft(GetTag(oArea),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")){fZ = 5.0;}
float fAreaX = IntToFloat(GetAreaSize(AREA_WIDTH,oArea)*10/2);
float fAreaY = IntToFloat(GetAreaSize(AREA_HEIGHT,oArea)*10/2);
//
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
//
object oNew;object oCre;string sResult;string sBP;int iRandom;int iChoice;int iCardNPC;int iCardPC;int iCard1;int iCard2;int iCard3;int iCard4;int iCard5;string s1;string s2;string s3;int iNum;int iPrice;int i;int j;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// race
if(iChoice1==1)
 {
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
AssignCommand(oPC,ActionJumpToLocation(Location(oArea,Vector(fAreaX-23.0,fAreaY-5.0,fZ),DIRECTION_NORTH)));AssignCommand(oPC,SetFacing(DIRECTION_NORTH));
oCre = CreateObject(OBJECT_TYPE_CREATURE,"npc_tord",Location(oArea,Vector(fAreaX-27.0,fAreaY-5.0,fZ),DIRECTION_NORTH));SetLocalInt(oCre,"DontSave",1);if(iLevel>1){i=1;while(i<iLevel){i++;LevelUpHenchman(oCre);}}
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_dummy",Location(oArea,Vector(fAreaX-27.0,fAreaY+13.0,fZ),DIRECTION_SOUTH),FALSE,"dummyL");SetLocalInt(oNew,"DontSave",1);SetPlotFlag(oNew,TRUE);SetLocalString(oNew,"Player",GetName(oCre));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_dummy",Location(oArea,Vector(fAreaX-23.0,fAreaY+13.0,fZ),DIRECTION_SOUTH),FALSE,"dummyR");SetLocalInt(oNew,"DontSave",1);SetPlotFlag(oNew,TRUE);SetLocalString(oNew,"Player",GetName(oPC));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectParalyze(),oPC);
iPrice = 20;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
else
  {
oNew = GetNearestObjectByTag("dummyR");SetPlotFlag(oNew,FALSE);
oNew = GetNearestObjectByTag("dummyL");SetPlotFlag(oNew,FALSE);
oCre = GetNearestObjectByTag("npc_tord");SetLocalInt(oCre,"Start",1);
AssignCommand(oCre,DoPlaceableObjectAction(oNew,PLACEABLE_ACTION_BASH));
while(GetIsEffectValid(eEffects)){if(GetEffectType(eEffects)==EFFECT_TYPE_PARALYZE){RemoveEffect(oPC,eEffects);}eEffects = GetNextEffect(oPC);}
  }
SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);
 }
////////////////////////////////////////////////////////////////////////////////
// final item
else if(iChoice1==2)
 {
iRandom = Random(5)+1;
     if(iRandom==1){sBP = "cr_elhuin";s1 = "This plant is very rare.";s2 = "Like Hashbushin, a lot of benefic power is hold in it.";s3 = "Restoration is its duty.";}
else if(iRandom==2){sBP = "tent002";s1 = "It's made of wood and of bolts of cloth.";s2 = "Sleeping inside is benefic for health.";s3 = "Quite heavy, it can be placed everywhere.";}
else if(iRandom==3){sBP = "cr_silver";s1 = "It's a precious metal.";s2 = "Cheaper than gold, it's used in for jewelry.";s3 = "It can be found in bars.";}
else if(iRandom==4){sBP = "cr_globefire";s1 = "It can be hot when opened.";s2 = "With its round form, it holds much of the fire power.";s3 = "Kill a Balrog and he will drop it.";}
else if(iRandom==5){sBP = "cr_gem015";s1 = "It is precious.";s2 = "With its yellow colour, it reflects the sunshine.";s3 = "It is needed for taking off to other planets.";}

oNew = CreateObject(OBJECT_TYPE_ITEM,"customscroll",Location(oArea,Vector(IntToFloat(Random(FloatToInt(fAreaX)))+(fAreaX/2.0),IntToFloat(Random(FloatToInt(fAreaY))),0.0),0.0));SetLocalInt(oNew,"DontSave",1);SetPlotFlag(oNew,TRUE);SetLocalString(oNew,"Var",s1+"_A_");
oNew = CreateObject(OBJECT_TYPE_ITEM,"customscroll",Location(oArea,Vector(IntToFloat(Random(FloatToInt(fAreaX)))+(fAreaX/2.0),IntToFloat(Random(FloatToInt(fAreaY))),0.0),0.0));SetLocalInt(oNew,"DontSave",1);SetPlotFlag(oNew,TRUE);SetLocalString(oNew,"Var",s2+"_A_");
oNew = CreateObject(OBJECT_TYPE_ITEM,"customscroll",Location(oArea,Vector(IntToFloat(Random(FloatToInt(fAreaX)))+(fAreaX/2.0),IntToFloat(Random(FloatToInt(fAreaY))),0.0),0.0));SetLocalInt(oNew,"DontSave",1);SetPlotFlag(oNew,TRUE);SetLocalString(oNew,"Var",s3+"_A_");

SetLocalString(OBJECT_SELF,"BP",sBP);
iPrice = 30;TakeGoldFromCreature(iPrice,oPC,TRUE);

SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);
 }
////////////////////////////////////////////////////////////////////////////////
// find planet
else if(iChoice1==3)
 {
string sSystem;string sPlanetName;string sX;string sY;string sZ;int iX;int iY;int iM;int iDist;int iDistNew;string sAnswer;
string sTot = GetPersistentString(oModule,sPlanet);
string sPlanetPlace = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
string sOrigZ = "_";int iOrigM = FindSubString(sPlanetPlace,sOrigZ)+1;
string sOrigX = GetStringLeft(sPlanetPlace,iOrigM-1);
string sOrigY = GetStringRight(sPlanetPlace,GetStringLength(sPlanetPlace)-iOrigM);
int iOrigX = StringToInt(sOrigX);if(GetStringLeft(sOrigX,1)=="m"){iOrigX = -StringToInt(GetStringRight(sOrigX,GetStringLength(sOrigX)-1));}
int iOrigY = StringToInt(sOrigY);if(GetStringLeft(sOrigY,1)=="m"){iOrigY = -StringToInt(GetStringRight(sOrigY,GetStringLength(sOrigY)-1));}

j = StringToInt(GetLocalString(oModule,"Systems"));
while(j>0)
  {
sSystem = GetLocalString(oModule,"System"+IntToString(j));
i = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
while(i>0)
   {
iNum++;
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(i));
sPlanetName = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
sPlanetPlace = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5);

sZ = "_";iM = FindSubString(sPlanetPlace,sZ)+1;
sX = GetStringLeft(sPlanetPlace,iM-1);
sY = GetStringRight(sPlanetPlace,GetStringLength(sPlanetPlace)-iM);
iX = StringToInt(sX);if(GetStringLeft(sX,1)=="m"){iX = -StringToInt(GetStringRight(sX,GetStringLength(sX)-1));}
iY = StringToInt(sY);if(GetStringLeft(sY,1)=="m"){iY = -StringToInt(GetStringRight(sY,GetStringLength(sY)-1));}

if(sPlanetName!=sPlanet)
    {
iX = iOrigX-iX;
iY = iOrigY-iY;
iDistNew = FloatToInt(sqrt((IntToFloat(iX)*IntToFloat(iX))+(IntToFloat(iY)*IntToFloat(iY))));

if((iDist==0)||(iDistNew<iDist)){iDist = iDistNew;sAnswer = sPlanetName;}
    }
i--;
   }
j--;
  }

if(sPos==sAnswer){j = 1;}else{j = 0;}

iPrice = 10;TakeGoldFromCreature(iPrice,oPC,TRUE);
SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);
 }
////////////////////////////////////////////////////////////////////////////////
// fortune wheel
else if(iChoice1==4)
 {
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
iPrice = 20;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
else if(GetLocalInt(OBJECT_SELF,"Round")>=2)
  {
iNum = GetLocalInt(OBJECT_SELF,"Wins");

iRandom = Random(GetAbilityScore(oPC,ABILITY_STRENGTH)/iChoice2)+3;
i = iRandom+GetLocalInt(OBJECT_SELF,"Success");if(i>12){i = i-12;}

     if(i==1){iNum = iNum+100;}
else if(i==2){iNum = iNum+50;}
else if(i==3){iNum = iNum+20;}
else if(i==4){iNum = iNum+10;}
else if(i==5){iNum = iNum+5;}
else if(i==6){iNum = iNum-5;}
else if(i==7){iNum = iNum-10;}
else if(i==8){iNum = iNum-20;}
else if(i==9){iNum = iNum-30;}
else if(i==10){iNum = iNum-50;}
else if(i==11){iNum = iNum*2;}
else if(i==12){iNum = 0;}

SetLocalInt(OBJECT_SELF,"Wins",iNum);
FloatingTextStringOnCreature("strength : "+IntToString(iRandom)+" = frame "+IntToString(i),oPC);
SendMessageToPC(oPC,"Your actual stand : "+IntToString(iNum)+" GP.");

SetLocalInt(OBJECT_SELF,"Success",i);
SetLocalInt(OBJECT_SELF,"Step",GetLocalInt(OBJECT_SELF,"Step")-1);

oNew = GetNearestObjectByTag("CODIFortWheel");if(GetLocalInt(oNew,"Active")==1){DeleteLocalInt(oNew,"Active");AssignCommand(oNew,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));}else{SetLocalInt(oNew,"Active",1);AssignCommand(oNew,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));}
  }
SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);DelayCommand(0.2,SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round"))));
 }
////////////////////////////////////////////////////////////////////////////////
// 3 questions
else if(iChoice1==5)
 {
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
sResult = "what is your name";
iPrice = 10;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
else if(GetLocalInt(OBJECT_SELF,"Round")==1)
  {
sResult = "what is your level";
if(sPos==GetName(oPC)){j = -1;}else{j = 0;}
  }
else if(GetLocalInt(OBJECT_SELF,"Round")==2)
  {
iRandom = Random(5)+1;
     if(iRandom==1){sResult = "what is the name of my grand-uncle";}
else if(iRandom==2){sResult = "what is the capital of Belunga";}
else if(iRandom==3){sResult = "what is the name of my father";}
else if(iRandom==4){sResult = "what is my age";}
else if(iRandom==5){sResult = "what is your favourite color";}
SetLocalInt(OBJECT_SELF,"Wins",iRandom);
if(StringToInt(sPos)==iLevel){j = -1;}else{j = 0;}
  }
else if(GetLocalInt(OBJECT_SELF,"Round")==3)
  {
iRandom = GetLocalInt(OBJECT_SELF,"Wins");
     if(iRandom==1){sResult = "Archibald";}
else if(iRandom==2){sResult = "Tarnta";}
else if(iRandom==3){sResult = "Bob";}
else if(iRandom==4){sResult = "43";}

if((sPos==sResult)||(iRandom==5)){j = 1;}else{j = 0;}
  }

SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round")));SetCustomToken(10177,sResult);
 }
////////////////////////////////////////////////////////////////////////////////
// feed horses
else if(iChoice1==6)
 {
while((GetIsObjectValid(oItems))&&(i<=4)){if(GetTag(oItems)=="cr_plantcommon"){i++;DestroyObject(oItems);}oItems = GetNextItemInInventory(oPC);}

GiveGoldToCreature(oPC,20);
int n;int iXP = 5;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
GiveXPToCreature(oPC,iXP);
 }
////////////////////////////////////////////////////////////////////////////////
// well
else if(iChoice1==7)
 {
SetLocalString(oModule,sPlanet+sArea+"Game7PC",GetName(oPC));

iPrice = 40;TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// find item
else if(iChoice1==8)
 {
oNew = CreateObject(OBJECT_TYPE_ITEM,"nw_ashlw001",Location(oArea,Vector(IntToFloat(Random(FloatToInt(fAreaX)))+(fAreaX/2.0),IntToFloat(Random(FloatToInt(fAreaY))),0.0),0.0),FALSE,"lostshield");SetLocalInt(oNew,"DontSave",1);
SetLocalInt(OBJECT_SELF,"Round",1);
DelayCommand(180.0,SetLocalInt(OBJECT_SELF,"Round",2));

iPrice = 20;TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// dice 1
else if(iChoice1==9)
 {
iRandom = Random(6)+1;
if(StringToInt(sPos)==iRandom){j = 1;}
sResult = "hit dice = "+IntToString(iRandom);
iPrice = 3;TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// dice 2
else if(iChoice1==10)
 {
iRandom = Random(10)+1;
if(StringToInt(sPos)==iRandom){j = 1;}
sResult = "hit dice = "+IntToString(iRandom);
iPrice = 6;TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// dice 3
else if(iChoice1==11)
 {
while(i<3)
  {
i++;
iRandom = Random(6)+1;
if(StringToInt(sPos)==iRandom){j++;}sResult = sResult+" "+IntToString(iRandom);
  }
sResult = "dices = "+sResult;
iPrice = 10;TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// dice 4
else if(iChoice1==12)
 {
while(i<4)
  {
i++;
iRandom = iRandom+Random(20)+1;
  }
     if(StringToInt(sPos)==iRandom){j=3;}
else if((StringToInt(sPos)>=(iRandom-5))&&(StringToInt(sPos)<=(iRandom+5))){j=2;}
else if((StringToInt(sPos)>=(iRandom-10))&&(StringToInt(sPos)<=(iRandom+10))){j=1;}
sResult = "hit dice = "+IntToString(iRandom);
iPrice = 10;TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// dice 5
else if(iChoice1==13)
 {
iRandom = 1;
while(i<3)
  {
i++;
iRandom = iRandom*(Random(10)+1);
  }
     if(StringToInt(sPos)==iRandom){j=3;}
else if((StringToInt(sPos)>=(iRandom-20))&&(StringToInt(sPos)<=(iRandom+20))){j=2;}
else if((StringToInt(sPos)>=(iRandom-50))&&(StringToInt(sPos)<=(iRandom+50))){j=1;}
sResult = "hit dice = "+IntToString(iRandom);
iPrice = 10;TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// card 1
else if(iChoice1==14)
 {
// Game preparation
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
SetLocalInt(OBJECT_SELF,"GP",StringToInt(sPos));

i=0;while(i<10){i++;iRandom = Random(15)+1;if(iRandom<6) {oNew = CreateItemOnObject("card001",oPC);}else if(iRandom<10){oNew = CreateItemOnObject("card002",oPC);}else if(iRandom<13){oNew = CreateItemOnObject("card003",oPC);}else if(iRandom<15){oNew = CreateItemOnObject("card004",oPC);}else{oNew = CreateItemOnObject("card005",oPC);}}
DeleteLocalInt(OBJECT_SELF,"Cards1");DeleteLocalInt(OBJECT_SELF,"Cards2");DeleteLocalInt(OBJECT_SELF,"Cards3");DeleteLocalInt(OBJECT_SELF,"Cards4");DeleteLocalInt(OBJECT_SELF,"Cards5");
i=0;while(i<10){i++;iRandom = Random(15)+1;if(iRandom<6){SetLocalInt(OBJECT_SELF,"Cards1",GetLocalInt(OBJECT_SELF,"Cards1")+1);}else if(iRandom<10){SetLocalInt(OBJECT_SELF,"Cards2",GetLocalInt(OBJECT_SELF,"Cards2")+1);}else if(iRandom<13){SetLocalInt(OBJECT_SELF,"Cards3",GetLocalInt(OBJECT_SELF,"Cards3")+1);}else if(iRandom<15){SetLocalInt(OBJECT_SELF,"Cards4",GetLocalInt(OBJECT_SELF,"Cards4")+1);}else{SetLocalInt(OBJECT_SELF,"Cards5",GetLocalInt(OBJECT_SELF,"Cards5")+1);}}

SetLocalInt(OBJECT_SELF,"Round",1000);DelayCommand(0.2,SetCustomToken(10176,IntToString(1)));
iPrice = 10;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
// Game running
else
  {
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetTag(oItems)=="card001"){iCard1++;}else if(GetTag(oItems)=="card002"){iCard2++;}else if(GetTag(oItems)=="card003"){iCard3++;}else if(GetTag(oItems)=="card004"){iCard4++;}else if(GetTag(oItems)=="card005"){iCard5++;}oItems = GetNextItemInInventory(oPC);}if(iChoice2==1){iCard1--;}else if(iChoice2==2){iCard2--;}else if(iChoice2==3){iCard3--;}else if(iChoice2==4){iCard4--;}else if(iChoice2==5){iCard5--;}if(iCard1>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);}if(iCard2>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);}if(iCard3>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);}if(iCard4>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone4",1);}if(iCard5>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}
// First round
if(GetLocalInt(OBJECT_SELF,"Round")==1000)
   {
SetLocalInt(OBJECT_SELF,"Round",1);DelayCommand(0.2,SetCustomToken(10176,IntToString(2)));
   }
// Other rounds
else if(GetLocalInt(OBJECT_SELF,"Round")<=10)
   {
// PC play card
DestroyObject(GetItemPossessedBy(oPC,"card00"+IntToString(iChoice2)));
if(iChoice2==1){s1 = "goblin";}else if(iChoice2==2){s1 = "ogre";}else if(iChoice2==3){s1 = "elemental";}else if(iChoice2==4){s1 = "lich";}else if(iChoice2==5){s1 = "dragon";}
// NPC play card
while(iChoice==0){iRandom = Random(5)+1;if(GetLocalInt(OBJECT_SELF,"Cards"+IntToString(iRandom))>0){iChoice = iRandom;}}
SetLocalInt(OBJECT_SELF,"Cards"+IntToString(iChoice),GetLocalInt(OBJECT_SELF,"Cards"+IntToString(iChoice))-1);
if(iChoice==1){s2 = "goblin";}else if(iChoice==2){s2 = "ogre";}else if(iChoice==3){s2 = "elemental";}else if(iChoice==4){s2 = "lich";}else if(iChoice==5){s2 = "dragon";}

     if(iChoice2>iChoice){SetLocalInt(OBJECT_SELF,"Wins",GetLocalInt(OBJECT_SELF,"Wins")+1);sResult = s1+" vs "+s2+" = you win";}
else if(iChoice2<iChoice){SetLocalInt(OBJECT_SELF,"Losts",GetLocalInt(OBJECT_SELF,"Losts")+1);sResult = s1+" vs "+s2+" = I win";}
else{sResult = s1+" vs "+s2+" = a draw";}

SpeakString(sResult);
SendMessageToPC(oPC,"Wins = "+IntToString(GetLocalInt(OBJECT_SELF,"Wins"))+", Losts = "+IntToString(GetLocalInt(OBJECT_SELF,"Losts"))+".");

SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);DelayCommand(0.2,SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round")+1)));
SetLocalInt(OBJECT_SELF,"Step",GetLocalInt(OBJECT_SELF,"Step")-1);
   }
// Last round
else
   {
if(GetLocalInt(OBJECT_SELF,"Wins")>GetLocalInt(OBJECT_SELF,"Losts")){j = 1;}
else if(GetLocalInt(OBJECT_SELF,"Wins")<GetLocalInt(OBJECT_SELF,"Losts")){j = 0;}
else{j = -1;}
sResult = IntToString(GetLocalInt(OBJECT_SELF,"Wins"))+" wins vs "+IntToString(GetLocalInt(OBJECT_SELF,"Losts"))+" losts";
   }
  }
DeleteLocalInt(OBJECT_SELF,"Choice2");
 }
////////////////////////////////////////////////////////////////////////////////
// card 2
else if(iChoice1==15)
 {
// Game preparation
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
SetLocalInt(OBJECT_SELF,"GP",StringToInt(sPos));

i=0;while(i<5){i++;iRandom = Random(5)+1;oNew = CreateItemOnObject("card00"+IntToString(iRandom),oPC);}
DeleteLocalInt(OBJECT_SELF,"Cards1");DeleteLocalInt(OBJECT_SELF,"Cards2");DeleteLocalInt(OBJECT_SELF,"Cards3");DeleteLocalInt(OBJECT_SELF,"Cards4");DeleteLocalInt(OBJECT_SELF,"Cards5");
i=0;while(i<5){i++;iRandom = Random(5)+1;SetLocalInt(OBJECT_SELF,"Cards"+IntToString(i),iRandom);}

SetLocalInt(OBJECT_SELF,"Round",1000);DelayCommand(0.2,SetCustomToken(10176,IntToString(1)));
iPrice = 20;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
// Game running
else
  {
// First round
if(GetLocalInt(OBJECT_SELF,"Round")==1000)
   {
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetTag(oItems)=="card001"){iCard1++;}else if(GetTag(oItems)=="card002"){iCard2++;}else if(GetTag(oItems)=="card003"){iCard3++;}else if(GetTag(oItems)=="card004"){iCard4++;}else if(GetTag(oItems)=="card005"){iCard5++;}oItems = GetNextItemInInventory(oPC);}if(iCard1>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);}if(iCard2>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);}if(iCard3>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);}if(iCard4>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone4",1);}if(iCard5>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}
SetLocalInt(OBJECT_SELF,"Round",1);DelayCommand(0.2,SetCustomToken(10176,IntToString(2)));
   }
// Other rounds
else if(GetLocalInt(OBJECT_SELF,"Round")<=3)
   {
// PC change card
if(iChoice2!=0){DestroyObject(GetItemPossessedBy(oPC,"card00"+IntToString(iChoice2)));iRandom = Random(5)+1;CreateItemOnObject("card00"+IntToString(iRandom),oPC);}
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetTag(oItems)=="card001"){iCard1++;}else if(GetTag(oItems)=="card002"){iCard2++;}else if(GetTag(oItems)=="card003"){iCard3++;}else if(GetTag(oItems)=="card004"){iCard4++;}else if(GetTag(oItems)=="card005"){iCard5++;}oItems = GetNextItemInInventory(oPC);}if(iChoice2==1){iCard1--;}else if(iChoice2==2){iCard2--;}else if(iChoice2==3){iCard3--;}else if(iChoice2==4){iCard4--;}else if(iChoice2==5){iCard5--;}if(iCard1>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);}if(iCard2>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);}if(iCard3>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);}if(iCard4>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone4",1);}if(iCard5>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}
// NPC change card
iCard1 = GetLocalInt(OBJECT_SELF,"Cards1");iCard2 = GetLocalInt(OBJECT_SELF,"Cards2");iCard3 = GetLocalInt(OBJECT_SELF,"Cards3");iCard4 = GetLocalInt(OBJECT_SELF,"Cards4");iCard5 = GetLocalInt(OBJECT_SELF,"Cards5");
iRandom = Random(5)+1;

     if((iCard1!=iCard2)&&(iCard1!=iCard3)&&(iCard1!=iCard4)&&(iCard1!=iCard5)){SetLocalInt(OBJECT_SELF,"Cards1",iRandom);sResult = "I change one card";}
else if((iCard2!=iCard1)&&(iCard2!=iCard3)&&(iCard2!=iCard4)&&(iCard2!=iCard5)){SetLocalInt(OBJECT_SELF,"Cards2",iRandom);sResult = "I change one card";}
else if((iCard3!=iCard2)&&(iCard3!=iCard1)&&(iCard3!=iCard4)&&(iCard3!=iCard5)){SetLocalInt(OBJECT_SELF,"Cards3",iRandom);sResult = "I change one card";}
else if((iCard4!=iCard2)&&(iCard4!=iCard3)&&(iCard4!=iCard1)&&(iCard4!=iCard5)){SetLocalInt(OBJECT_SELF,"Cards4",iRandom);sResult = "I change one card";}
else if((iCard5!=iCard2)&&(iCard5!=iCard3)&&(iCard5!=iCard4)&&(iCard5!=iCard1)){SetLocalInt(OBJECT_SELF,"Cards5",iRandom);sResult = "I change one card";}
else{sResult = "I keep my cards";}

SpeakString(sResult);

SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);DelayCommand(0.2,SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round")+1)));
SetLocalInt(OBJECT_SELF,"Step",GetLocalInt(OBJECT_SELF,"Step")-1);
   }
// Last round
else
   {
// PC best combination
iCard1 = 0;iCard2 = 0;iCard3 = 0;iCard4 = 0;iCard5 = 0;
oItems = GetFirstItemInInventory(oPC);
int iPCcountTot = 1;
while(GetIsObjectValid(oItems)){
     if(GetTag(oItems)=="card001"){if(iPCcountTot==1){iCard1 = 1;}else if(iPCcountTot==2){iCard2 = 1;}else if(iPCcountTot==3){iCard3 = 1;}else if(iPCcountTot==4){iCard4 = 1;}else if(iPCcountTot==5){iCard5 = 1;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card002"){if(iPCcountTot==1){iCard1 = 2;}else if(iPCcountTot==2){iCard2 = 2;}else if(iPCcountTot==3){iCard3 = 2;}else if(iPCcountTot==4){iCard4 = 2;}else if(iPCcountTot==5){iCard5 = 2;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card003"){if(iPCcountTot==1){iCard1 = 3;}else if(iPCcountTot==2){iCard2 = 3;}else if(iPCcountTot==3){iCard3 = 3;}else if(iPCcountTot==4){iCard4 = 3;}else if(iPCcountTot==5){iCard5 = 3;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card004"){if(iPCcountTot==1){iCard1 = 4;}else if(iPCcountTot==2){iCard2 = 4;}else if(iPCcountTot==3){iCard3 = 4;}else if(iPCcountTot==4){iCard4 = 4;}else if(iPCcountTot==5){iCard5 = 4;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card005"){if(iPCcountTot==1){iCard1 = 5;}else if(iPCcountTot==2){iCard2 = 5;}else if(iPCcountTot==3){iCard3 = 5;}else if(iPCcountTot==4){iCard4 = 5;}else if(iPCcountTot==5){iCard5 = 5;}iPCcountTot = iPCcountTot+1;}
oItems = GetNextItemInInventory(oPC);}

if((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard1==iCard4)&&(iCard1==iCard5)){i = 7;}
else if(((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard1==iCard4))||((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard1==iCard5))||((iCard1==iCard2)&&(iCard1==iCard4)&&(iCard1==iCard5))||((iCard1==iCard3)&&(iCard1==iCard4)&&(iCard1==iCard5))||((iCard5==iCard2)&&(iCard5==iCard3)&&(iCard5==iCard4))){i = 6;}
else if(((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard4==iCard5))||((iCard1==iCard2)&&(iCard1==iCard4)&&(iCard3==iCard5))||((iCard1==iCard2)&&(iCard1==iCard5)&&(iCard3==iCard4))||((iCard1==iCard3)&&(iCard1==iCard4)&&(iCard2==iCard5))||((iCard1==iCard3)&&(iCard1==iCard5)&&(iCard2==iCard4))||((iCard1==iCard4)&&(iCard1==iCard5)&&(iCard2==iCard3))||((iCard2==iCard3)&&(iCard2==iCard4)&&(iCard1==iCard5))||((iCard2==iCard3)&&(iCard2==iCard5)&&(iCard1==iCard4))||((iCard2==iCard4)&&(iCard2==iCard5)&&(iCard1==iCard3))||((iCard3==iCard4)&&(iCard3==iCard5)&&(iCard1==iCard2))){i = 5;}
else if(((iCard1==iCard2)&&(iCard1==iCard3))||((iCard1==iCard2)&&(iCard1==iCard4))||((iCard1==iCard2)&&(iCard1==iCard5))||((iCard1==iCard3)&&(iCard1==iCard4))||((iCard1==iCard3)&&(iCard1==iCard5))||((iCard1==iCard4)&&(iCard1==iCard5))||((iCard2==iCard3)&&(iCard2==iCard4))||((iCard2==iCard3)&&(iCard2==iCard5))||((iCard2==iCard4)&&(iCard2==iCard5))||((iCard3==iCard4)&&(iCard3==iCard5))){i = 4;}
else if(((iCard1==iCard2)&&(iCard3==iCard4))||((iCard1==iCard2)&&(iCard3==iCard5))||((iCard1==iCard2)&&(iCard4==iCard5))||((iCard1==iCard3)&&(iCard2==iCard4))||((iCard1==iCard3)&&(iCard2==iCard5))||((iCard1==iCard3)&&(iCard4==iCard5))||((iCard1==iCard4)&&(iCard2==iCard3))||((iCard1==iCard4)&&(iCard2==iCard5))||((iCard1==iCard4)&&(iCard3==iCard5))||((iCard1==iCard5)&&(iCard2==iCard3))||((iCard1==iCard5)&&(iCard2==iCard4))||((iCard1==iCard5)&&(iCard3==iCard4))||((iCard2==iCard3)&&(iCard1==iCard4))||((iCard2==iCard3)&&(iCard1==iCard5))||((iCard2==iCard3)&&(iCard4==iCard5))||((iCard2==iCard4)&&(iCard1==iCard3))||((iCard2==iCard4)&&(iCard1==iCard5))||((iCard2==iCard4)&&(iCard3==iCard5))||((iCard2==iCard5)&&(iCard1==iCard3))||((iCard2==iCard5)&&(iCard1==iCard4))||((iCard2==iCard5)&&(iCard3==iCard4))||((iCard3==iCard4)&&(iCard1==iCard2))||((iCard3==iCard4)&&(iCard1==iCard5))||((iCard3==iCard4)&&(iCard2==iCard5))||((iCard3==iCard5)&&(iCard1==iCard2))||((iCard3==iCard5)&&(iCard1==iCard4))||((iCard3==iCard5)&&(iCard2==iCard4))||((iCard4==iCard5)&&(iCard1==iCard2))||((iCard4==iCard5)&&(iCard1==iCard3))||((iCard4==iCard5)&&(iCard2==iCard3))){i = 3;}
else if((iCard1==iCard2)||(iCard1==iCard3)||(iCard1==iCard4)||(iCard1==iCard5)||(iCard2==iCard3)||(iCard2==iCard4)||(iCard2==iCard5)||(iCard3==iCard4)||(iCard3==iCard5)||(iCard4==iCard5)){i = 2;}
else{i = 1;}

// NPC best combination
iCard1 = GetLocalInt(OBJECT_SELF,"Cards1");iCard2 = GetLocalInt(OBJECT_SELF,"Cards2");iCard3 = GetLocalInt(OBJECT_SELF,"Cards3");iCard4 = GetLocalInt(OBJECT_SELF,"Cards4");iCard5 = GetLocalInt(OBJECT_SELF,"Cards5");

if((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard1==iCard4)&&(iCard1==iCard5)){j = 7;}
else if(((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard1==iCard4))||((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard1==iCard5))||((iCard1==iCard2)&&(iCard1==iCard4)&&(iCard1==iCard5))||((iCard1==iCard3)&&(iCard1==iCard4)&&(iCard1==iCard5))||((iCard5==iCard2)&&(iCard5==iCard3)&&(iCard5==iCard4))){j = 6;}
else if(((iCard1==iCard2)&&(iCard1==iCard3)&&(iCard4==iCard5))||((iCard1==iCard2)&&(iCard1==iCard4)&&(iCard3==iCard5))||((iCard1==iCard2)&&(iCard1==iCard5)&&(iCard3==iCard4))||((iCard1==iCard3)&&(iCard1==iCard4)&&(iCard2==iCard5))||((iCard1==iCard3)&&(iCard1==iCard5)&&(iCard2==iCard4))||((iCard1==iCard4)&&(iCard1==iCard5)&&(iCard2==iCard3))||((iCard2==iCard3)&&(iCard2==iCard4)&&(iCard1==iCard5))||((iCard2==iCard3)&&(iCard2==iCard5)&&(iCard1==iCard4))||((iCard2==iCard4)&&(iCard2==iCard5)&&(iCard1==iCard3))||((iCard3==iCard4)&&(iCard3==iCard5)&&(iCard1==iCard2))){j = 5;}
else if(((iCard1==iCard2)&&(iCard1==iCard3))||((iCard1==iCard2)&&(iCard1==iCard4))||((iCard1==iCard2)&&(iCard1==iCard5))||((iCard1==iCard3)&&(iCard1==iCard4))||((iCard1==iCard3)&&(iCard1==iCard5))||((iCard1==iCard4)&&(iCard1==iCard5))||((iCard2==iCard3)&&(iCard2==iCard4))||((iCard2==iCard3)&&(iCard2==iCard5))||((iCard2==iCard4)&&(iCard2==iCard5))||((iCard3==iCard4)&&(iCard3==iCard5))){j = 4;}
else if(((iCard1==iCard2)&&(iCard3==iCard4))||((iCard1==iCard2)&&(iCard3==iCard5))||((iCard1==iCard2)&&(iCard4==iCard5))||((iCard1==iCard3)&&(iCard2==iCard4))||((iCard1==iCard3)&&(iCard2==iCard5))||((iCard1==iCard3)&&(iCard4==iCard5))||((iCard1==iCard4)&&(iCard2==iCard3))||((iCard1==iCard4)&&(iCard2==iCard5))||((iCard1==iCard4)&&(iCard3==iCard5))||((iCard1==iCard5)&&(iCard2==iCard3))||((iCard1==iCard5)&&(iCard2==iCard4))||((iCard1==iCard5)&&(iCard3==iCard4))||((iCard2==iCard3)&&(iCard1==iCard4))||((iCard2==iCard3)&&(iCard1==iCard5))||((iCard2==iCard3)&&(iCard4==iCard5))||((iCard2==iCard4)&&(iCard1==iCard3))||((iCard2==iCard4)&&(iCard1==iCard5))||((iCard2==iCard4)&&(iCard3==iCard5))||((iCard2==iCard5)&&(iCard1==iCard3))||((iCard2==iCard5)&&(iCard1==iCard4))||((iCard2==iCard5)&&(iCard3==iCard4))||((iCard3==iCard4)&&(iCard1==iCard2))||((iCard3==iCard4)&&(iCard1==iCard5))||((iCard3==iCard4)&&(iCard2==iCard5))||((iCard3==iCard5)&&(iCard1==iCard2))||((iCard3==iCard5)&&(iCard1==iCard4))||((iCard3==iCard5)&&(iCard2==iCard4))||((iCard4==iCard5)&&(iCard1==iCard2))||((iCard4==iCard5)&&(iCard1==iCard3))||((iCard4==iCard5)&&(iCard2==iCard3))){j = 3;}
else if((iCard1==iCard2)||(iCard1==iCard3)||(iCard1==iCard4)||(iCard1==iCard5)||(iCard2==iCard3)||(iCard2==iCard4)||(iCard2==iCard5)||(iCard3==iCard4)||(iCard3==iCard5)||(iCard4==iCard5)){j = 2;}
else{j = 1;}

     if(i==1){sResult = "You have nothing ";}
else if(i==2){sResult = "You have a pair ";}
else if(i==3){sResult = "You have two pairs ";}
else if(i==4){sResult = "You have a brelan ";}
else if(i==5){sResult = "You have a full ";}
else if(i==6){sResult = "You have a quartet ";}
else if(i==7){sResult = "You have a quintet ";}
     if(j==1){sResult = sResult+"and I have nothing";}
else if(j==2){sResult = sResult+"and I have a pair";}
else if(j==3){sResult = sResult+"and I have two pairs";}
else if(j==4){sResult = sResult+"and I have a brelan";}
else if(j==5){sResult = sResult+"and I have a full";}
else if(j==6){sResult = sResult+"and I have a quartet";}
else if(j==7){sResult = sResult+"and I have a quintet";}

if(i>j){j = 1;}else if(i<j){j = 0;}else{j = -1;}
   }
  }
DeleteLocalInt(OBJECT_SELF,"Choice2");
 }
////////////////////////////////////////////////////////////////////////////////
// card 3
else if(iChoice1==16)
 {
// Game preparation
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
SetLocalInt(OBJECT_SELF,"GP",StringToInt(sPos));

i=0;while(i<5){i++;iRandom = Random(5)+1;oNew = CreateItemOnObject("card00"+IntToString(iRandom),oPC);}
DeleteLocalInt(OBJECT_SELF,"Cards1");DeleteLocalInt(OBJECT_SELF,"Cards2");DeleteLocalInt(OBJECT_SELF,"Cards3");DeleteLocalInt(OBJECT_SELF,"Cards4");DeleteLocalInt(OBJECT_SELF,"Cards5");
i=0;while(i<5){i++;iRandom = Random(5)+1;SetLocalInt(OBJECT_SELF,"Cards"+IntToString(i),iRandom);}

SetLocalInt(OBJECT_SELF,"Round",1000);DelayCommand(0.2,SetCustomToken(10176,IntToString(1)));
iPrice = 15;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
// Game running
else
  {
// First round
if(GetLocalInt(OBJECT_SELF,"Round")==1000)
   {
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetTag(oItems)=="card001"){iCard1++;}else if(GetTag(oItems)=="card002"){iCard2++;}else if(GetTag(oItems)=="card003"){iCard3++;}else if(GetTag(oItems)=="card004"){iCard4++;}else if(GetTag(oItems)=="card005"){iCard5++;}oItems = GetNextItemInInventory(oPC);}if(iCard1>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);}if(iCard2>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);}if(iCard3>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);}if(iCard4>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone4",1);}if(iCard5>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}
SetLocalInt(OBJECT_SELF,"Round",1);DelayCommand(0.2,SetCustomToken(10176,IntToString(2)));
   }
// Other rounds
else if(GetLocalInt(OBJECT_SELF,"Round")<=3)
   {
// PC change card
if(iChoice2!=0){DestroyObject(GetItemPossessedBy(oPC,"card00"+IntToString(iChoice2)));CreateItemOnObject("card00"+IntToString(Random(5)+1),oPC);}
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetTag(oItems)=="card001"){iCard1++;}else if(GetTag(oItems)=="card002"){iCard2++;}else if(GetTag(oItems)=="card003"){iCard3++;}else if(GetTag(oItems)=="card004"){iCard4++;}else if(GetTag(oItems)=="card005"){iCard5++;}oItems = GetNextItemInInventory(oPC);}if(iChoice2==1){iCard1--;}else if(iChoice2==2){iCard2--;}else if(iChoice2==3){iCard3--;}else if(iChoice2==4){iCard4--;}else if(iChoice2==5){iCard5--;}if(iCard1>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);}if(iCard2>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);}if(iCard3>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);}if(iCard4>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone4",1);}if(iCard5>0){DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}
// NPC change card
iCard1 = GetLocalInt(OBJECT_SELF,"Cards1");iCard2 = GetLocalInt(OBJECT_SELF,"Cards2");iCard3 = GetLocalInt(OBJECT_SELF,"Cards3");iCard4 = GetLocalInt(OBJECT_SELF,"Cards4");iCard5 = GetLocalInt(OBJECT_SELF,"Cards5");
iRandom = Random(5)+1;

     if((iCard1==iCard2)||(iCard1==iCard3)||(iCard1==iCard4)||(iCard1==iCard5)){SetLocalInt(OBJECT_SELF,"Cards1",iRandom);sResult = "I change one card";}
else if((iCard2==iCard1)||(iCard2==iCard3)||(iCard2==iCard4)||(iCard2==iCard5)){SetLocalInt(OBJECT_SELF,"Cards2",iRandom);sResult = "I change one card";}
else if((iCard3==iCard2)||(iCard3==iCard1)||(iCard3==iCard4)||(iCard3==iCard5)){SetLocalInt(OBJECT_SELF,"Cards3",iRandom);sResult = "I change one card";}
else if((iCard4==iCard2)||(iCard4==iCard3)||(iCard4==iCard1)||(iCard4==iCard5)){SetLocalInt(OBJECT_SELF,"Cards4",iRandom);sResult = "I change one card";}
else if((iCard5==iCard2)||(iCard5==iCard3)||(iCard5==iCard4)||(iCard5==iCard1)){SetLocalInt(OBJECT_SELF,"Cards5",iRandom);sResult = "I change one card";}
else{sResult = "I keep my cards";}

SpeakString(sResult);

SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);DelayCommand(0.2,SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round")+1)));
SetLocalInt(OBJECT_SELF,"Step",GetLocalInt(OBJECT_SELF,"Step")-1);
   }
// Last round
else
   {
// PC best combination
iCard1 = 0;iCard2 = 0;iCard3 = 0;iCard4 = 0;iCard5 = 0;
oItems = GetFirstItemInInventory(oPC);
int iPCcountTot = 1;
while(GetIsObjectValid(oItems)){
     if(GetTag(oItems)=="card001"){if(iPCcountTot==1){iCard1 = 1;}else if(iPCcountTot==2){iCard2 = 1;}else if(iPCcountTot==3){iCard3 = 1;}else if(iPCcountTot==4){iCard4 = 1;}else if(iPCcountTot==5){iCard5 = 1;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card002"){if(iPCcountTot==1){iCard1 = 2;}else if(iPCcountTot==2){iCard2 = 2;}else if(iPCcountTot==3){iCard3 = 2;}else if(iPCcountTot==4){iCard4 = 2;}else if(iPCcountTot==5){iCard5 = 2;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card003"){if(iPCcountTot==1){iCard1 = 3;}else if(iPCcountTot==2){iCard2 = 3;}else if(iPCcountTot==3){iCard3 = 3;}else if(iPCcountTot==4){iCard4 = 3;}else if(iPCcountTot==5){iCard5 = 3;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card004"){if(iPCcountTot==1){iCard1 = 4;}else if(iPCcountTot==2){iCard2 = 4;}else if(iPCcountTot==3){iCard3 = 4;}else if(iPCcountTot==4){iCard4 = 4;}else if(iPCcountTot==5){iCard5 = 4;}iPCcountTot = iPCcountTot+1;}
else if(GetTag(oItems)=="card005"){if(iPCcountTot==1){iCard1 = 5;}else if(iPCcountTot==2){iCard2 = 5;}else if(iPCcountTot==3){iCard3 = 5;}else if(iPCcountTot==4){iCard4 = 5;}else if(iPCcountTot==5){iCard5 = 5;}iPCcountTot = iPCcountTot+1;}
oItems = GetNextItemInInventory(oPC);}

if(((iCard1!=iCard2)&&(iCard2!=iCard3)&&(iCard3!=iCard4)&&(iCard4!=iCard5))&&(iCard1+iCard2+iCard3+iCard4+iCard5==15)){i = 5;}
else if((((iCard1!=iCard2)&&(iCard1!=iCard3)&&(iCard1!=iCard4)&&(iCard2!=iCard3)&&(iCard2!=iCard4)&&(iCard3!=iCard4))&&((iCard1+iCard2+iCard3+iCard4==10)||(iCard1+iCard2+iCard3+iCard4==14)))||(((iCard1!=iCard2)&&(iCard1!=iCard3)&&(iCard1!=iCard5)&&(iCard2!=iCard3)&&(iCard2!=iCard5)&&(iCard3!=iCard5))&&((iCard1+iCard2+iCard3+iCard5==10)||(iCard1+iCard2+iCard3+iCard5==14)))||(((iCard1!=iCard2)&&(iCard1!=iCard5)&&(iCard1!=iCard4)&&(iCard2!=iCard5)&&(iCard2!=iCard4)&&(iCard5!=iCard4))&&((iCard1+iCard2+iCard5+iCard4==10)||(iCard1+iCard2+iCard5+iCard4==14)))||(((iCard1!=iCard5)&&(iCard1!=iCard3)&&(iCard1!=iCard4)&&(iCard5!=iCard3)&&(iCard5!=iCard4)&&(iCard3!=iCard4))&&((iCard1+iCard5+iCard3+iCard4==10)||(iCard1+iCard5+iCard3+iCard4==14)))||(((iCard5!=iCard2)&&(iCard5!=iCard3)&&(iCard5!=iCard4)&&(iCard2!=iCard3)&&(iCard2!=iCard4)&&(iCard3!=iCard4))&&((iCard5+iCard2+iCard3+iCard4==10)||(iCard5+iCard2+iCard3+iCard4==14)))){i = 4;}
else if((((iCard1!=iCard2)&&(iCard1!=iCard3)&&(iCard2!=iCard3))&&(((iCard1==iCard2+1)||(iCard1==iCard2-1))||((iCard1==iCard3+1)||(iCard1==iCard3-1)))&&((iCard1+iCard2+iCard3==6)||(iCard1+iCard2+iCard3==9)||(iCard1+iCard2+iCard3==12)))||(((iCard1!=iCard2)&&(iCard1!=iCard4)&&(iCard2!=iCard4))&&(((iCard1==iCard2+1)||(iCard1==iCard2-1))||((iCard1==iCard4+1)||(iCard1==iCard4-1)))&&((iCard1+iCard2+iCard4==6)||(iCard1+iCard2+iCard4==9)||(iCard1+iCard2+iCard4==12)))||(((iCard1!=iCard2)&&(iCard1!=iCard5)&&(iCard2!=iCard5))&&(((iCard1==iCard2+1)||(iCard1==iCard2-1))||((iCard1==iCard5+1)||(iCard1==iCard5-1)))&&((iCard1+iCard2+iCard5==6)||(iCard1+iCard2+iCard5==9)||(iCard1+iCard2+iCard5==12)))||(((iCard1!=iCard3)&&(iCard1!=iCard4)&&(iCard3!=iCard4))&&(((iCard1==iCard3+1)||(iCard1==iCard3-1))||((iCard1==iCard4+1)||(iCard1==iCard4-1)))&&((iCard1+iCard3+iCard4==6)||(iCard1+iCard3+iCard4==9)||(iCard1+iCard3+iCard4==12)))||(((iCard1!=iCard3)&&(iCard1!=iCard5)&&(iCard3!=iCard5))&&(((iCard1==iCard3+1)||(iCard1==iCard3-1))||((iCard1==iCard5+1)||(iCard1==iCard5-1)))&&((iCard1+iCard3+iCard5==6)||(iCard1+iCard3+iCard5==9)||(iCard1+iCard3+iCard5==12)))||(((iCard1!=iCard4)&&(iCard1!=iCard5)&&(iCard4!=iCard5))&&(((iCard1==iCard4+1)||(iCard1==iCard4-1))||((iCard1==iCard5+1)||(iCard1==iCard5-1)))&&((iCard1+iCard4+iCard5==6)||(iCard1+iCard4+iCard5==9)||(iCard1+iCard4+iCard5==12)))||(((iCard2!=iCard3)&&(iCard2!=iCard4)&&(iCard3!=iCard4))&&(((iCard2==iCard3+1)||(iCard2==iCard3-1))||((iCard2==iCard4+1)||(iCard2==iCard4-1)))&&((iCard2+iCard3+iCard4==6)||(iCard2+iCard3+iCard4==9)||(iCard2+iCard3+iCard4==12)))||(((iCard2!=iCard3)&&(iCard2!=iCard5)&&(iCard3!=iCard5))&&(((iCard2==iCard3+1)||(iCard2==iCard3-1))||((iCard2==iCard5+1)||(iCard2==iCard5-1)))&&((iCard2+iCard3+iCard5==6)||(iCard2+iCard3+iCard5==9)||(iCard2+iCard3+iCard5==12)))||(((iCard2!=iCard4)&&(iCard2!=iCard5)&&(iCard4!=iCard5))&&(((iCard2==iCard4+1)||(iCard2==iCard4-1))||((iCard2==iCard5+1)||(iCard2==iCard5-1)))&&((iCard2+iCard4+iCard5==6)||(iCard2+iCard4+iCard5==9)||(iCard2+iCard4+iCard5==12)))||(((iCard3!=iCard4)&&(iCard3!=iCard5)&&(iCard4!=iCard5))&&(((iCard3==iCard4+1)||(iCard3==iCard4-1))||((iCard3==iCard5+1)||(iCard3==iCard5-1)))&&((iCard3+iCard4+iCard5==6)||(iCard3+iCard4+iCard5==9)||(iCard3+iCard4+iCard5==12)))){i = 3;}
else if(((iCard1!=iCard2)&&((iCard1+iCard2==3)||(iCard1+iCard2==5)||(iCard1+iCard2==7)||(iCard1+iCard2==9)))||((iCard1!=iCard3)&&((iCard1+iCard3==3)||(iCard1+iCard3==5)||(iCard1+iCard3==7)||(iCard1+iCard3==9)))||((iCard1!=iCard4)&&((iCard1+iCard4==3)||(iCard1+iCard4==5)||(iCard1+iCard4==7)||(iCard1+iCard4==9)))||((iCard1!=iCard5)&&((iCard1+iCard5==3)||(iCard1+iCard5==5)||(iCard1+iCard5==7)||(iCard1+iCard5==9)))||((iCard2!=iCard3)&&((iCard2+iCard3==3)||(iCard2+iCard3==5)||(iCard2+iCard3==7)||(iCard2+iCard3==9)))||((iCard2!=iCard4)&&((iCard2+iCard4==3)||(iCard2+iCard4==5)||(iCard2+iCard4==7)||(iCard2+iCard4==9)))||((iCard2!=iCard5)&&((iCard2+iCard5==3)||(iCard2+iCard5==5)||(iCard2+iCard5==7)||(iCard2+iCard5==9)))||((iCard3!=iCard4)&&((iCard3+iCard4==3)||(iCard3+iCard4==5)||(iCard3+iCard4==7)||(iCard3+iCard4==9)))||((iCard3!=iCard5)&&((iCard3+iCard5==3)||(iCard3+iCard5==5)||(iCard3+iCard5==7)||(iCard3+iCard5==9)))||((iCard4!=iCard5)&&((iCard4+iCard5==3)||(iCard4+iCard5==5)||(iCard4+iCard5==7)||(iCard4+iCard5==9)))){i = 2;}
else{i = 1;}

// NPC best combination
iCard1 = GetLocalInt(OBJECT_SELF,"Cards1");iCard2 = GetLocalInt(OBJECT_SELF,"Cards2");iCard3 = GetLocalInt(OBJECT_SELF,"Cards3");iCard4 = GetLocalInt(OBJECT_SELF,"Cards4");iCard5 = GetLocalInt(OBJECT_SELF,"Cards5");

if(((iCard1!=iCard2)&&(iCard2!=iCard3)&&(iCard3!=iCard4)&&(iCard4!=iCard5))&&(iCard1+iCard2+iCard3+iCard4+iCard5==15)){j = 5;}
else if((((iCard1!=iCard2)&&(iCard1!=iCard3)&&(iCard1!=iCard4)&&(iCard2!=iCard3)&&(iCard2!=iCard4)&&(iCard3!=iCard4))&&((iCard1+iCard2+iCard3+iCard4==10)||(iCard1+iCard2+iCard3+iCard4==14)))||(((iCard1!=iCard2)&&(iCard1!=iCard3)&&(iCard1!=iCard5)&&(iCard2!=iCard3)&&(iCard2!=iCard5)&&(iCard3!=iCard5))&&((iCard1+iCard2+iCard3+iCard5==10)||(iCard1+iCard2+iCard3+iCard5==14)))||(((iCard1!=iCard2)&&(iCard1!=iCard5)&&(iCard1!=iCard4)&&(iCard2!=iCard5)&&(iCard2!=iCard4)&&(iCard5!=iCard4))&&((iCard1+iCard2+iCard5+iCard4==10)||(iCard1+iCard2+iCard5+iCard4==14)))||(((iCard1!=iCard5)&&(iCard1!=iCard3)&&(iCard1!=iCard4)&&(iCard5!=iCard3)&&(iCard5!=iCard4)&&(iCard3!=iCard4))&&((iCard1+iCard5+iCard3+iCard4==10)||(iCard1+iCard5+iCard3+iCard4==14)))||(((iCard5!=iCard2)&&(iCard5!=iCard3)&&(iCard5!=iCard4)&&(iCard2!=iCard3)&&(iCard2!=iCard4)&&(iCard3!=iCard4))&&((iCard5+iCard2+iCard3+iCard4==10)||(iCard5+iCard2+iCard3+iCard4==14)))){j = 4;}
else if((((iCard1!=iCard2)&&(iCard1!=iCard3)&&(iCard2!=iCard3))&&(((iCard1==iCard2+1)||(iCard1==iCard2-1))||((iCard1==iCard3+1)||(iCard1==iCard3-1)))&&((iCard1+iCard2+iCard3==6)||(iCard1+iCard2+iCard3==9)||(iCard1+iCard2+iCard3==12)))||(((iCard1!=iCard2)&&(iCard1!=iCard4)&&(iCard2!=iCard4))&&(((iCard1==iCard2+1)||(iCard1==iCard2-1))||((iCard1==iCard4+1)||(iCard1==iCard4-1)))&&((iCard1+iCard2+iCard4==6)||(iCard1+iCard2+iCard4==9)||(iCard1+iCard2+iCard4==12)))||(((iCard1!=iCard2)&&(iCard1!=iCard5)&&(iCard2!=iCard5))&&(((iCard1==iCard2+1)||(iCard1==iCard2-1))||((iCard1==iCard5+1)||(iCard1==iCard5-1)))&&((iCard1+iCard2+iCard5==6)||(iCard1+iCard2+iCard5==9)||(iCard1+iCard2+iCard5==12)))||(((iCard1!=iCard3)&&(iCard1!=iCard4)&&(iCard3!=iCard4))&&(((iCard1==iCard3+1)||(iCard1==iCard3-1))||((iCard1==iCard4+1)||(iCard1==iCard4-1)))&&((iCard1+iCard3+iCard4==6)||(iCard1+iCard3+iCard4==9)||(iCard1+iCard3+iCard4==12)))||(((iCard1!=iCard3)&&(iCard1!=iCard5)&&(iCard3!=iCard5))&&(((iCard1==iCard3+1)||(iCard1==iCard3-1))||((iCard1==iCard5+1)||(iCard1==iCard5-1)))&&((iCard1+iCard3+iCard5==6)||(iCard1+iCard3+iCard5==9)||(iCard1+iCard3+iCard5==12)))||(((iCard1!=iCard4)&&(iCard1!=iCard5)&&(iCard4!=iCard5))&&(((iCard1==iCard4+1)||(iCard1==iCard4-1))||((iCard1==iCard5+1)||(iCard1==iCard5-1)))&&((iCard1+iCard4+iCard5==6)||(iCard1+iCard4+iCard5==9)||(iCard1+iCard4+iCard5==12)))||(((iCard2!=iCard3)&&(iCard2!=iCard4)&&(iCard3!=iCard4))&&(((iCard2==iCard3+1)||(iCard2==iCard3-1))||((iCard2==iCard4+1)||(iCard2==iCard4-1)))&&((iCard2+iCard3+iCard4==6)||(iCard2+iCard3+iCard4==9)||(iCard2+iCard3+iCard4==12)))||(((iCard2!=iCard3)&&(iCard2!=iCard5)&&(iCard3!=iCard5))&&(((iCard2==iCard3+1)||(iCard2==iCard3-1))||((iCard2==iCard5+1)||(iCard2==iCard5-1)))&&((iCard2+iCard3+iCard5==6)||(iCard2+iCard3+iCard5==9)||(iCard2+iCard3+iCard5==12)))||(((iCard2!=iCard4)&&(iCard2!=iCard5)&&(iCard4!=iCard5))&&(((iCard2==iCard4+1)||(iCard2==iCard4-1))||((iCard2==iCard5+1)||(iCard2==iCard5-1)))&&((iCard2+iCard4+iCard5==6)||(iCard2+iCard4+iCard5==9)||(iCard2+iCard4+iCard5==12)))||(((iCard3!=iCard4)&&(iCard3!=iCard5)&&(iCard4!=iCard5))&&(((iCard3==iCard4+1)||(iCard3==iCard4-1))||((iCard3==iCard5+1)||(iCard3==iCard5-1)))&&((iCard3+iCard4+iCard5==6)||(iCard3+iCard4+iCard5==9)||(iCard3+iCard4+iCard5==12)))){j = 3;}
else if(((iCard1!=iCard2)&&((iCard1+iCard2==3)||(iCard1+iCard2==5)||(iCard1+iCard2==7)||(iCard1+iCard2==9)))||((iCard1!=iCard3)&&((iCard1+iCard3==3)||(iCard1+iCard3==5)||(iCard1+iCard3==7)||(iCard1+iCard3==9)))||((iCard1!=iCard4)&&((iCard1+iCard4==3)||(iCard1+iCard4==5)||(iCard1+iCard4==7)||(iCard1+iCard4==9)))||((iCard1!=iCard5)&&((iCard1+iCard5==3)||(iCard1+iCard5==5)||(iCard1+iCard5==7)||(iCard1+iCard5==9)))||((iCard2!=iCard3)&&((iCard2+iCard3==3)||(iCard2+iCard3==5)||(iCard2+iCard3==7)||(iCard2+iCard3==9)))||((iCard2!=iCard4)&&((iCard2+iCard4==3)||(iCard2+iCard4==5)||(iCard2+iCard4==7)||(iCard2+iCard4==9)))||((iCard2!=iCard5)&&((iCard2+iCard5==3)||(iCard2+iCard5==5)||(iCard2+iCard5==7)||(iCard2+iCard5==9)))||((iCard3!=iCard4)&&((iCard3+iCard4==3)||(iCard3+iCard4==5)||(iCard3+iCard4==7)||(iCard3+iCard4==9)))||((iCard3!=iCard5)&&((iCard3+iCard5==3)||(iCard3+iCard5==5)||(iCard3+iCard5==7)||(iCard3+iCard5==9)))||((iCard4!=iCard5)&&((iCard4+iCard5==3)||(iCard4+iCard5==5)||(iCard4+iCard5==7)||(iCard4+iCard5==9)))){j = 2;}
else{j = 1;}

     if(i==1){sResult = "You have nothing ";}
else if(i==2){sResult = "You have 2 cards ";}
else if(i==3){sResult = "You have 3 cards ";}
else if(i==4){sResult = "You have 4 cards ";}
else if(i==5){sResult = "You have 5 cards ";}
     if(j==1){sResult = sResult+"and I have nothing";}
else if(j==2){sResult = sResult+"and I have 2 cards";}
else if(j==3){sResult = sResult+"and I have 3 cards";}
else if(j==4){sResult = sResult+"and I have 4 cards";}
else if(j==5){sResult = sResult+"and I have 5 cards";}

if(i>j){j = 1;}else if(i<j){j = 0;}else{j = -1;}
   }
  }
DeleteLocalInt(OBJECT_SELF,"Choice2");
 }
////////////////////////////////////////////////////////////////////////////////
// front 1
else if(iChoice1==17)
 {
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
iPrice = 5;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
SetPlotFlag(OBJECT_SELF,FALSE);

int iDiff = GetLocalInt(OBJECT_SELF,"Diff")+3;SetLocalInt(OBJECT_SELF,"Diff",iDiff);
int iNPC = FortitudeSave(OBJECT_SELF,iDiff,SAVING_THROW_TYPE_POISON);
int iPC = FortitudeSave(oPC,iDiff,SAVING_THROW_TYPE_POISON);

PlayAnimation(ANIMATION_FIREFORGET_DRINK);
AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_DRINK));
SendMessageToPC(oPC,"save = "+IntToString(iPC)+" vs "+IntToString(iDiff));

     if((iNPC==0)&&(iPC==0)){j = -1;sResult = "A draw";DelayCommand(1.0,SpeakString("hips"));DelayCommand(1.0,PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));DelayCommand(1.0,AssignCommand(oPC,SpeakString("hips")));DelayCommand(1.0,AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK)));}
else if((iNPC==0)&&(iPC!=0)){j = 1;sResult = "You win";DelayCommand(1.0,SpeakString("hips"));DelayCommand(1.0,PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));}
else if((iNPC==0)&&(iPC!=0)){j = 0;sResult = "You loose";DelayCommand(1.0,AssignCommand(oPC,SpeakString("hips")));DelayCommand(1.0,AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK)));}
else{j = -2;}

SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round")));
 }
////////////////////////////////////////////////////////////////////////////////
// front 2
else if(iChoice1==18)
 {
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
iPrice = 10;TakeGoldFromCreature(iPrice,oPC,TRUE);
  }
SetPlotFlag(OBJECT_SELF,FALSE);

int iDiff = GetLocalInt(OBJECT_SELF,"Diff")+4;SetLocalInt(OBJECT_SELF,"Diff",iDiff);
int iNPC = FortitudeSave(OBJECT_SELF,iDiff,SAVING_THROW_TYPE_POISON);
int iPC = FortitudeSave(oPC,iDiff,SAVING_THROW_TYPE_POISON);

PlayAnimation(ANIMATION_FIREFORGET_DRINK);
AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_DRINK));
SendMessageToPC(oPC,"save = "+IntToString(iPC)+" vs "+IntToString(iDiff));

     if((iNPC==0)&&(iPC==0)){j = -1;sResult = "A draw";DelayCommand(1.0,SpeakString("bleaaaark"));DelayCommand(1.0,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT));DelayCommand(1.0,AssignCommand(oPC,SpeakString("bleaaaark")));DelayCommand(1.0,AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT)));}
else if((iNPC==0)&&(iPC!=0)){j = 1;sResult = "You win";DelayCommand(1.0,SpeakString("bleaaaark"));DelayCommand(1.0,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT));}
else if((iNPC==0)&&(iPC!=0)){j = 0;sResult = "You loose";DelayCommand(1.0,AssignCommand(oPC,SpeakString("bleaaaark")));DelayCommand(1.0,AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT)));}
else{j = -2;}

SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round")));
 }
////////////////////////////////////////////////////////////////////////////////
// front 3
else if(iChoice1==19)
 {
// Other rounds
if(GetLocalInt(OBJECT_SELF,"Round")<5)
  {
int iPC = Random(GetAbilityScore(oPC,ABILITY_STRENGTH))+1;
int iNPC = Random(GetAbilityScore(OBJECT_SELF,ABILITY_STRENGTH))+1;

PlayAnimation(ANIMATION_FIREFORGET_STEAL);
AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_STEAL));

     if(iPC>iNPC){SetLocalInt(OBJECT_SELF,"Wins",GetLocalInt(OBJECT_SELF,"Wins")+1);sResult = IntToString(iPC)+" vs "+IntToString(iNPC)+" = you win";}
else if(iPC<iNPC){SetLocalInt(OBJECT_SELF,"Losts",GetLocalInt(OBJECT_SELF,"Losts")+1);sResult = IntToString(iPC)+" vs "+IntToString(iNPC)+" = I win";}
else{sResult = IntToString(iPC)+" vs "+IntToString(iNPC)+" = a draw";}

FloatingTextStringOnCreature(sResult,oPC);
  }
// Last round
else
  {
if(GetLocalInt(OBJECT_SELF,"Wins")>GetLocalInt(OBJECT_SELF,"Losts")){j = 1;}
else if(GetLocalInt(OBJECT_SELF,"Wins")<GetLocalInt(OBJECT_SELF,"Losts")){j = 0;}
else{j = -1;}
sResult = IntToString(GetLocalInt(OBJECT_SELF,"Wins"))+" wins vs "+IntToString(GetLocalInt(OBJECT_SELF,"Losts"))+" losts";
  }
SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);SetCustomToken(10176,IntToString(GetLocalInt(OBJECT_SELF,"Round")));
 }
////////////////////////////////////////////////////////////////////////////////
// front 4
else if(iChoice1==20)
 {
if(GetLocalInt(OBJECT_SELF,"Round")==0)
  {
iPrice = 20;TakeGoldFromCreature(iPrice,oPC,TRUE);
ActionRandomWalk();
DelayCommand(2.5,ClearAllActions());
DelayCommand(3.0,PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.0));
DelayCommand(6.0,SpeakString("Go, go, time is running !"));
DelayCommand(6.0,ExecuteScript("mouses",OBJECT_SELF));
SetLocalInt(OBJECT_SELF,"Round",3);
DelayCommand(6.0,SetLocalInt(OBJECT_SELF,"Round",1));
DelayCommand(60.0,SetLocalInt(OBJECT_SELF,"Round",2));
  }
 }
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(OBJECT_SELF,"Win",j);
SetLocalString(OBJECT_SELF,"Result",sResult);
SetLocalInt(oModule,sPlanet+sArea+sX+sY+GetName(oPC)+"Game",1);
SetLocalString(OBJECT_SELF,"PC",GetName(oPC));
////////////////////////////////////////////////////////////////////////////////
// Domains
if(GetStringLeft(sInterests,1)=="D")
 {
object oFlag = GetLocalObject(OBJECT_SELF,"StructureFlag");
iLevel = StringToInt(GetStringRight(GetName(oFlag),1));
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iGain = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");

     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/1));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/2));}
 }
////////////////////////////////////////////////////////////////////////////////
}
