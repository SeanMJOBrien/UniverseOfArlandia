int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sTag = GetTag(OBJECT_SELF);
int iFireEnd = GetLocalInt(OBJECT_SELF,"FireEnd");

if((sTag=="altar_challenges")&&(GetLocalInt(oGoldbag,"Challenge")==1)&&(iFireEnd==1)){return TRUE;}else{return FALSE;}
}
