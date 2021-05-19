void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
object oNew;string sName;
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
sName = GetLocalString(oTarget,"Name");if(sName==""){SetLocalString(oTarget,"Name",GetName(oTarget));SetName(oTarget," ");SendMessageToPC(oPC,"Name deleted");}else{DeleteLocalString(oTarget,"Name");SetName(oTarget,sName);SendMessageToPC(oPC,"Name restored");}
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
// Area Begin //
sName = GetLocalString(oTarget,"Name");if(sName==""){SetLocalString(oTarget,"Name",GetName(oTarget));SetName(oTarget," ");SendMessageToPC(oPC,"Name deleted");}else{DeleteLocalString(oTarget,"Name");SetName(oTarget,sName);SendMessageToPC(oPC,"Name restored");}
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
