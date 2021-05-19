int StartingConditional()
{
object oPC = GetPCSpeaker();
object oHead = GetItemPossessedBy(oPC,"lizardhead");
string sName = GetLocalString(OBJECT_SELF,"PC");

if((GetLocalInt(OBJECT_SELF,"Player")==7)&&(GetName(oPC)==sName)&&(!GetIsObjectValid(oHead))){return TRUE;}else{return FALSE;}
}

