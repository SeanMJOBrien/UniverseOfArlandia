#include "_module"
#include "_domainuser"
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
// The door reads the shared expiry clock (_domainuser.nss), not the tenant's
// own tick count - which the owner could never see, and which reset on reboot.
int iRent = DomainRentDaysLeft(sPlanet,sArea,iSlot);if(iStructure==14){iRent = 1;}
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
