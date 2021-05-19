#include "_module"
////////////////////////////////////////////////////////////////////////////////
// Draw game
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPos = GetLocalString(OBJECT_SELF,"Word");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iStep = GetLocalInt(OBJECT_SELF,"Step");
string sResult = GetLocalString(OBJECT_SELF,"Result");
//
int iGold;int iXP;
////////////////////////////////////////////////////////////////////////////////
// final item
if(GetLocalInt(OBJECT_SELF,"Player")==2)
 {
SetLocalInt(OBJECT_SELF,"Round",GetLocalInt(OBJECT_SELF,"Round")+1);
 }
////////////////////////////////////////////////////////////////////////////////
// card 1
else if(iChoice1==14)
 {
iXP = 1;
 }
////////////////////////////////////////////////////////////////////////////////
// card 2
else if(iChoice1==15)
 {
iXP = 3;
 }
////////////////////////////////////////////////////////////////////////////////
// card 3
else if(iChoice1==16)
 {
iXP = 2;
 }
////////////////////////////////////////////////////////////////////////////////
// front 1
else if(iChoice1==17)
 {
iXP = 3;
 }
////////////////////////////////////////////////////////////////////////////////
// front 2
else if(iChoice1==18)
 {
iXP = 4;
 }
////////////////////////////////////////////////////////////////////////////////
// front 3
else if(iChoice1==19)
 {
iXP = 3;
PlayAnimation(ANIMATION_LOOPING_DEAD_BACK);
AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_DEAD_BACK));
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
////////////////////////////////////////////////////////////////////////////////
}
