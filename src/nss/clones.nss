////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oClones = GetItemPossessedBy(oPC,"clones");
int iUses = GetLocalInt(oClones,"Uses");
int iClones = GetLocalInt(oGoldbag,"Clones");
int i = 1;object oHenchs = GetHenchman(oPC,i);
object oNew;object oHench;location lLoc;
////////////////////////////////////////////////////////////////////////////////
if(iUses>=2)
 {
FloatingTextStringOnCreature("you must rest before you can clone yourself again",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
else if(iUses==1)
 {
// Destroy old clones
while(GetIsObjectValid(oHenchs))
  {
if(GetLocalInt(oHenchs,"Clone")==1)
   {
lLoc = GetLocation(oHenchs);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),lLoc);
SetImmortal(oHenchs,FALSE);SetPlotFlag(oHenchs,FALSE);AssignCommand(oHenchs,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHenchs);
   }
i++;oHenchs = GetHenchman(oPC,i);
  }
FloatingTextStringOnCreature("*unsummoning the clones*",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
// Destroy old clones
while(GetIsObjectValid(oHenchs))
  {
if(GetLocalInt(oHenchs,"Clone")==1)
   {
lLoc = GetLocation(oHenchs);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),lLoc);
SetImmortal(oHenchs,FALSE);SetPlotFlag(oHenchs,FALSE);AssignCommand(oHenchs,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHenchs);
   }
i++;oHenchs = GetHenchman(oPC,i);
  }

// Create new clones
while(iClones>0)
  {
oNew = CopyObject(oPC,GetLocation(oPC));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDominated(),oNew);
oHench = CopyObject(oNew,GetLocation(oPC));SetImmortal(oNew,FALSE);SetPlotFlag(oNew,FALSE);AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oNew);
lLoc = GetLocation(oHench);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3),lLoc);

SetLocalInt(oHench,"Clone",1);
SetLocalInt(oHench,"Hench",1);
SetLocalString(oHench,"Master",GetName(oPC));
ChangeToStandardFaction(oHench,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,oHench);

iClones--;
  }
FloatingTextStringOnCreature("*summoning the clones*",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(oClones,"Uses",iUses+1);
////////////////////////////////////////////////////////////////////////////////
}
