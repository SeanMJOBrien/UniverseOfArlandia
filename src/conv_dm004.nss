void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
int iStop;string s;
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
iStop = GetLocalInt(oTarget,"Stop");AssignCommand(oTarget,ClearAllActions());if(iStop==1){s = GetName(oTarget)+" will now walk!";DeleteLocalInt(oTarget,"Stop");}else{s = GetName(oTarget)+" will now stop!";SetLocalInt(oTarget,"Stop",1);}SendMessageToPC(oPC,s);
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
// Area Begin //
iStop = GetLocalInt(oTarget,"Stop");AssignCommand(oTarget,ClearAllActions());if(iStop==1){s = GetName(oTarget)+" will now walk!";DeleteLocalInt(oTarget,"Stop");}else{s = GetName(oTarget)+" will now stop!";SetLocalInt(oTarget,"Stop",1);}SendMessageToPC(oPC,s);
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
