void main()
{
object oPC = GetLocalObject(OBJECT_SELF,"PC");
string sName = GetName(oPC)+GetPCPublicCDKey(oPC);
string sNewBP = GetLocalString(OBJECT_SELF,"ShapeBP");
string sBP = GetLocalString(OBJECT_SELF,"ShapeOrigBP");
string sTag = GetLocalString(OBJECT_SELF,"ShapeOrigTag");
string sNPCName = GetLocalString(OBJECT_SELF,"ShapeOrigName");
int iTypeCre = GetLocalInt(OBJECT_SELF,"ShapeType");
int iType = GetLocalInt(OBJECT_SELF,"ShapeOrigType");
location lLoc = GetLocalLocation(OBJECT_SELF,"ShapeLoc");
int iNPC = GetLocalInt(OBJECT_SELF,"ShapeNPC");
int iChange = GetLocalInt(OBJECT_SELF,"ChangeTagName");
object oNew;

if(iNPC>0)
 {
oNew = RetrieveCampaignObject(sName,"NPC"+IntToString(iNPC),lLoc);
 }
else
 {
if(iChange>0){oNew = CreateObject(iTypeCre,sNewBP,lLoc,FALSE,sTag);SetName(oNew,sNPCName);}else{oNew = CreateObject(iTypeCre,sNewBP,lLoc);}
 }
if(sBP=="mn_statueanim001"){AssignCommand(oNew,SetFacing(GetFacing(oNew)+180.0));}
SetLocalInt(oNew,"DontCopy",1);DelayCommand(3.0,DeleteLocalInt(oNew,"DontCopy"));
SetLocalString(oNew,"Var",IntToString(iType)+"_001_"+sBP+"_002_"+sTag+"_003_"+sNPCName+"_004_");

SetLocalInt(oNew,"Stop",GetLocalInt(OBJECT_SELF,"ShapeStop"));
SetLocalInt(oNew,"Persistent",GetLocalInt(OBJECT_SELF,"Persistent"));

SetLocalObject(oPC,"oTarget",oNew);
DestroyObject(OBJECT_SELF,3.5);
}
