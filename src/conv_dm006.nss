void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");
int iType = GetObjectType(oTarget);
string sName = GetName(oPC)+GetPCPublicCDKey(oPC);
int iNPCs = GetCampaignInt(sName,"NPCs")+1;
object oNewPC;
int iPC;if(GetIsPC(oTarget)){iPC = 1;}

if(GetIsPC(oTarget))
 {
oNewPC = CopyObject(oTarget,GetStartingLocation(),OBJECT_INVALID);ChangeToStandardFaction(oNewPC,STANDARD_FACTION_MERCHANT);
StoreCampaignObject(sName,"NPC"+IntToString(iNPCs),oNewPC);
 }
else
 {
StoreCampaignObject(sName,"NPC"+IntToString(iNPCs),oTarget);
 }
SetCampaignString(sName,"NPCName"+IntToString(iNPCs),GetName(oTarget));
SetCampaignString(sName,"NPCMaster"+IntToString(iNPCs),GetLocalString(oTarget,"Master"));
SetCampaignInt(sName,"NPCStop"+IntToString(iNPCs),GetLocalInt(oTarget,"Stop"));

SetCampaignInt(sName,"NPCs",iNPCs);
DestroyObject(oNewPC);
}
