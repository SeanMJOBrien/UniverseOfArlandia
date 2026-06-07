int StartingConditional()
{
object oPC = GetPCSpeaker();
int iLevel = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");

if(iLevel>=iChoice1+2){return TRUE;}else{return FALSE;}
}
