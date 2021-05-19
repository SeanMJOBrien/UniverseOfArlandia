int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iHench = GetLocalInt(OBJECT_SELF,"HenchNum");
string sStay = GetLocalString(oGoldbag,IntToString(iHench)+"StayHench");

if((GetIsObjectValid(GetMaster()))&&(sStay=="")){return TRUE;}else{return FALSE;}
}
