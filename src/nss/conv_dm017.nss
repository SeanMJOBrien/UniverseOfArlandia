void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
int iPersistent;string s;
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
iPersistent = GetLocalInt(oTarget,"Persistent");AssignCommand(oTarget,ClearAllActions());if(iPersistent==1){s = GetName(oTarget)+" is now temporary !";DeleteLocalInt(oTarget,"Persistent");}else{s = GetName(oTarget)+" is now persistent !";SetLocalInt(oTarget,"Persistent",1);}SendMessageToPC(oPC,s);
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
// Area Begin //
iPersistent = GetLocalInt(oTarget,"Persistent");AssignCommand(oTarget,ClearAllActions());if(iPersistent==1){s = GetName(oTarget)+" is now temporary !";DeleteLocalInt(oTarget,"Persistent");}else{s = GetName(oTarget)+" is now persistent !";SetLocalInt(oTarget,"Persistent",1);}SendMessageToPC(oPC,s);
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
