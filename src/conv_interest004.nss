#include "_module"
////////////////////////////////////////////////////////////////////////////////
// Win game
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPos = GetLocalString(OBJECT_SELF,"Word");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int j = GetLocalInt(OBJECT_SELF,"Win");
string sResult = GetLocalString(OBJECT_SELF,"Result");
//
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
//
int iGold;int iXP;int iRandom;
////////////////////////////////////////////////////////////////////////////////
// race
if(GetLocalInt(OBJECT_SELF,"Player")==1)
 {
object oCre = GetNearestObjectByTag("npc_tord");
SetImmortal(oCre,FALSE);SetPlotFlag(oCre,FALSE);AssignCommand(oCre,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oCre);
DestroyObject(GetNearestObjectByTag("dummyL"));
DestroyObject(GetNearestObjectByTag("dummyR"));

iGold = 0;
iRandom = Random(3)+1;
     if(iRandom==1){iGold = 50;}
else if(iRandom==2){CreateItemOnObject("nw_wswgs001",oPC);}
else if(iRandom==3){CreateItemOnObject("cr_gem008",oPC);CreateItemOnObject("cr_gem008",oPC);CreateItemOnObject("cr_gem008",oPC);}
iXP = 20;
 }
////////////////////////////////////////////////////////////////////////////////
// final item
else if(GetLocalInt(OBJECT_SELF,"Player")==2)
 {
CreateItemOnObject(GetLocalString(OBJECT_SELF,"BP"),oPC);
iXP = 30;
 }
////////////////////////////////////////////////////////////////////////////////
// find planet
else if(GetLocalInt(OBJECT_SELF,"Player")==3)
 {
CreateItemOnObject("cr_gem015",oPC);
iXP = 5;
 }
////////////////////////////////////////////////////////////////////////////////
// fortune wheel
else if(GetLocalInt(OBJECT_SELF,"Player")==4)
 {
iGold = GetLocalInt(OBJECT_SELF,"Wins");if(iGold<0){TakeGoldFromCreature(-iGold,oPC,TRUE);iGold = 0;}DeleteLocalInt(OBJECT_SELF,"Wins");
iXP = 25;
 }
////////////////////////////////////////////////////////////////////////////////
// 3 questions
else if(GetLocalInt(OBJECT_SELF,"Player")==5)
 {
CreateItemOnObject("cr_box",oPC);
iXP = 10;
sResult = "";
 }
////////////////////////////////////////////////////////////////////////////////
// well
else if(GetLocalInt(OBJECT_SELF,"Player")==7)
 {
DestroyObject(GetItemPossessedBy(oPC,"lizardhead"));
iGold = 80;
iXP = 10;
 }
////////////////////////////////////////////////////////////////////////////////
// find item
else if(GetLocalInt(OBJECT_SELF,"Player")==8)
 {
DestroyObject(GetItemPossessedBy(oPC,"lostshield"));
iGold = 50;
iXP = 6;
 }
////////////////////////////////////////////////////////////////////////////////
// mouses
else if(GetLocalInt(OBJECT_SELF,"Player")==20)
 {
SetLocalInt(OBJECT_SELF,"Round",2);
iGold = 400/(GetAbilityScore(oPC,ABILITY_DEXTERITY)/2);
iXP = 20;
 }
////////////////////////////////////////////////////////////////////////////////
// dice 1
else if(iChoice1==9)
 {
iGold = 10;
iXP = 2;
 }
////////////////////////////////////////////////////////////////////////////////
// dice 2
else if(iChoice1==10)
 {
iGold = 30;
iXP = 3;
 }
////////////////////////////////////////////////////////////////////////////////
// dice 3
else if(iChoice1==11)
 {
     if(j==1){iGold = 20;}
else if(j==2){iGold = 40;}
else if(j==3){iGold = 80;}
iXP = 4;
 }
////////////////////////////////////////////////////////////////////////////////
// dice 4
else if(iChoice1==12)
 {
     if(j==1){iGold = 20;}
else if(j==2){iGold = 40;}
else if(j==3){iGold = 100;}
iXP = 5;
 }
////////////////////////////////////////////////////////////////////////////////
// dice 5
else if(iChoice1==13)
 {
     if(j==1){iGold = 30;}
else if(j==2){iGold = 100;}
else if(j==3){iGold = 300;}
iXP = 6;
 }
////////////////////////////////////////////////////////////////////////////////
// card 1
else if(iChoice1==14)
 {
iGold = GetLocalInt(OBJECT_SELF,"GP");
iXP = 3;
 }
////////////////////////////////////////////////////////////////////////////////
// card 2
else if(iChoice1==15)
 {
iGold = GetLocalInt(OBJECT_SELF,"GP");
iXP = 5;
 }
////////////////////////////////////////////////////////////////////////////////
// card 3
else if(iChoice1==16)
 {
iGold = GetLocalInt(OBJECT_SELF,"GP");
iXP = 4;
 }
////////////////////////////////////////////////////////////////////////////////
// front 1
else if(iChoice1==17)
 {
iGold = GetLocalInt(OBJECT_SELF,"Diff")*5/3;
iXP = 5;
 }
////////////////////////////////////////////////////////////////////////////////
// front 2
else if(iChoice1==18)
 {
iGold = GetLocalInt(OBJECT_SELF,"Diff")*8/4;
iXP = 6;
 }
////////////////////////////////////////////////////////////////////////////////
// front 3
else if(iChoice1==19)
 {
iGold = 30;
iXP = 5;

PlayAnimation(ANIMATION_LOOPING_DEAD_BACK);
 }
////////////////////////////////////////////////////////////////////////////////
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}

GiveXPToCreature(oPC,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
GiveGoldToCreature(oPC,iGold);
FloatingTextStringOnCreature(sResult,oPC);
DeleteLocalString(OBJECT_SELF,"PC");
DeleteLocalInt(OBJECT_SELF,"GP");
DeleteLocalInt(OBJECT_SELF,"Diff");
DeleteLocalInt(OBJECT_SELF,"Wins");
DeleteLocalInt(OBJECT_SELF,"Round");
DeleteLocalInt(OBJECT_SELF,"Success");
DeleteLocalString(oModule,sPlanet+sArea+"Game7PC");
////////////////////////////////////////////////////////////////////////////////
}

