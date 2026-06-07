void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iMode = GetLocalInt(oPC,"AreaMode");
int iType = GetObjectType(oTarget);
int iHench = GetLocalInt(oTarget,"Hench");
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(iMode==0){
// Solo Begin //
if(iHench==1)
 {
ChangeToStandardFaction(oTarget,STANDARD_FACTION_MERCHANT);
if(GetIsObjectValid(GetMaster(oTarget))){SetLocalObject(GetMaster(oTarget),"Hench",oTarget);SetLocalInt(GetMaster(oTarget),"HenchAction",2);ExecuteScript("henchs",GetMaster(oTarget));}
DeleteLocalInt(oTarget,"Hench");
SetLocalInt(oTarget,"Stop",1);
SendMessageToPC(oPC,GetName(oTarget)+" is now a NPC.");
 }
else
 {
ChangeToStandardFaction(oTarget,STANDARD_FACTION_MERCHANT);
SetLocalInt(oTarget,"Hench",1);
SendMessageToPC(oPC,GetName(oTarget)+" is now a hench.");
 }
// Solo End //
}else{oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
// Area Begin //
iHench = GetLocalInt(oTarget,"Hench");
if(iHench==1)
 {
ChangeToStandardFaction(oTarget,STANDARD_FACTION_MERCHANT);
if(GetIsObjectValid(GetMaster(oTarget))){SetLocalObject(GetMaster(oTarget),"Hench",oTarget);SetLocalInt(GetMaster(oTarget),"HenchAction",2);ExecuteScript("henchs",GetMaster(oTarget));}
DeleteLocalInt(oTarget,"Hench");
SetLocalInt(oTarget,"Stop",1);
SendMessageToPC(oPC,GetName(oTarget)+" is now a NPC.");
 }
else
 {
ChangeToStandardFaction(oTarget,STANDARD_FACTION_MERCHANT);
SetLocalInt(oTarget,"Hench",1);
SendMessageToPC(oPC,GetName(oTarget)+" is now a hench.");
 }
// Area End //
}oTarget = GetNextObjectInArea(GetArea(oPC));}}
}
