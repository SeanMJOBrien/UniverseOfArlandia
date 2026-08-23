#include "aps_include"
#include "_string_utils"
////////////////////////////////////////////////////////////////////////////////
// DM cluster tool, step 2: while standing in the area you want to register,
// point the pending cluster coordinate's slot at this area's tag. Choice1
// (set by the conversation node) selects the slot: 1=Default 2=North
// 3=South 4=East 5=West. Run conv_dm045 first to set the pending coordinate.
////////////////////////////////////////////////////////////////////////////////
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
string sPlanet = GetLocalString(oPC,"PendingClusterPlanet");
string sAreaKey = GetLocalString(oPC,"PendingClusterAreaKey");
if((sPlanet=="")||(sAreaKey==""))
 {
FloatingTextStringOnCreature("no pending cluster coordinate - mark one first with the cluster tool",oPC);
 }
else
 {
int iSlot = GetLocalInt(OBJECT_SELF,"Choice1");
string sNewTag = GetTag(GetArea(oPC));
string sKey = sPlanet+"&"+sAreaKey+"&Cluster";
string sRec = GetPersistentString(oModule,sKey);
string s1=EncodedField(sRec,1);string s2=EncodedField(sRec,2);string s3=EncodedField(sRec,3);string s4=EncodedField(sRec,4);string s5=EncodedField(sRec,5);
     if(iSlot==1){s1=sNewTag;}
else if(iSlot==2){s2=sNewTag;}
else if(iSlot==3){s3=sNewTag;}
else if(iSlot==4){s4=sNewTag;}
else if(iSlot==5){s5=sNewTag;}
SetPersistentString(oModule,sKey,s1+"&001&"+s2+"&002&"+s3+"&003&"+s4+"&004&"+s5+"&005&");
SendMessageToPC(oPC,"Cluster "+sKey+" slot "+IntToString(iSlot)+" set to "+sNewTag);
 }
}
