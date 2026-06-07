#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCLevellingUp();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
////////////////////////////////////////////////////////////////////////////////
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oPC);
////////////////////////////////////////////////////////////////////////////////
// Automatic talents
// Cartographer for rangers
if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0)
 {
     if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=9){SetLocalInt(oGoldbag,"Cartographer",5);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=7){SetLocalInt(oGoldbag,"Cartographer",4);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=5){SetLocalInt(oGoldbag,"Cartographer",3);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=3){SetLocalInt(oGoldbag,"Cartographer",2);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=1){SetLocalInt(oGoldbag,"Cartographer",1);}
 }
// Leader for rangers
if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0)
 {
     if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=9){SetLocalInt(oGoldbag,"Leader",5);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=7){SetLocalInt(oGoldbag,"Leader",4);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=5){SetLocalInt(oGoldbag,"Leader",3);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=3){SetLocalInt(oGoldbag,"Leader",2);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=1){SetLocalInt(oGoldbag,"Leader",1);}
 }
////////////////////////////////////////////////////////////////////////////////
// Paladin horse power
if((GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>=5)&&(GetItemPossessedBy(oPC,"mountitem")==OBJECT_INVALID)){CreateItemOnObject("mountitem",oPC);}
////////////////////////////////////////////////////////////////////////////////
// First
int a = 2;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
////////////////////////////////////////////////////////////////////////////////
}
