////////////////////////////////////////////////////////////////////////////////
void main()
{
object oPC = GetPCSpeaker();
object oBullet = GetItemPossessedBy(oPC,"ocannonbullet");
object oPowder = GetItemPossessedBy(oPC,"cr_powder");
object oNew;
//
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");
////////////////////////////////////////////////////////////////////////////////
if(iChoice==1)
 {
FloatingTextStringOnCreature("Packing the cannon",oPC,FALSE);
oNew = CreateItemOnObject("ocannon",oPC,1);
SetLocalInt(oNew,"Num",GetLocalInt(OBJECT_SELF,"Num"));
DestroyObject(OBJECT_SELF);
 }
//
else if(iChoice==2)
 {
if((GetIsObjectValid(oBullet))&&(GetIsObjectValid(oPowder)))
  {
DestroyObject(oBullet);
DestroyObject(oPowder);
SetLocalInt(OBJECT_SELF,"Num",GetLocalInt(OBJECT_SELF,"Num")+5);
FloatingTextStringOnCreature("Cannon charged",oPC,TRUE);
  }
else
  {
FloatingTextStringOnCreature("Needs one powder and one cannon bullet",oPC,TRUE);
  }
 }
//
else if(iChoice==3)
 {
FloatingTextStringOnCreature("Cannon charges : "+IntToString(GetLocalInt(OBJECT_SELF,"Num")),oPC,FALSE);
 }
//
DeleteLocalInt(OBJECT_SELF,"Choice");
////////////////////////////////////////////////////////////////////////////////
}
