void main()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iPrice;int iNumber;

     if(iChoice2==1){iNumber = 5;iPrice = 20;}
else if(iChoice2==2){iNumber = 10;iPrice = 35;}

if(iChoice1==1)
 {
SetLocalInt(oPC,"AniReserve",iNumber);
SetLocalInt(oPC,sPlanet+sArea+"AniReserve",1);
 }

else if(iChoice1==2)
 {
SetLocalInt(oPC,"ResMountain",iNumber);
SetLocalInt(oPC,sPlanet+sArea+"ResMountain",1);
 }

TakeGoldFromCreature(iPrice,oPC,TRUE);
}
