void main()
{
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
string sX = IntToString(FloatToInt(GetPosition(OBJECT_SELF).x));
string sY = IntToString(FloatToInt(GetPosition(OBJECT_SELF).y));
effect eEffects = GetFirstEffect(OBJECT_SELF);

int i;while(i<20){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
i = GetLocalInt(oModule,sPlanet+sArea+sX+sY+"Game");
if(i==0)
 {
if(GetLocalInt(OBJECT_SELF,"Player")!=0){i = GetLocalInt(OBJECT_SELF,"Player");}else{i = Random(12)+9;}
SetLocalInt(oModule,sPlanet+sArea+sX+sY+"Game",i);
SetLocalInt(OBJECT_SELF,"Player",i);
 }
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));

if(i==19)
 {
SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HALF_ORC);
SetPhenoType(PHENOTYPE_BIG);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityIncrease(ABILITY_STRENGTH,8),OBJECT_SELF);
 }
else if(GetPhenoType(OBJECT_SELF)!=PHENOTYPE_NORMAL)
 {
SetCreatureAppearanceType(OBJECT_SELF,APPEARANCE_TYPE_HUMAN);
SetPhenoType(PHENOTYPE_NORMAL);
while(GetIsEffectValid(eEffects)){RemoveEffect(OBJECT_SELF,eEffects);eEffects = GetNextEffect(OBJECT_SELF);}
 }

DeleteLocalInt(OBJECT_SELF,"Round");
}
