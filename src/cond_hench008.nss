int StartingConditional()
{
object oPC = GetPCSpeaker();
string sName = GetName(oPC);
string sMaster = GetLocalString(OBJECT_SELF,"Master");
string sTag = GetLocalString(OBJECT_SELF,"Tag");
int iClone = GetLocalInt(OBJECT_SELF,"Clone");
int iSummon = GetLocalInt(OBJECT_SELF,"Summon");

if((sMaster==sName)&&(sTag!="mission")&&(iClone==0)&&(iSummon==0)){return TRUE;}else{return FALSE;}
}
