int StartingConditional()
{
object oPC = GetPCSpeaker();
string sTag = GetTag(OBJECT_SELF);
int iWait = GetLocalInt(OBJECT_SELF,"Wait");
int iClone = GetLocalInt(OBJECT_SELF,"Clone");
int iSummon = GetLocalInt(OBJECT_SELF,"Summon");

if((iWait==0)&&(oPC==GetMaster(OBJECT_SELF))&&(sTag=="henchani012")&&(GetIsObjectValid(GetMaster(OBJECT_SELF)))&&(iClone==0)&&(iSummon==0)){return TRUE;}else{return FALSE;}
}
