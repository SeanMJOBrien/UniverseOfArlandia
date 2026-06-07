void main()
{
object oPC = GetPCSpeaker();
object oSuperpower = GetItemPossessedBy(oPC,"superpower");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");

SetLocalInt(oSuperpower,"Color",iChoice);
}
