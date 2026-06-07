void main()
{
object oPC = GetPCSpeaker();
object oFood;
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem)){if((GetTag(oItem)=="cr_apple")||(GetTag(oItem)=="cr_banana")||(GetTag(oItem)=="cr_cereal")||(GetTag(oItem)=="cr_cherry")||(GetTag(oItem)=="cr_egg")||(GetTag(oItem)=="cr_food")||(GetTag(oItem)=="cr_grape")||(GetTag(oItem)=="cr_jelly")||(GetTag(oItem)=="cr_milk")||(GetTag(oItem)=="cr_pemican")||(GetTag(oItem)=="cr_arabano")||(GetTag(oItem)=="cr_sandwich")||(GetTag(oItem)=="cr_strawberry")||(GetTag(oItem)=="food")){oFood = oItem;break;}oItem = GetNextItemInInventory(oPC);}

if(oFood==OBJECT_INVALID)
 {
SpeakString("I need food");
 }
else
 {
SetLocalObject(OBJECT_SELF,"Food",oFood);
AssignCommand(OBJECT_SELF,ClearAllActions());
AssignCommand(OBJECT_SELF,ActionRest(FALSE));
 }
}
