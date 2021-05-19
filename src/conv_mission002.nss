#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
int iPCMissions = GetLocalInt(oGoldbag,"Missions");
//
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
int MissionType1 = GetLocalInt(oModule,"MissionType1");
int MissionType2 = GetLocalInt(oModule,"MissionType2");
int MissionType3 = GetLocalInt(oModule,"MissionType3");
int MissionType4 = GetLocalInt(oModule,"MissionType4");
int MissionType5 = GetLocalInt(oModule,"MissionType5");
//
int iLevel = GetLocalInt(oArea,"Level");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iGain = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");
//
string sMission;int i;int iType;string sMissPlanet;string sProvArea;string sMissArea;string sBP;string sTag;int iNumber;int iXP;int iGP;int iDist;string sTitle;string sDes;object oHench;object oItems;string sName;int iMissionSuccess;int iMS;
////////////////////////////////////////////////////////////////////////////////
// Choose mission
if(iChoice1==1)
 {
iChoice2 = iChoice2+((iStep-2)*10);
sMission = GetLocalString(oModule,sPlanet+sArea+"Mission"+IntToString(iChoice2));
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);

SetLocalString(oGoldbag,"Mission"+IntToString(iPCMissions+1),sMission);
SetLocalInt(oGoldbag,"Missions",iPCMissions+1);
SetLocalInt(OBJECT_SELF,"MT"+IntToString(iChoice2),1);

if((iType>=MissionType2+1)&&(iType<=MissionType3))
  {
oItems = CreateItemOnObject(sBP,oPC);
sName = GetLocalString(oModule,sPlanet+"TownName"+IntToString(iChoice2));
SetName(oItems,GetName(oItems)+" to "+sName+"*");
SetIdentified(oItems,TRUE);SetPlotFlag(oItems,TRUE);SetDroppableFlag(oItems,FALSE);
SetLocalString(oItems,"Var",sMission);
SetLocalString(oItems,"Master",GetName(oPC));
SetLocalString(oItems,"Tag","mission");
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Delete mission
else if(iChoice1==2)
 {
iChoice2 = iChoice2+((iStep-2)*10);
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iChoice2));
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));

// Take back item
if((iType>=1)&&(iType<=MissionType1))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if(GetLocalString(oItems,"Var")==sMission){DestroyObject(oItems);}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Find resources
else if((iType>=MissionType1+1)&&(iType<=MissionType2))
  {
oItems = GetFirstItemInInventory(oPC);
while((GetIsObjectValid(oItems))&&(iNumber>0))
   {
if(GetResRef(oItems)==sBP){DestroyObject(oItems);iNumber--;}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Bring note
else if((iType>=MissionType2+1)&&(iType<=MissionType3))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if((GetResRef(oItems)==sBP)&&(GetLocalString(oItems,"Var")==sMission)){DestroyObject(oItems);}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Take back creatures
else if((iType>=MissionType3+1)&&(iType<=MissionType4))
  {
i=0;
while(i<GetMaxHenchmen())
   {
i++;
oHench = GetHenchman(oPC,i);
if((GetResRef(oHench)==sBP)&&(GetLocalInt(oHench,"Mission")==iChoice2)){RemoveHenchman(oPC,oHench);DeleteLocalString(oHench,"Tag");SetImmortal(oHench,FALSE);SetPlotFlag(oHench,FALSE);AssignCommand(oHench,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHench);}
   }
  }
// Kill monsters
else if((iType>=MissionType4+1)&&(iType<=MissionType5))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if(GetLocalString(oItems,"Var")==sMission){DestroyObject(oItems);break;}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Delete mission
while(iChoice2<iPCMissions)
  {
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iChoice2+1));
iMissionSuccess = GetLocalInt(oGoldbag,"MissionSuccess"+IntToString(iChoice2+1));

SetLocalString(oGoldbag,"Mission"+IntToString(iChoice2),sMission);
SetLocalInt(oGoldbag,"MissionSuccess"+IntToString(iChoice2),iMissionSuccess);

i=0;while(i<GetMaxHenchmen()){i++;oHench = GetHenchman(oPC,i);if(GetLocalInt(oHench,"Mission")==iChoice2+1){SetLocalInt(oHench,"Mission",iChoice2);break;}}

iChoice2++;
  }
