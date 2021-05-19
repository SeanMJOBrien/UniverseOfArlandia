void main()
{
object oPC = GetPCSpeaker();
object oFurniture = GetLocalObject(oPC,"Furniture");
string sTag = GetTag(oFurniture);

if(sTag=="chair")
 {
if(GetIsObjectValid(oPC)){AssignCommand(oPC,ActionSit(oFurniture));}
 }
}
