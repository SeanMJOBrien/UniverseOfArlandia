void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oTarget = GetLocalObject(oPC,"oTarget");
string sPos = GetLocalString(OBJECT_SELF,"Word");

SetName(oTarget,sPos);
if(GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
 {
if(GetIsDM(oPC))
  {
AssignCommand(oPC,ActionStartConversation(oPC,"dm",TRUE,FALSE));
  }
else if(GetLocalInt(oTarget,"Hench")>0)
  {
int iHenchs = GetLocalInt(oTarget,"HenchNum");
string sHench = GetLocalString(oGoldbag,IntToString(iHenchs)+"Hench");
string sLeft = GetStringLeft(sHench,FindSubString(sHench,"&A&")+3);
string sRight = GetStringRight(sHench,GetStringLength(sHench)-FindSubString(sHench,"&B&"));

SetLocalString(oGoldbag,IntToString(iHenchs)+"Hench",sLeft+sPos+sRight);
  }
 }
DeleteLocalString(OBJECT_SELF,"Word");
}