DeleteLocalString(oGoldbag,"Mission"+IntToString(iChoice2));
DeleteLocalInt(oGoldbag,"MissionSuccess"+IntToString(iChoice2));

SetLocalInt(oGoldbag,"Missions",iChoice2-1);
 }
////////////////////////////////////////////////////////////////////////////////
// Finish mission
else if(iChoice1==3)
 {
iChoice2 = iChoice2+((iStep-2)*10);
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iChoice2));
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
sProvArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&003&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&003&")))-FindSubString(sMission,"&002&")-5);
sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);
sTag = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&006&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&006&")))-FindSubString(sMission,"&005&")-5);
iNumber = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&007&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&007&")))-FindSubString(sMission,"&006&")-5));
iXP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&008&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&008&")))-FindSubString(sMission,"&007&")-5));
iGP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&009&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&009&")))-FindSubString(sMission,"&008&")-5));
iDist = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&010&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&010&")))-FindSubString(sMission,"&009&")-5));
sTitle = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&011&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&011&")))-FindSubString(sMission,"&010&")-5);
sDes = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&012&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&012&")))-FindSubString(sMission,"&011&")-5);

// Give reward
iXP = iXP+(iDist*iXPDistBonus);
iGP = iGP+(iDist*iGPDistBonus);
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
GiveXPToCreature(oPC,iXP);

     if(iLevel>=4){iGP = iGP*2;}
     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iGP/2));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iGP/4));}

GiveGoldToCreature(oPC,iGP);
FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oPC);

// Take back item
if((iType>=1)&&(iType<=MissionType1))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if(GetLocalString(oItems,"Var")==sMission){DestroyObject(oItems);}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Find resources
else if((iType>=MissionType1+1)&&(iType<=MissionType2))
  {
oItems = GetFirstItemInInventory(oPC);
while((GetIsObjectValid(oItems))&&(iNumber>0))
   {
if(GetResRef(oItems)==sBP){DestroyObject(oItems);iNumber--;}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Bring note
else if((iType>=MissionType2+1)&&(iType<=MissionType3))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if((GetResRef(oItems)==sBP)&&(GetLocalString(oItems,"Var")==sMission)){DestroyObject(oItems);}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Take back creatures
else if((iType>=MissionType3+1)&&(iType<=MissionType4))
  {
i=0;
while(i<GetMaxHenchmen())
   {
i++;
oHench = GetHenchman(oPC,i);
if((GetResRef(oHench)==sBP)&&(GetLocalInt(oHench,"Mission")==iChoice2)){RemoveHenchman(oPC,oHench);DeleteLocalString(oHench,"Tag");SetImmortal(oHench,FALSE);SetPlotFlag(oHench,FALSE);AssignCommand(oHench,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHench);}
   }
  }
// Kill monsters
else if((iType>=MissionType4+1)&&(iType<=MissionType5))
  {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
   {
if(GetLocalString(oItems,"Var")==sMission){DestroyObject(oItems);}
oItems = GetNextItemInInventory(oPC);
   }
  }
// Delete mission
while(iChoice2<iPCMissions)
  {
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iChoice2+1));
iMissionSuccess = GetLocalInt(oGoldbag,"MissionSuccess"+IntToString(iChoice2+1));

SetLocalString(oGoldbag,"Mission"+IntToString(iChoice2),sMission);
SetLocalInt(oGoldbag,"MissionSuccess"+IntToString(iChoice2),iMissionSuccess);

i=0;while(i<GetMaxHenchmen()){i++;oHench = GetHenchman(oPC,i);if(GetLocalInt(oHench,"Mission")==iChoice2+1){SetLocalInt(oHench,"Mission",iChoice2);break;}}

iChoice2++;
  }
DeleteLocalString(oGoldbag,"Mission"+IntToString(iChoice2));
DeleteLocalInt(oGoldbag,"MissionSuccess"+IntToString(iChoice2));

SetLocalInt(oGoldbag,"Missions",iChoice2-1);
 }
////////////////////////////////////////////////////////////////////////////////
}
