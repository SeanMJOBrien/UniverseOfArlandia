void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
if(GetLocalInt(oTarget,"Leader")==1){DeleteLocalInt(oTarget,"Leader");SendMessageToPC(oPC,GetName(oTarget)+" is no longer a leader.");}else{SetLocalInt(oTarget,"Leader",1);SendMessageToPC(oPC,GetName(oTarget)+" is now a leader.");}
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
// Area Begin //
if(GetLocalInt(oTarget,"Leader")==1){DeleteLocalInt(oTarget,"Leader");SendMessageToPC(oPC,GetName(oTarget)+" is no longer a leader.");}else{SetLocalInt(oTarget,"Leader",1);SendMessageToPC(oPC,GetName(oTarget)+" is now a leader.");}
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
