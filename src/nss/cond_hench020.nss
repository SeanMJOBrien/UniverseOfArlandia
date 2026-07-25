int StartingConditional()
{
object oPC = GetMaster();

if((GetIsObjectValid(oPC))&&(GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF)>0)){return TRUE;}else{return FALSE;}
}
