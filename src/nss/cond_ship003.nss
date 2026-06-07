int StartingConditional()
{
object oPC = GetPCSpeaker();
object oAsteroid = GetNearestObjectByTag("pla_asteroid",oPC);
int iUseable = GetUseableFlag(oAsteroid);
string sItemTag = GetLocalString(oPC,"shiptool");

if((GetIsObjectValid(oAsteroid))&&(iUseable==TRUE)&&(GetDistanceBetween(oPC,oAsteroid)<=20.0)&&(sItemTag=="tool_starship")){return TRUE;}else{return FALSE;}
}
