void main()
{
object oPC = GetPCSpeaker();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
string sName = GetLocalString(OBJECT_SELF,"AreaObject"+IntToString((iStep-1)*10+iChoice));
int iFriend = GetLocalInt(OBJECT_SELF,"Friend");
string sMasterName = GetName(oPC);
string sMaster = GetLocalString(OBJECT_SELF,"Master");

if(sMasterName==sMaster)
 {
SetLocalString(OBJECT_SELF,"Dest",sName);
 }
else
 {
SetLocalString(OBJECT_SELF,"Dest",sMaster);
 }
DeleteLocalInt(OBJECT_SELF,"Friend");
if(iFriend==0){OpenInventory(OBJECT_SELF,oPC);}else{ExecuteScript("falcon",OBJECT_SELF);}
}
