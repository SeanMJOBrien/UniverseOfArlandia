void main()
{
object oPC = GetPCSpeaker();

DeleteLocalInt(oPC,"Board");
DeleteLocalInt(oPC,"DomainRule");
DeleteLocalInt(oPC,"Null");
DeleteLocalInt(oPC,"Domain");
DeleteLocalInt(oPC,"CheckCode");

SetPlotFlag(OBJECT_SELF,FALSE);SetIsDestroyable(TRUE,FALSE,FALSE);DestroyObject(OBJECT_SELF);
}
