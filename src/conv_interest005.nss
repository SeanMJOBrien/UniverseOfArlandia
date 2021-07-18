#include "_module"
////////////////////////////////////////////////////////////////////////////////
// Loose game
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPos = GetLocalString(OBJECT_SELF,"Word");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iStep = GetLocalInt(OBJECT_SELF,"Step");
string sResult = GetLocalString(OBJECT_SELF,"Result");
//
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
//
int iGold;
int iXP = 1;
////////////////////////////////////////////////////////////////////////////////
// race
if(GetLocalInt(OBJECT_SELF,"Player")==1)
 {
object oCre = GetNearestObjectByTag("npc_tord");
SetImmortal(oCre,FALSE);SetPlotFlag(oCre,FALSE);AssignCommand(oCre,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oCre);
DestroyObject(GetNearestObjectByTag("dummyL"));
DestroyObject(GetNearestObjectByTag("dummyR"));

iXP = 5;
 }
////////////////////////////////////////////////////////////////////////////////
// final item
else if(GetLocalInt(OBJECT_SELF,"Player")==2)
 {
iXP = 5;
 }
////////////////////////////////////////////////////////////////////////////////
// 3 questions
else if(GetLocalInt(OBJECT_SELF,"Player")==5)
 {
AssignCommand(oPC,ClearAllActions());
AssignCommand(oPC,SpeakString("Aaaaaaaaahh"));
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDisappear(),oPC);
iXP = 2;
sResult = "";
 }
////////////////////////////////////////////////////////////////////////////////
// well
else if(GetLocalInt(OBJECT_SELF,"Player")==7)
 {
DestroyObject(GetItemPossessedBy(oPC,"lizardhead"));
iXP = 2;
 }
////////////////////////////////////////////////////////////////////////////////
// find item
else if(GetLocalInt(OBJECT_SELF,"Player")==8)
 {
DestroyObject(GetItemPossessedBy(oPC,"lostshield"));
iXP = 2;
 }
////////////////////////////////////////////////////////////////////////////////
// card 1
else if(iChoice1==14)
 {
iGold = GetLocalInt(OBJECT_SELF,"GP");
TakeGoldFromCreature(iGold,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// card 2
else if(iChoice1==15)
 {
iGold = GetLocalInt(OBJECT_SELF,"GP");
TakeGoldFromCreature(iGold,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// card 3
else if(iChoice1==16)
 {
iGold = GetLocalInt(OBJECT_SELF,"GP");
TakeGoldFromCreature(iGold,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// front 1
else if(iChoice1==17)
 {
iGold = GetLocalInt(OBJECT_SELF,"Diff")*5/3;
TakeGoldFromCreature(iGold,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// front 2
else if(iChoice1==18)
 {
iGold = GetLocalInt(OBJECT_SELF,"Diff")*8/4;
TakeGoldFromCreature(iGold,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// front 3
else if(iChoice1==19)
 {
iGold = 30;
TakeGoldFromCreature(iGold,oPC,TRUE);
AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_DEAD_BACK));
 }
////////////////////////////////////////////////////////////////////////////////
// front 4
else if(iChoice1==20)
 {
iXP = 5;
 }
////////////////////////////////////////////////////////////////////////////////
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}

GiveXPToCreature(oPC,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
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
