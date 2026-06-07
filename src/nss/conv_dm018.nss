#include "zep_inc_phenos"
void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iPheno = GetPhenoType(oTarget);
int iPhenoOrig = GetLocalInt(oTarget,"PhenoOrig");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
int iRace = GetRacialType(oTarget);
object oNew;string sName;int iNewPheno;
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
if(iPheno<4){if((iRace==RACIAL_TYPE_HUMAN)||(iRace==RACIAL_TYPE_HALFORC)||(iRace==RACIAL_TYPE_HALFELF)||(iRace==RACIAL_TYPE_ELF)){iNewPheno = nCEP_PH_HORSE_BROWN_L;}else{iNewPheno = nCEP_PH_PONY_BROWN_L;}SetLocalInt(oTarget,"PhenoOrig",iPheno);SetPhenoType(iNewPheno,oTarget);SendMessageToPC(oPC,GetName(oTarget)+" mounts");}else{SetPhenoType(iPhenoOrig,oTarget);SendMessageToPC(oPC,GetName(oTarget)+" dismounts");}
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
iPheno = GetPhenoType(oTarget);
// Area Begin //
if(iPheno<4){if((iRace==RACIAL_TYPE_HUMAN)||(iRace==RACIAL_TYPE_HALFORC)||(iRace==RACIAL_TYPE_HALFELF)||(iRace==RACIAL_TYPE_ELF)){iNewPheno = nCEP_PH_HORSE_BROWN_L;}else{iNewPheno = nCEP_PH_PONY_BROWN_L;}SetLocalInt(oTarget,"PhenoOrig",iPheno);SetPhenoType(iNewPheno,oTarget);SendMessageToPC(oPC,GetName(oTarget)+" mounts");}else{SetPhenoType(iPhenoOrig,oTarget);SendMessageToPC(oPC,GetName(oTarget)+" dismounts");}
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
