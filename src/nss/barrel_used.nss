void main()
{
object oPC = GetLastUsedBy();
location oLoc = GetLocation(OBJECT_SELF);
object oD = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
object oG = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
object oArea = GetArea(oPC);
string sTag = GetTag(oArea);

if(GetTag(OBJECT_SELF)=="barrelexplosive")
 {
if(GetTag(oD)=="NW_IT_TORCH001")
  {
FloatingTextStringOnCreature("Match lit",oPC,FALSE);
object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamemedium",oLoc,FALSE);
DelayCommand(5.0,ExecuteScript("barrel_detonate",OBJECT_SELF));
DelayCommand(4.0,DestroyObject(oFlame));
  }
else
  {
FloatingTextStringOnCreature("Packing the barrel",oPC,FALSE);
CreateItemOnObject("obarrelexplosive",oPC,1);
DestroyObject(OBJECT_SELF);
  }
 }

else if(GetTag(OBJECT_SELF)=="barrelempty")
 {
if(GetTag(oD)=="NW_IT_TORCH001")
  {
FloatingTextStringOnCreature("No powder in barrel",oPC,FALSE);
  }
else
  {
FloatingTextStringOnCreature("Packing the barrel",oPC,FALSE);
CreateItemOnObject("obarrelempty",oPC,1);
DestroyObject(OBJECT_SELF);
  }
 }
}
