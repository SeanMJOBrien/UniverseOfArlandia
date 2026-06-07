#include "dmfi_dmw_inc"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oItem = GetItemActivated();
int iTalentAction = GetLocalInt(oPC,"TalentAction");
object oNew;string s1;string s2;string sItemName;int iMax;int i;
int iTalents = GetLocalInt(oModule,"Talents");
////////////////////////////////////////////////////////////////////////////////
// Talents list
if(iTalents==0){

sItemName = "Cartographer";iMax = 5;iTalents++;SetLocalString(oModule,"Talent"+IntToString(iTalents),sItemName);SetLocalInt(oModule,sItemName,iMax);
sItemName = "Clone";iMax = 1;iTalents++;SetLocalString(oModule,"Talent"+IntToString(iTalents),sItemName);SetLocalInt(oModule,sItemName,iMax);
sItemName = "Horse Horde";iMax = 3;iTalents++;SetLocalString(oModule,"Talent"+IntToString(iTalents),sItemName);SetLocalInt(oModule,sItemName,iMax);
sItemName = "Item Sensor";iMax = 1;iTalents++;SetLocalString(oModule,"Talent"+IntToString(iTalents),sItemName);SetLocalInt(oModule,sItemName,iMax);
sItemName = "Leader";iMax = 5;iTalents++;SetLocalString(oModule,"Talent"+IntToString(iTalents),sItemName);SetLocalInt(oModule,sItemName,iMax);
sItemName = "Super Power";iMax = 5;iTalents++;SetLocalString(oModule,"Talent"+IntToString(iTalents),sItemName);SetLocalInt(oModule,sItemName,iMax);

SetLocalInt(oModule,"Talents",iTalents);}
////////////////////////////////////////////////////////////////////////////////
sItemName = GetStringRight(GetName(oItem),GetStringLength(GetName(oItem))-7);
iMax = GetLocalInt(oModule,sItemName);
////////////////////////////////////////////////////////////////////////////////
// Learn talent
if(iTalentAction==1)
 {
if(GetLocalInt(oGoldbag,sItemName)>=iMax)
  {
FloatingTextStringOnCreature("you can't learn more of this talent",oPC);
  }
else
  {
SetLocalInt(oGoldbag,sItemName,GetLocalInt(oGoldbag,sItemName)+1);
FloatingTextStringOnCreature("you improve the talent '"+sItemName+"'",oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oPC);
if((GetTag(oItem)=="tal_superpower")&&(GetItemPossessedBy(oPC,"superpower")==OBJECT_INVALID)){oNew = CreateItemOnObject("superpower",oPC);SetLocalInt(oNew,"color",6);}
DestroyObject(oItem);
// First
int a = 19;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));SetLocalInt(oPC,"DontChangeChoices",1);DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Check talents
else if(iTalentAction==2)
 {
while(i<iTalents)
  {
i++;
sItemName = GetLocalString(oModule,"Talent"+IntToString(i));
iMax = GetLocalInt(oModule,sItemName);
if(GetLocalInt(oGoldbag,sItemName)>0)
   {
s1 = ColorText("level "+IntToString(GetLocalInt(oGoldbag,sItemName)),"g");
if(GetLocalInt(oGoldbag,sItemName)>=iMax){s1 = s1+ColorText(" (max)","g");}
   }
else
   {
s1 = ColorText("---","r");
   }
s2 = s2+sItemName+" : "+s1+"\n";
  }
SetCustomToken(10139,s2);
// First
int a = 19;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));SetLocalInt(oPC,"DontChangeChoices",1);DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(oPC,"TalentAction");
////////////////////////////////////////////////////////////////////////////////
}
