int StartingConditional()
{
object oPC = GetPCSpeaker();
string sTag = GetTag(OBJECT_SELF);
int iTraining = GetLocalInt(oPC,"Training");

if((sTag=="trainer")&&(iTraining==1)){return TRUE;}else{return FALSE;}
}
