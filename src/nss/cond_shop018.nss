int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iGrade = GetLocalInt(oGoldbag,"Grade");
object oStore = GetNearestObject(OBJECT_TYPE_STORE);

if((GetTag(oStore)=="store017")&&(iGrade<5)){return TRUE;}else{return FALSE;}
}
