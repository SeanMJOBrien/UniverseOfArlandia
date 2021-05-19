#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
//
int iOpen = GetLocalInt(oModule,sPlanet+"&"+sArea+"&Open&"+IntToString(iSlot));
int iRent = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iSlot));if(iStructure==14){iRent = 1;}
////////////////////////////////////////////////////////////////////////////////
if(iOpen==0)
 {
if(iRent>0){SetLocalInt(oModule,sPlanet+"&"+sArea+"&Open&"+IntToString(iSlot),1);FloatingTextStringOnCreature("Door unlocked",oPC);}else{FloatingTextStringOnCreature("No more rent",oPC);}
 }
else
 {
DeleteLocalInt(oModule,sPlanet+"&"+sArea+"&Open&"+IntToString(iSlot));FloatingTextStringOnCreature("Door locked",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
}
