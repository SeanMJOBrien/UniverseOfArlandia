////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastDamager();
object oMaster = GetNearestObjectByTag("player",oPC);
object oDummy = GetNearestObjectByTag("dummyL");
////////////////////////////////////////////////////////////////////////////////
// Tord hb
if(GetTag(OBJECT_SELF)=="npc_tord")
 {
if((GetCurrentAction()==ACTION_INVALID)&&(GetIsObjectValid(oDummy))&&(GetLocalInt(OBJECT_SELF,"Start")==1)){DoPlaceableObjectAction(oDummy,PLACEABLE_ACTION_BASH);}
 }
////////////////////////////////////////////////////////////////////////////////
// Dummy damaged
else
 {
////////////////////////////////////////////////////////////////////////////////
if(GetCurrentHitPoints(OBJECT_SELF)<=0)
  {
if(GetTag(OBJECT_SELF)=="dummyL")
   {
if(GetIsPC(oPC)){oPC = GetNearestObjectByTag("npc_tord");}
AssignCommand(oPC,ActionMoveToObject(oMaster,TRUE,0.3));
   }
SetLocalInt(oMaster,"Success",1);
SetLocalInt(oPC,"Success",1);
  }
else if((GetTag(OBJECT_SELF)=="dummyR")&&(GetName(oPC)!=GetLocalString(OBJECT_SELF,"Player")))
  {
SetPlotFlag(OBJECT_SELF,TRUE);
SpeakString("Cheaters");
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
}
