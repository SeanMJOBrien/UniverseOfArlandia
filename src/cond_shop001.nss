int StartingConditional()
{
object oStore = GetNearestObject(OBJECT_TYPE_STORE);

if(GetTag(oStore)=="store012"){return TRUE;}else{return FALSE;}
}
