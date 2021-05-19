#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastRespawnButtonPresser();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
////////////////////////////////////////////////////////////////////////////////
// Heal
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(100000),oPC);
////////////////////////////////////////////////////////////////////////////////
// Jump to Death plane
DelayCommand(0.2,AssignCommand(oPC,ActionJumpToLocation(GetLocation(GetWaypointByTag("WP_Death")))));
////////////////////////////////////////////////////////////////////////////////
// First
int a = 5;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
////////////////////////////////////////////////////////////////////////////////
}
