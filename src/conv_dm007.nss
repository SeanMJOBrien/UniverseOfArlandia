void main()
{
object oPC = GetPCSpeaker();
string sName = GetName(oPC)+GetPCPublicCDKey(oPC);
int iStep = 10*(GetLocalInt(OBJECT_SELF,"Step")-2);
int iNPCs = GetCampaignInt(sName,"NPCs");
string s;int i;

while(i<10)
 {
i++;
s = GetCampaignString(sName,"NPCName"+IntToString((iNPCs+1)-(i+iStep)));
if(s==""){SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
SetCustomToken(20050+i,s);}
 }
}
