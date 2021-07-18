void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
LevelUpHenchman(oTarget,CLASS_TYPE_INVALID,TRUE,PACKAGE_INVALID);
SendMessageToPC(oPC,GetName(oTarget)+" is now level "+IntToString(GetLevelByPosition(1,oTarget)+GetLevelByPosition(2,oTarget)+GetLevelByPosition(3,oTarget)));
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
// Area Begin //
LevelUpHenchman(oTarget,CLASS_TYPE_INVALID,TRUE,PACKAGE_INVALID);
SendMessageToPC(oPC,GetName(oTarget)+" is now level "+IntToString(GetLevelByPosition(1,oTarget)+GetLevelByPosition(2,oTarget)+GetLevelByPosition(3,oTarget)));
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
