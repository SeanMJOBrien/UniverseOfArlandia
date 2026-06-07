#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oItem = GetLocalObject(oPC,"ItemActivated");
object oTarget = GetLocalObject(oPC,"ItemTarget");
location lTarget = GetLocalLocation(oPC,"ItemLocation");
//
int iWear;int iWearP;
////////////////////////////////////////////////////////////////////////////////
// DMs
if((GetIsDM(oPC))||(GetIsDMPossessed(oPC))){
// Planet & Area
if(oTarget==OBJECT_INVALID)
 {
SendMessageToPC(oPC,"Planet = "+sPlanet);
SendMessageToPC(oPC,"Area = "+sArea);
if((GetIsObjectValid(GetNearestObjectByTag("wp_teleporters7")))&&(GetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(GetPosition(GetNearestObjectByTag("wp_teleporters7")).x))+IntToString(FloatToInt(GetPosition(GetNearestObjectByTag("wp_teleporters7")).y))+"Comb")!="")){SendMessageToPC(oPC,"Challenge Combination = "+GetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(GetPosition(GetNearestObjectByTag("wp_teleporters7")).x))+IntToString(FloatToInt(GetPosition(GetNearestObjectByTag("wp_teleporters7")).y))+"Comb"));}
 }
else
 {
if(GetIsPC(oTarget))
  {
SendMessageToPC(oPC,"XPs : "+IntToString(GetXP(oTarget)));
SendMessageToPC(oPC,"GPs : "+IntToString(GetGold(oTarget)));
  }
else
  {
SendMessageToPC(oPC,"Tag : "+GetTag(oTarget));
SendMessageToPC(oPC,"Master : "+GetLocalString(oTarget,"Master"));
SendMessageToPC(oPC,"Var : "+GetLocalString(oTarget,"Var"));
  }
 }
//
}
////////////////////////////////////////////////////////////////////////////////
// Players
else{
//
if(oTarget==OBJECT_INVALID)
 {
if(GetStringLeft(GetTag(oArea),6)=="clouds")
  {
SendMessageToPC(oPC,"Planet = "+sPlanet);
SendMessageToPC(oPC,"Area = "+sArea);
  }
else if(GetLocalInt(oGoldbag,"Cartographer")>0)
  {
if(((GetLocalInt(oGoldbag,"Cartographer")>=1)&&((GetIsAreaInterior(oArea))||(GetStringLeft(GetTag(oArea),4)=="city")||(GetStringLeft(GetTag(oArea),6)=="forest")||(GetStringLeft(GetTag(oArea),5)=="hills")||(GetStringLeft(GetTag(oArea),5)=="rural")||(GetStringLeft(GetTag(oArea),5)=="plain")||(GetStringLeft(GetTag(oArea),5)=="river")))||
   ((GetLocalInt(oGoldbag,"Cartographer")>=2)&&((GetStringLeft(GetTag(oArea),9)=="foothills")||(GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),4)=="moon")||(GetStringLeft(GetTag(oArea),6)=="mounts")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")||(GetStringLeft(GetTag(oArea),8)=="tropical")))||
   ((GetLocalInt(oGoldbag,"Cartographer")>=3)&&((GetStringLeft(GetTag(oArea),6)=="desert")||(GetStringLeft(GetTag(oArea),8)=="mountain")||(GetStringLeft(GetTag(oArea),10)=="ruralswamp")||(GetStringLeft(GetTag(oArea),8)=="seafloor")))||
   ((GetLocalInt(oGoldbag,"Cartographer")>=4)&&((GetStringLeft(GetTag(oArea),6)=="frozen")||(GetStringLeft(GetTag(oArea),9)=="mountsnow")||(GetStringLeft(GetTag(oArea),5)=="ocean")||(GetStringLeft(GetTag(oArea),4)=="snow")||(GetStringLeft(GetTag(oArea),5)=="swamp")))||
   ((GetLocalInt(oGoldbag,"Cartographer")>=5)&&(GetStringLeft(GetTag(oArea),3)=="gaz")))
   {
SendMessageToPC(oPC,"Planet = "+sPlanet);
SendMessageToPC(oPC,"Area = "+sArea);
   }
  }
 }
else
 {

 }
// First
int a = 1;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
}
////////////////////////////////////////////////////////////////////////////////
// All
if(GetObjectType(oTarget)==OBJECT_TYPE_ITEM){iWear = GetLocalInt(oTarget,"Wear");iWearP = GetLocalInt(oTarget,"Wear%");if(iWear==0){iWearP = 100;}else if(iWear<0){iWearP = 0;}SendMessageToPC(oPC,GetName(oTarget)+" wear : "+IntToString(iWearP)+"%");}
////////////////////////////////////////////////////////////////////////////////
}
