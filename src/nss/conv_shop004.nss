#include "aps_include"
#include "_module"
void main()
{
object oModule = GetModule();
object oStore = GetNearestObject(OBJECT_TYPE_STORE);
string sTag = GetTag(oStore);
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sMaster = GetName(oPC);
object oArea = GetArea(OBJECT_SELF);
//
int iLevel = GetLocalInt(oArea,"Level");
//
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}

if(sTag=="store000")
 {
int iReward = GetPersistentInt(oModule,"Sold_"+sMaster+"_"+sPlanet+"_"+sArea);

if(iReward>0)
  {
GiveGoldToCreature(oPC,iReward);
FloatingTextStringOnCreature("you sold some items",oPC);
DeletePersistentVariable(oModule,"Sold_"+sMaster+"_"+sPlanet+"_"+sArea);
  }
 }
DeleteLocalInt(oPC,"Price");
ExecuteScript("conv_dm_varempty",OBJECT_SELF);

// Domain temple
if(iLevel!=0){SetCustomToken(10132,"10");SetLocalInt(oPC,"Price1",10);SetCustomToken(10133,"25");SetLocalInt(oPC,"Price2",25);SetCustomToken(10134,"100");SetLocalInt(oPC,"Price3",100);}

// First
int a = 18;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
}
