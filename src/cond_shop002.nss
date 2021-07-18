int StartingConditional()
{
object oStore = GetNearestObject(OBJECT_TYPE_STORE);

if(GetTag(oStore)=="store014"){return TRUE;}else{return FALSE;}
}
