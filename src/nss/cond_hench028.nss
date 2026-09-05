// Gates the "Level up" reply in hench.dlg (entry 6, "What can I do for you?")
// to a posted Soldier only - a hench000 that has been "Guard this spot"'d at
// a domain (soldiers_save.nss: RemoveHenchman + Merchant faction + SoldierNum
// set) and so no longer has a live GetMaster() associate link. An active,
// currently-following hench000 (GetMaster() still valid) does not offer this.
int StartingConditional()
{
object oPC = GetPCSpeaker();
string sBP = GetResRef(OBJECT_SELF);

if((sBP=="hench000")&&(!GetIsObjectValid(GetMaster()))&&(GetLocalInt(OBJECT_SELF,"SoldierNum")>0)){return TRUE;}else{return FALSE;}
}
