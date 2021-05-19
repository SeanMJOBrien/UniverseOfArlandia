void main()
{
object oPC = GetPCSpeaker();
string sName = GetName(oPC);
object oScroll = GetLocalObject(oPC,"Scroll");
string sPos = GetLocalString(OBJECT_SELF,"Word");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");if(iChoice==2){sName = "";}

SetLocalString(oScroll,"Var",sPos+"_A_"+sName);

DeleteLocalObject(oPC,"Scroll");
DeleteLocalInt(OBJECT_SELF,"Choice1");
}
