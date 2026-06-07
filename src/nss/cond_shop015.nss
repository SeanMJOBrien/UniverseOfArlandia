int StartingConditional()
{
object oArea = GetArea(OBJECT_SELF);
int iLevel = GetLocalInt(oArea,"Level");
object oStore = GetNearestObject(OBJECT_TYPE_STORE);

if((GetTag(oStore)=="store015")&&(iLevel>=2)){return TRUE;}else{return FALSE;}
}
