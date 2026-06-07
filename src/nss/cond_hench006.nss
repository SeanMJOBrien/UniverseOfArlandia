int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iHench = GetLocalInt(OBJECT_SELF,"HenchNum");
string sStay = GetLocalString(oGoldbag,IntToString(iHench)+"StayHench");
string sFamiliar4 = GetLocalString(oGoldbag,"Familiar4");
string sBP = GetResRef(OBJECT_SELF);

if((GetIsObjectValid(GetMaster()))&&(sStay=="")&&(sBP!=sFamiliar4)){return TRUE;}else{return FALSE;}
}
