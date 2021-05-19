int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sBP = GetResRef(OBJECT_SELF);

if((sBP=="hench000")&&(GetIsObjectValid(GetMaster()))){return TRUE;}else{return FALSE;}
}
