#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetEnteringObject();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sAreaTag = GetTag(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sTag = GetTag(OBJECT_SELF);
//
object oTrig;int i;
////////////////////////////////////////////////////////////////////////////////
// Domain baths
if(sTag=="trig_baths")
 {
SetLocalInt(oPC,"InBath",1);
 }
////////////////////////////////////////////////////////////////////////////////
// Domain teleporter
else if(sTag=="teleporter")
 {
object oNullhuman = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",GetLocation(oPC));
SetLocalInt(oPC,"Null",1);
AssignCommand(oNullhuman,ActionStartConversation(oPC,"null",TRUE,FALSE));
DelayCommand(4.0,FloatingTextStringOnCreature("Ready",oPC,FALSE));
 }
////////////////////////////////////////////////////////////////////////////////
else if(GetLocalInt(oPC,"InTrigger")!=1){
////////////////////////////////////////////////////////////////////////////////
// Teleporters challenge
if(GetStringLeft(sTag,16)=="trig_teleporters")
 {
object oWP = GetNearestObjectByTag("wp_teleporters7");
float fX = GetPosition(oWP).x;
float fY = GetPosition(oWP).y;
string sCombi2 = GetLocalString(oWP,"Destinations");
object oWP1 = GetNearestObjectByTag("wp_teleporters"+GetStringRight(sTag,1));
int iWP1 = StringToInt(GetStringRight(GetTag(oWP1),1));
int iWP2 = StringToInt(GetSubString(sCombi2,iWP1-1,1));

oTrig = GetNearestObjectByTag("wp_teleporters"+IntToString(iWP2));

// Give XPs to party when entering teleporter 4
if((sTag=="trig_teleporters4")&&(GetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"XPs")!=1))
  {
SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"XPs",1);
object oFaction = GetFirstFactionMember(oPC);while((GetIsObjectValid(oFaction))&&(GetDistanceBetween(oPC,oFaction)<=40.0)){i++;oFaction = GetNextFactionMember(oPC);}
int iXP = 100/i;
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
oFaction = GetFirstFactionMember(oPC);while((GetIsObjectValid(oFaction))&&(GetDistanceBetween(oPC,oFaction)<=40.0)){GiveXPToCreature(oFaction,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oFaction);oFaction = GetNextFactionMember(oPC);}
  }
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
string sTrig;

     if(GetStringRight(sTag,1)=="1"){sTrig = "2";}else if(GetStringRight(sTag,1)=="2"){sTrig = "1";}
else if(GetStringRight(sTag,1)=="3"){sTrig = "4";}else if(GetStringRight(sTag,1)=="4"){sTrig = "3";}
else if(GetStringRight(sTag,1)=="5"){sTrig = "6";}else if(GetStringRight(sTag,1)=="6"){sTrig = "5";}
else if(GetStringRight(sTag,1)=="7"){sTrig = "8";}else if(GetStringRight(sTag,1)=="8"){sTrig = "7";}
else if(GetStringRight(sTag,1)=="9"){sTrig = "0";}else if(GetStringRight(sTag,1)=="0"){sTrig = "9";}

oTrig = GetObjectByTag("tr_"+sAreaTag+sTrig);
 }
////////////////////////////////////////////////////////////////////////////////
// Teleport
if((GetIsObjectValid(oTrig))&&(GetIsPC(oPC)))
 {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2),oPC);
SetLocalInt(oPC,"InTrigger",1);DelayCommand(3.0,DeleteLocalInt(oPC,"InTrigger"));
DelayCommand(1.0,AssignCommand(oPC,ClearAllActions()));
DelayCommand(2.0,AssignCommand(oPC,ActionJumpToLocation(GetLocation(oTrig))));
PlaySound("as_mg_telepout1");
 }
////////////////////////////////////////////////////////////////////////////////
}}
