void main()
{
object oPC = GetPCSpeaker();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep-1));
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
object oTarget = GetLocalObject(OBJECT_SELF,"AreaObject"+IntToString(10*(iStep-2)+iChoice1));
string s;
//
if(iChoice2==1)
  {
SetLocalObject(oPC,"ItemTarget",oTarget);ExecuteScript("analyser",oPC);
  }
//
else if(iChoice2==2)
  {
DestroyObject(oTarget);
SendMessageToPC(oPC,GetName(oTarget)+" destroyed");
  }
//
else if(iChoice2==3)
  {
AssignCommand(oPC,ActionJumpToObject(oTarget));
  }
//
else if(iChoice2==4)
  {
if(GetPlotFlag(oTarget)==FALSE){SetPlotFlag(oTarget,TRUE);s = "ploted";}else{SetPlotFlag(oTarget,FALSE);s = "unploted";}
SendMessageToPC(oPC,GetName(oTarget)+" "+s);
  }
//
else if(iChoice2==5)
  {
if(GetUseableFlag(oTarget)==FALSE){SetUseableFlag(oTarget,TRUE);s = "useable";}else{SetUseableFlag(oTarget,FALSE);s = "unuseable";}
SendMessageToPC(oPC,GetName(oTarget)+" "+s);
  }
//
SetLocalInt(OBJECT_SELF,"Step",iStep-1);
}
