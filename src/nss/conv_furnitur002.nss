void main()
{
object oPC = GetPCSpeaker();
object oFurniture = GetLocalObject(oPC,"Furniture");
string sBP = GetResRef(oFurniture);

CreateItemOnObject("o"+sBP,oPC);
DestroyObject(oFurniture);
}
