void main()
{
object oPC = GetLocalObject(OBJECT_SELF,"PC");
string sName = GetName(oPC);
object oItem = GetLocalObject(OBJECT_SELF,"Item");
string sMaster = GetLocalString(OBJECT_SELF,"Master");
int iToChange = GetLocalInt(OBJECT_SELF,"ToChange");
object oHench;

ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,OBJECT_SELF);
CopyItem(oItem,oPC,TRUE);
DestroyObject(oItem);
SpeakString("Crwroak");
PlayVoiceChat(VOICE_CHAT_BATTLECRY1,OBJECT_SELF);

DeleteLocalObject(OBJECT_SELF,"PC");
DeleteLocalObject(OBJECT_SELF,"Item");
DeleteLocalString(OBJECT_SELF,"Dest");
DeleteLocalInt(OBJECT_SELF,"Wait");

if(sName==sMaster){DeleteLocalInt(oPC,"FalconAway"+IntToString(GetLocalInt(OBJECT_SELF,"Num")));}
if(iToChange!=0)
 {
oHench = CopyObject(OBJECT_SELF,GetLocation(OBJECT_SELF),OBJECT_INVALID,GetTag(OBJECT_SELF));
SetLocalString(oHench,"Master",sMaster);
SetLocalInt(oHench,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));
SetLocalInt(oHench,"Hench",GetLocalInt(OBJECT_SELF,"Hench"));
SetLocalInt(oHench,"DontSave",GetLocalInt(OBJECT_SELF,"DontSave"));
SetLocalInt(oHench,"Num",GetLocalInt(OBJECT_SELF,"Num"));
ChangeToStandardFaction(oHench,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,oHench);
SetIsDestroyable(TRUE,TRUE,TRUE);DestroyObject(OBJECT_SELF);
 }
}
