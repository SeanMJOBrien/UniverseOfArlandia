int StartingConditional()
{
object oArea = GetArea(OBJECT_SELF);
object oBox = GetLocalObject(oArea,"Mailbox");
int iLevel = GetLocalInt(oBox,"Level");

if((GetIsObjectValid(oBox))&&(iLevel>=4)){return TRUE;}else{return FALSE;}
}
