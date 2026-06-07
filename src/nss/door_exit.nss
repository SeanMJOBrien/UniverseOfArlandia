////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetClickingObject();
object oArea = GetArea(OBJECT_SELF);
string sPos = GetLocalString(oArea,"EnterArea");
if(GetLocalString(oPC,"FeerunArea")!=""){sPos = GetLocalString(oPC,"FeerunArea");DeleteLocalString(oPC,"FeerunArea");}
float fX = GetLocalFloat(oArea,"EnterX");
float fY = GetLocalFloat(oArea,"EnterY");
string sAreaTag = GetTag(oArea);
string sTempTag = GetLocalString(oArea,"Tag");if(sTempTag!=""){sAreaTag = sTempTag;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(oArea),9)=="deathpris")
 {
SetLocalString(oPC,"sPos",GetStringLeft(sAreaTag,GetStringLength(sAreaTag)-4));
SetLocalFloat(oPC,"fX",140.0);
SetLocalFloat(oPC,"fY",140.0);
SetLocalFloat(oPC,"fFacing",0.0);
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
SetLocalString(oPC,"sPos",sPos);
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",0.0);
 }
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(oPC,"DestTag",1);
ExecuteScript("000_transitions",oPC);
////////////////////////////////////////////////////////////////////////////////
}
