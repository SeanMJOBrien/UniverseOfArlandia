////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastSpeaker();
int nMatch = GetListenPatternNumber();
object oIntruder;
////////////////////////////////////////////////////////////////////////////////
if((nMatch==-1)&&(GetCommandable(OBJECT_SELF)))
 {
ClearAllActions();
BeginConversation();
 }
else
 {
if((nMatch==777)&&(GetIsObjectValid(oPC))&&(GetIsPC(oPC)))
  {
if(oPC==GetLocalObject(OBJECT_SELF,"Player"))
   {
string sSaid = GetMatchedSubstring(0);
SetLocalString(OBJECT_SELF,"Word",sSaid);
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
