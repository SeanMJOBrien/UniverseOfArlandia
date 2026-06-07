#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetExitingObject();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
string sName = GetName(oPC);
object oPCs = GetFirstPC();
object oObjects = GetFirstObjectInArea(OBJECT_SELF);
string sTag = GetTag(OBJECT_SELF);
int iNum;object oHench;int i1;
////////////////////////////////////////////////////////////////////////////////
// PCs
if(((GetIsObjectValid(oPC))&&(GetLocalInt(oModule,sName)!=0)&&(GetLocalInt(oPC,"Entering")==0))||(GetLocalInt(OBJECT_SELF,"SpecialSavePCDead")==1)){
////////////////////////////////////////////////////////////////////////////////
// Destroy henchs stayed here
while(iNum<iMaxHenchs+1){iNum++;oHench = GetLocalObject(oPC,"HenchObject"+IntToString(iNum));if((GetIsObjectValid(oHench))&&(GetMaster(oHench)==OBJECT_INVALID)){SetImmortal(oHench,FALSE);SetPlotFlag(oHench,FALSE);AssignCommand(oHench,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHench);DeleteLocalObject(oPC,"HenchObject"+IntToString(iNum));}}
////////////////////////////////////////////////////////////////////////////////
// Check if DM leaves the area or just possesses a NPC, or see if creatures follow PC in next area
if((GetIsDM(oPC))||(GetIsDMPossessed(oPC))){while(GetIsObjectValid(oObjects)){if((GetIsDM(oObjects))||(GetIsDMPossessed(oObjects))){i1++;break;}oObjects = GetNextObjectInArea(OBJECT_SELF);}}else{while(GetIsObjectValid(oObjects)){if((GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oObjects)>=90)&&(GetLocalInt(oObjects,"InCombat")==1)&&(GetDistanceBetweenLocations(GetLocation(oObjects),Location(OBJECT_SELF,Vector(GetLocalFloat(oGoldbag,"fX"),GetLocalFloat(oGoldbag,"fY"),GetLocalFloat(oGoldbag,"fZ")),GetLocalFloat(oGoldbag,"fFacing")))<=15.0)&&(GetChallengeRating(oObjects)<20.0)&&(GetStringRight(GetName(oObjects),1)!="*")&&(GetStringLeft(GetLocalString(oPC,"PlayerAreaTo"),5)!="ocean")&&(GetTag(oObjects)!="")&&(Random(4)!=0)){SetLocalInt(oObjects,"DontSave3",1);AssignCommand(oObjects,ClearAllActions(TRUE));AssignCommand(oObjects,ActionJumpToLocation(GetLocalLocation(oModule,GetName(oPC)+"Loc")));AssignCommand(oObjects,ActionAttack(oPC));}oObjects = GetNextObjectInArea(OBJECT_SELF);}}
// Check if players or DMs remain in or go to the area (fires only if a PC or a DM leaves the area)
while(GetIsObjectValid(oPCs)){if((GetTag(GetArea(oPCs))==sTag)||(GetLocalString(oPCs,"PlayerAreaTo")==sTag)){i1++;break;}oPCs = GetNextPC();}
// Nobody more in area = save area
if((sPlanet!="")&&(sArea!="")&&(i1<1)){DelayCommand(0.3,ExecuteScript("area_save",OBJECT_SELF));}
////////////////////////////////////////////////////////////////////////////////
}DeleteLocalInt(OBJECT_SELF,"SpecialSavePCDead");
////////////////////////////////////////////////////////////////////////////////
}
