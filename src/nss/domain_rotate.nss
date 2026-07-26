#include "aps_include"
// Rotates an already-built domain structure 90 degrees. Run as the action
// script of a reply on the structure's own "flag" placeable (structureflag),
// which already carries "Slot"/"Structure"/"Master" locals set by
// domains.nss at CreateObject time - no slot-picker UI needed, the player is
// already standing at the specific structure they want to rotate.
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
string sMaster = GetLocalString(OBJECT_SELF,"Master");

if((iSlot==0)||(iStructure==0)){return;}

// Bump the persisted rotation, kept independent of the Interests/Domain_Build
// encoded-string format (see domains.nss's fragile sVarN parsing) so old
// domains without a Rot key naturally default to 0 via GetPersistentInt.
int iRot = (GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Rot&"+IntToString(iSlot))+1)%4;
SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Rot&"+IntToString(iSlot),iRot);

// Destroy this slot's existing pieces (matched on Slot+Master, same filter
// shape as conv_domain003.nss's "Destroy Domain" block) before rebuilding -
// otherwise domains.nss would stack a second, differently-rotated copy on
// top instead of replacing it (the exact duplicate-placeable shape already
// fixed once this session for area_interests.nss's missing re-entry guard).
object oNext;
object oPiece = GetFirstObjectInArea(oArea);
while(GetIsObjectValid(oPiece))
 {
oNext = GetNextObjectInArea(oArea);
if((GetLocalInt(oPiece,"Slot")==iSlot)&&(GetLocalString(oPiece,"Master")==sMaster)){DestroyObject(oPiece);}
oPiece = oNext;
 }

// Rebuild via the same single-slot loop entry point Build already uses
// (domains.nss:87's iChoice2!=0 case) with Domain_Ini=1 so it takes the
// "just re-render existing state" path (area_interests.nss's own call
// convention) instead of the interactive purchase/payment path - iChoice3
// itself gets re-read from the persisted sVarNL either way, so the type
// passed here only matters for clarity.
SetLocalString(oArea,"Domain_Build",IntToString(iSlot)+"_+_"+IntToString(iStructure));
SetLocalInt(oArea,"Domain_Ini",1);
SetLocalObject(oArea,"PC",oPC);
DelayCommand(0.1,ExecuteScript("domains",oArea));
FloatingTextStringOnCreature("Structure rotated",oPC);
}
