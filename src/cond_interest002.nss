int StartingConditional()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iPrice;

     if(iChoice2==1){iPrice = 20;}
else if(iChoice2==2){iPrice = 35;}

if(iGold>=iPrice){return TRUE;}else{return FALSE;}
}
