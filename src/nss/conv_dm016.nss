void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
int iNotFlee = GetLocalInt(oTarget,"NotFlee");
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
if(iNotFlee>0)
 {
SetLocalInt(oTarget,"Flee",1);
DeleteLocalInt(oTarget,"NotFlee");
DeleteLocalInt(oTarget,"Fleeing");
SendMessageToPC(oPC,GetName(oTarget)+" will now flee.");
 }
else
 {
DeleteLocalInt(oTarget,"Flee");
SetLocalInt(oTarget,"NotFlee",1);
DeleteLocalInt(oTarget,"Fleeing");
SendMessageToPC(oPC,GetName(oTarget)+" will not flee any more.");
 }
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
// Area Begin //
iNotFlee = GetLocalInt(oTarget,"NotFlee");
if(iNotFlee>0)
 {
SetLocalInt(oTarget,"Flee",1);
DeleteLocalInt(oTarget,"NotFlee");
DeleteLocalInt(oTarget,"Fleeing");
SendMessageToPC(oPC,GetName(oTarget)+" will now flee.");
 }
else
 {
DeleteLocalInt(oTarget,"Flee");
SetLocalInt(oTarget,"NotFlee",1);
DeleteLocalInt(oTarget,"Fleeing");
SendMessageToPC(oPC,GetName(oTarget)+" will not flee any more.");
 }
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
