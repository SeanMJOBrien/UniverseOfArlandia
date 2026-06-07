////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastUsedBy();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sMaster = GetLocalString(oArea,"Master");
string sTag = GetStringRight(GetTag(OBJECT_SELF),1);
int iLevel = GetLocalInt(oArea,"Level");
int iClose = GetLocalInt(OBJECT_SELF,"Closing");
////////////////////////////////////////////////////////////////////////////////
if((iClose==0)&&(GetName(oPC)==sMaster)&&(((sTag=="1")&&(iLevel>=1))||((sTag=="2")&&(iLevel>=4))||((sTag=="3")&&(iLevel>=5))||((sTag=="4")&&(iLevel>=5)))){SetLocalObject(OBJECT_SELF,"PC",oPC);SetLocked(OBJECT_SELF,FALSE);SpeakString("Unlocked");}
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(OBJECT_SELF,"Closing");
////////////////////////////////////////////////////////////////////////////////
}
