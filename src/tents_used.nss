void main()
{
object oPC = GetLastUsedBy();
string sTag = GetTag(OBJECT_SELF);
int iWear = GetLocalInt(OBJECT_SELF,"Wear");

object oTent = CreateItemOnObject("tent00"+GetStringRight(sTag,1),oPC,1);
SetLocalInt(oTent,"Wear",iWear);
FloatingTextStringOnCreature("Packing the tent",oPC,TRUE);

DestroyObject(OBJECT_SELF);
}
