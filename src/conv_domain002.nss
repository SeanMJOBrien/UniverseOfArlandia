#include "aps_include"
#include "_module"
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sName = GetName(oPC);
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oPla = GetNearestObjectByTag("pla_campfire002",oPC);
object oObjects = GetFirstObjectInArea(oArea);

DeleteLocalObject(oPC,"DomainPla1");
DestroyObject(GetLocalObject(oPC,"DomainPla2"));DeleteLocalObject(oPC,"DomainPla2");
DestroyObject(GetLocalObject(oPC,"DomainPla3"));DeleteLocalObject(oPC,"DomainPla3");
DestroyObject(GetLocalObject(oPC,"DomainPla4"));DeleteLocalObject(oPC,"DomainPla4");
DestroyObject(GetLocalObject(oPC,"DomainPla5"));DeleteLocalObject(oPC,"DomainPla5");
DestroyObject(GetLocalObject(oPC,"DomainItem"));DeleteLocalObject(oPC,"DomainItem");

SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests","D&1&"+sName+"&2&_01__02__03__04__05__06__07__08__09__10_"+sName+"'s Domain_11_&3&1&4&");

FloatingTextStringOnCreature("Domain built",oPC);
// Destroy camp
if(GetIsObjectValid(oPla)){while(GetIsObjectValid(oObjects)){if(GetLocalInt(oObjects,"Camp")==1){SetImmortal(oObjects,FALSE);SetPlotFlag(oObjects,FALSE);AssignCommand(oObjects,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObjects);}oObjects = GetNextObjectInArea(oArea);}}
// First
int a = 7;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));SetLocalInt(oPC,"DontChangeChoices",1);DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
}
