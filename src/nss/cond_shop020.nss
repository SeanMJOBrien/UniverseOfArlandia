int StartingConditional()
{
object oArea = GetArea(OBJECT_SELF);
object oStore = GetNearestObject(OBJECT_TYPE_STORE);

if(GetTag(oStore)=="store015"){return TRUE;}else{return FALSE;}
}
