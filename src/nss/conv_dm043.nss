#include "_module"
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oTarget = GetLocalObject(oPC,"oTarget");
object oGoldbag = GetItemPossessedBy(oTarget,"goldbag");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");
int iMission;int iFix;int i;

if(GetIsObjectValid(oTarget))
 {
// Object variables
if(iChoice==1)
  {
SendMessageToPC(oPC,"Permanent : "+IntToString(GetLocalInt(oTarget,"Permanent")));
SendMessageToPC(oPC,"Persistent : "+IntToString(GetLocalInt(oTarget,"Persistent")));
SendMessageToPC(oPC,"DontSave : "+IntToString(GetLocalInt(oTarget,"DontSave")));
SendMessageToPC(oPC,"DontSave2 : "+IntToString(GetLocalInt(oTarget,"DontSave2")));

SendMessageToPC(oPC,"Stop : "+IntToString(GetLocalInt(oTarget,"Stop")));
SendMessageToPC(oPC,"Hench : "+IntToString(GetLocalInt(oTarget,"Hench")));
SendMessageToPC(oPC,"HenchNum : "+IntToString(GetLocalInt(oTarget,"HenchNum")));
SendMessageToPC(oPC,"Camp : "+IntToString(GetLocalInt(oTarget,"Camp")));
SendMessageToPC(oPC,"Flee : "+IntToString(GetLocalInt(oTarget,"Flee")));
SendMessageToPC(oPC,"NotFlee : "+IntToString(GetLocalInt(oTarget,"NotFlee")));

SendMessageToPC(oPC,"Master : "+GetLocalString(oTarget,"Master"));
SendMessageToPC(oPC,"Var : "+GetLocalString(oTarget,"Var"));
  }
else if(iChoice==2)
  {
int iValue;int iWear;int iWearTot;object oNew;object oObject= oTarget;
SetLocalInt(oObject,"Wear",999999999);
iValue = GetGoldPieceValue(oObject);if(iValue<iCatA){iWearTot = iWearA;iFix = iFixA;}else if(iValue<iCatB){iWearTot = iWearB;iFix = iFixB;}else if(iValue<iCatC){iWearTot = iWearC;iFix = iFixC;}else if(iValue<iCatD){iWearTot = iWearD;iFix = iFixD;}else{iWearTot = iWearE;iFix = iFixE;}if(GetTag(oObject)=="NW_IT_TORCH001"){iWearTot = iTorch*12;}iWear = GetLocalInt(oObject,"Wear");iWear = 100-(iWear*100/(576*iWearTot));
SetLocalInt(oObject,"Wear%",iWear);
SetLocalInt(oObject,"Fix",iValue*iFix/100);

oNew = CreateItemOnObject("brokenitem",oPC);SetName(oNew,"Broken "+GetName(oObject));SetLocalInt(oNew,"Fix",iValue*iFix/100);SetLocalInt(oNew,"Wear%",100);SetLocalString(oNew,"Master",GetResRef(oObject));SetLocalString(oNew,"Var",GetLocalString(oObject,"Var"));SetLocalString(oNew,"Bonus",GetLocalString(oObject,"Bonus"));SetPlotFlag(oObject,FALSE);DestroyObject(oObject);FloatingTextStringOnCreature("item broken",oPC);
  }
else if(iChoice==3)
  {
i=0;while(i<6){i++;CreateItemOnObject("cr_skinbear",oTarget);}
i=0;while(i<6){i++;CreateItemOnObject("cr_skinherbivore",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_coal",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_copper",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_iron",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_lead",oTarget);}
i=0;while(i<6){i++;CreateItemOnObject("cr_mercury",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_tin",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_woodbasic",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_woodsoft",oTarget);}
i=0;while(i<8){i++;CreateItemOnObject("cr_woodstrong",oTarget);}
i=0;while(i<5){i++;CreateItemOnObject("cr_skinsnake",oTarget);}
i=0;while(i<3){i++;CreateItemOnObject("tool_axe",oTarget);}
i=0;while(i<3){i++;CreateItemOnObject("tool_pick",oTarget);}
i=0;while(i<3){i++;CreateItemOnObject("tool_sickle",oTarget);}
i=0;while(i<6){i++;CreateItemOnObject("cr_skinwolf",oTarget);}
  }
else if(iChoice==4)
  {
iMission = GetLocalInt(oGoldbag,"Missions");
while(iMission>0)
   {
DeleteLocalString(oGoldbag,"Mission"+IntToString(iMission));
iMission--;
   }
DeleteLocalInt(oGoldbag,"Missions");
SendMessageToPC(oPC,GetName(oTarget)+" missions deleted");
  }
else if(iChoice==5)
  {
if(GetLocalString(oTarget,"Bonus")=="Quality"){DeleteLocalString(oTarget,"Bonus");SendMessageToPC(oPC,"Quality variable deleted");}
  }
 }

else
 {
// Area variables
if(iChoice==1)
  {
DeleteLocalString(oArea,"Planet");
DeleteLocalString(oArea,"Area");
DeleteLocalInt(oArea,"Used");
DeleteLocalString(oModule,sPlanet+"_"+sArea);
DeleteLocalString(oModule,GetLocalString(oArea,"Var"));
DeleteLocalString(oModule,"Trans1"+sArea);
DeleteLocalString(oModule,"Trans2"+sArea);
DeleteLocalString(oArea,"Var");
DeleteLocalInt(oArea,"TransType");
DeleteLocalString(oArea,"PlanetType");
DeleteLocalString(oArea,"PlanetOrb");
DeleteLocalString(oArea,"PlanetProv");
DeleteLocalString(oArea,"PlanetDest");
DeleteLocalString(oArea,"AreaProv");
DeleteLocalString(oArea,"AreaDest");
DeleteLocalString(oArea,"AreaExit");
DeleteLocalString(oArea,"Master");
DeleteLocalFloat(oArea,"fXExit");
DeleteLocalFloat(oArea,"fYExit");
DeleteLocalFloat(oArea,"fX");
DeleteLocalFloat(oArea,"fY");
DeleteLocalFloat(oArea,"fZ");
DeleteLocalInt(oArea,"NoCamp");
DeleteLocalInt(oArea,"Bonus");
DeleteLocalInt(oArea,"TransDist");
DeleteLocalInt(oArea,"TimeLeft");
DeleteLocalInt(oArea,"Transports");
DeleteLocalInt(oArea,"Night");
DeleteLocalInt(oArea,"Mountain");
DeleteLocalInt(oArea,"Slot");
DeleteLocalInt(oArea,"Structure");
DeleteLocalInt(oArea,"Level");
DeleteLocalInt(oArea,"Gain");
DeleteLocalInt(oArea,"DomResIni");
DeleteLocalInt(oArea,"DungeonRespawn");
DeleteLocalInt(oArea,"DungeonLevel");
DeleteLocalInt(oArea,"DungeonFamily");
DeleteLocalInt(oArea,"DDLevel");
  }
else if(iChoice==2)
  {
SendMessageToPC(oPC,"Planet : "+GetLocalString(oArea,"Planet"));
SendMessageToPC(oPC,"Area : "+GetLocalString(oArea,"Area"));
SendMessageToPC(oPC,"Used : "+IntToString(GetLocalInt(oArea,"Used")));
SendMessageToPC(oPC,"Module : Planet_Area : "+GetLocalString(oModule,sPlanet+"_"+sArea));
SendMessageToPC(oPC,"Module : Var : "+GetLocalString(oModule,GetLocalString(oArea,"Var")));
SendMessageToPC(oPC,"Trans1 : "+GetLocalString(oModule,"Trans1"+sArea));
SendMessageToPC(oPC,"Trans2 : "+GetLocalString(oModule,"Trans2"+sArea));
SendMessageToPC(oPC,"Var : "+GetLocalString(oArea,"Var"));
SendMessageToPC(oPC,"TransType : "+IntToString(GetLocalInt(oArea,"TransType")));
SendMessageToPC(oPC,"PlanetType : "+GetLocalString(oArea,"PlanetType"));
SendMessageToPC(oPC,"PlanetOrb : "+GetLocalString(oArea,"PlanetOrb"));
SendMessageToPC(oPC,"PlanetProv : "+GetLocalString(oArea,"PlanetProv"));
SendMessageToPC(oPC,"PlanetDest : "+GetLocalString(oArea,"PlanetDest"));
SendMessageToPC(oPC,"AreaProv : "+GetLocalString(oArea,"AreaProv"));
SendMessageToPC(oPC,"AreaDest : "+GetLocalString(oArea,"AreaDest"));
SendMessageToPC(oPC,"AreaExit : "+GetLocalString(oArea,"AreaExit"));
SendMessageToPC(oPC,"Master : "+GetLocalString(oArea,"Master"));
SendMessageToPC(oPC,"fXExit : "+FloatToString(GetLocalFloat(oArea,"fXExit")));
SendMessageToPC(oPC,"fYExit : "+FloatToString(GetLocalFloat(oArea,"fYExit")));
SendMessageToPC(oPC,"NoCamp : "+IntToString(GetLocalInt(oArea,"NoCamp")));
SendMessageToPC(oPC,"Bonus : "+IntToString(GetLocalInt(oArea,"Bonus")));
SendMessageToPC(oPC,"TransDist : "+IntToString(GetLocalInt(oArea,"TransDist")));
SendMessageToPC(oPC,"TimeLeft : "+IntToString(GetLocalInt(oArea,"TimeLeft")));
SendMessageToPC(oPC,"Transports : "+IntToString(GetLocalInt(oArea,"Transports")));
SendMessageToPC(oPC,"Night : "+IntToString(GetLocalInt(oArea,"Night")));
SendMessageToPC(oPC,"Mountain : "+IntToString(GetLocalInt(oArea,"Mountain")));
SendMessageToPC(oPC,"Slot : "+IntToString(GetLocalInt(oArea,"Slot")));
SendMessageToPC(oPC,"Structure : "+IntToString(GetLocalInt(oArea,"Structure")));
SendMessageToPC(oPC,"Level : "+IntToString(GetLocalInt(oArea,"Level")));
SendMessageToPC(oPC,"Gain : "+IntToString(GetLocalInt(oArea,"Gain")));
SendMessageToPC(oPC,"DomResIni : "+IntToString(GetLocalInt(oArea,"DomResIni")));
SendMessageToPC(oPC,"DungeonRespawn : "+IntToString(GetLocalInt(oArea,"DungeonRespawn")));
SendMessageToPC(oPC,"DungeonLevel : "+IntToString(GetLocalInt(oArea,"DungeonLevel")));
SendMessageToPC(oPC,"DungeonFamily : "+IntToString(GetLocalInt(oArea,"DungeonFamily")));
SendMessageToPC(oPC,"DDLevel : "+IntToString(GetLocalInt(oArea,"DDLevel")));
  }
 }
}
