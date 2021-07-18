#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastPlayerDied();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oKiller = GetLastKiller();
object oHenchs = GetHenchman(oPC,1);
//
object oObject;int i;
////////////////////////////////////////////////////////////////////////////////
// No death
if(GetLocalInt(oGoldbag,"Challenge")!=0)
 {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(100000),oPC);

oObject = GetNearestObjectByTag("altar_challenges",oPC);
SetImmortal(GetLocalObject(oObject,"FireMonster"),FALSE);SetPlotFlag(GetLocalObject(oObject,"FireMonster"),FALSE);AssignCommand(GetLocalObject(oObject,"FireMonster"),SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(GetLocalObject(oObject,"FireMonster"));
DeleteLocalObject(oObject,"FireMonster");
DeleteLocalObject(oObject,"PC");
DeleteLocalInt(oObject,"Firing");
SetLocked(GetNearestObjectByTag("door_challenge",oObject),FALSE);

DeleteLocalInt(oGoldbag,"Challenge");
SetXP(oPC,GetXP(oPC)-iMonsterChallenge);
FloatingTextStringOnCreature("-"+IntToString(iMonsterChallenge)+" xps",oPC);
AssignCommand(oObject,ActionSpeakString("BACK OFF !"));
 }
////////////////////////////////////////////////////////////////////////////////
// Normal death
else
 {
////////////////////////////////////////////////////////////////////////////////
// GUI Panel
SetStandardFactionReputation(STANDARD_FACTION_COMMONER,50,oPC);
SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);
SetLocalInt(oGoldbag,"Dead",1);
PopUpDeathGUIPanel(oPC,TRUE,TRUE,0,"You can wait for anybody to resurect you or you can choose to be sent in the death plane !");
////////////////////////////////////////////////////////////////////////////////
// Remove henchs and clones
while(GetIsObjectValid(oHenchs)){SetLocalObject(oPC,"Hench",oHenchs);SetLocalInt(oPC,"HenchAction",3);ExecuteScript("henchs",oPC);oHenchs = GetHenchman(oPC,1);}
if(GetLocalInt(oGoldbag,"Clones")>0){SetLocalInt(GetItemPossessedBy(oPC,"clones"),"Uses",1);ExecuteScript("clones",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Remove summoneds
object oFamiliar1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
object oFamiliar2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
object oFamiliar3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);
object oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);

if(GetIsObjectValid(oFamiliar1)){RemoveSummonedAssociate(oPC,oFamiliar1);AssignCommand(oFamiliar1,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar1,FALSE);DestroyObject(oFamiliar1);}
if(GetIsObjectValid(oFamiliar2)){RemoveSummonedAssociate(oPC,oFamiliar2);AssignCommand(oFamiliar2,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar2,FALSE);DestroyObject(oFamiliar2);}
if(GetIsObjectValid(oFamiliar3)){RemoveSummonedAssociate(oPC,oFamiliar3);AssignCommand(oFamiliar3,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar3,FALSE);DestroyObject(oFamiliar3);}
if(GetIsObjectValid(oFamiliar4)){RemoveSummonedAssociate(oPC,oFamiliar4);AssignCommand(oFamiliar4,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar4,FALSE);DestroyObject(oFamiliar4);}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Killed by an other player
if(GetIsPC(oKiller))
  {
int a = 26;int b;if(GetLocalInt(GetItemPossessedBy(oKiller,"goldbag"),"Uoabook"+IntToString(a))!=1){SetLocalInt(GetItemPossessedBy(oKiller,"goldbag"),"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oKiller,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oKiller,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oKiller,ActionStartConversation(oKiller,"uoa",TRUE,FALSE)));}
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
}
