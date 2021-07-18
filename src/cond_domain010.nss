int StartingConditional()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iPrice = GetLocalInt(OBJECT_SELF,"Price"+IntToString(iChoice1));

if(iGold>=iPrice){return TRUE;}else{return FALSE;}
}
