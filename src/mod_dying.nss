#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastPlayerDying();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
//
object oHenchs;object oObject;int i;
////////////////////////////////////////////////////////////////////////////////
SetStandardFactionReputation(STANDARD_FACTION_COMMONER,50,oPC);
SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);
////////////////////////////////////////////////////////////////////////////////
// Remove henchs and clones
while(i<iMaxHenchs){i++;oHenchs = GetHenchman(oPC,i);SetLocalObject(oPC,"Hench",oHenchs);SetLocalInt(oPC,"HenchAction",3);ExecuteScript("henchs",oPC);}
if(GetLocalInt(oGoldbag,"Clones")>0){SetLocalInt(GetItemPossessedBy(oPC,"clones"),"Uses",1);ExecuteScript("clones",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Remove summoneds
object oFamiliar1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
object oFamiliar2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
object oFamiliar3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);
object oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);

if(GetIsObjectValid(oFamiliar1)){RemoveSummonedAssociate(oPC,oFamiliar1);AssignCommand(oFamiliar1,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar1,FALSE);DestroyObject(oFamiliar1);}
if(GetIsObjectValid(oFamiliar2)){RemoveSummonedAssociate(oPC,oFamiliar2);AssignCommand(oFamiliar2,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar2,FALSE);DestroyObject(oFamiliar2);}
if(GetIsObjectValid(oFamiliar3)){RemoveSummonedAssociate(oPC,oFamiliar3);AssignCommand(oFamiliar3,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar3,FALSE);DestroyObject(oFamiliar3);}
if(GetIsObjectValid(oFamiliar4)){RemoveSummonedAssociate(oPC,oFamiliar4);AssignCommand(oFamiliar4,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar4,FALSE);DestroyObject(oFamiliar4);}
////////////////////////////////////////////////////////////////////////////////
}
