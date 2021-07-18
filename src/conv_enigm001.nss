#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oItem = GetFirstItemInInventory(oPC);
object oParty = GetFirstFactionMember(oPC);
object oArea = GetArea(OBJECT_SELF);
int iAreaX = GetAreaSize(AREA_WIDTH,oArea)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,oArea)*10;
//
object oEnigm = GetLocalObject(OBJECT_SELF,"oEnigm");
string sEnigms = GetLocalString(oEnigm,"Var");
int iEnigm1 = StringToInt(GetStringLeft(sEnigms,FindSubString(sEnigms,"_")));
int iEnigm2 = StringToInt(GetStringRight(sEnigms,GetStringLength(sEnigms)-FindSubString(sEnigms,"_")-1));
string sSuccess = GetStringRight(sEnigms,8);
object oDoor = GetNearestObjectByTag("door_treasure",oEnigm);

int iTries = GetLocalInt(oPC,"Tries");
int i22 = GetLocalInt(oEnigm,"Buttons");
int iLight1 = GetLocalInt(oEnigm,"Light1");
int iLight2 = GetLocalInt(oEnigm,"Light2");
int iLight3 = GetLocalInt(oEnigm,"Light3");
int iLight4 = GetLocalInt(oEnigm,"Light4");
int iLight5 = GetLocalInt(oEnigm,"Light5");
int iLight6 = GetLocalInt(oEnigm,"Light6");
int iLight7 = GetLocalInt(oEnigm,"Light7");
int iLights = iLight1+iLight2+iLight3+iLight4+iLight5+iLight6+iLight7;

string sResult = GetLocalString(oEnigm,"Result");
int iItems = GetLocalInt(oEnigm,"Items");
int iXP = GetLocalInt(oEnigm,"XPs")-(iTries*2);if(iXP<0){iXP = 0;}
object oNew;object oCre;int i;int j;
////////////////////////////////////////////////////////////////////////////////
while(GetIsObjectValid(oItem))
 {
if((GetResRef(oItem)==sResult)&&(GetLocalInt(oItem,"Enigm")==1))
  {
if(GetItemStackSize(oItem)>1){i = i+GetItemStackSize(oItem);}else{i++;}SetLocalObject(oPC,"Result"+IntToString(i),oItem);
  }
oItem = GetNextItemInInventory(oPC);
 }
////////////////////////////////////////////////////////////////////////////////
if((iEnigm1==1)||((iEnigm1==2)&&(iEnigm2<3))||((iEnigm1==2)&&(iEnigm2>=3)&&(iLights>=i22))||((iEnigm1==3)&&(sSuccess=="&Success"))||((iEnigm1==4)&&(i>=iItems))||(iEnigm1==5))
 {
while(GetIsObjectValid(oParty))
  {
if((oParty==oPC)||(GetDistanceBetween(oParty,oPC)<=40.0)){j++;}
oParty = GetNextFactionMember(oPC);
  }
iXP = iXP/j;
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}

oParty = GetFirstFactionMember(oPC);
while(GetIsObjectValid(oParty))
  {
if((oParty==oPC)||(GetDistanceBetween(oParty,oPC)<=50.0)){GiveXPToCreature(oParty,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oParty);}
oParty = GetNextFactionMember(oPC);
  }
if(iEnigm1==4)
  {
while(i>0)
   {
DestroyObject(GetLocalObject(oPC,"Result"+IntToString(i)));
DeleteLocalObject(oPC,"Result"+IntToString(i));
i--;
   }
  }
else if(iEnigm1==5)
  {
DestroyObject(GetLocalObject(oEnigm,"Code"));
  }
if(GetTag(oEnigm)=="enigmmaker"){AssignCommand(oEnigm,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));SetLocked(oDoor,FALSE);AssignCommand(oDoor,ActionOpenDoor(oDoor));SetUseableFlag(oEnigm,FALSE);}else{DestroyObject(oEnigm);}
 }
////////////////////////////////////////////////////////////////////////////////
else if(iEnigm1==3)
 {
oNew = CreateObject(OBJECT_TYPE_CREATURE,sResult,GetLocation(oEnigm));SetLocalInt(oNew,"DontSave",1);
SetLocalObject(oNew,"oEnigm",oEnigm);
SetLocalString(oNew,"Enigm",sEnigms);
AssignCommand(oNew,ActionAttack(oPC));
SetLocalInt(oEnigm,"EnigmRun",1);
 }
////////////////////////////////////////////////////////////////////////////////
else if(iEnigm1==4)
 {
while(i<iItems)
  {
i++;
oCre = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",Location(oArea,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0));oNew = CreateObject(OBJECT_TYPE_ITEM,sResult,GetLocation(oCre));DestroyObject(oCre);SetLocalInt(oNew,"DontSave",1);
SetLocalInt(oNew,"Enigm",1);
  }
SetLocalInt(oEnigm,"EnigmRun",1);
 }
////////////////////////////////////////////////////////////////////////////////
}
