#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPlanetDest = GetLocalString(oPC,"PlanetDest");
string sAreaDest = GetLocalString(oPC,"AreaDest");
////////////////////////////////////////////////////////////////////////////////
float fX = GetLocalFloat(oPC,"fX");
float fY = GetLocalFloat(oPC,"fY");
float fFacing = GetLocalFloat(oPC,"fFacing");
string sAreaChosen = GetLocalString(oModule,sPlanetDest+"_"+sAreaDest);
string sNewAreaSpecial = GetLocalString(oPC,"NewAreaSpecial");
int iHenchs = GetLocalInt(oPC,"Henchs");
int iGate = GetLocalInt(oPC,"Gate");
////////////////////////////////////////////////////////////////////////////////
object oTargetArea;object oPlanet;object oHenchs;object oParty;location lLoc;string sTargetArea;string sNewArea;
string sCount1;string sCount2;string sAreaNumber;string sPlanetType;string sAll;string sPlanetPlace;string sPlanetOrb;string sSystem;string sTot;
int iCheck;int iCheck2;int iNewArea;int iParty;int iXP;int iVar;int i;int j;int k;
////////////////////////////////////////////////////////////////////////////////
string sPlanet = GetPersistentString(oModule,sPlanetDest);
int iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sPlanet,FindSubString(sPlanet,"&002&")),GetStringLength(GetStringLeft(sPlanet,FindSubString(sPlanet,"&002&")))-FindSubString(sPlanet,"&001&")-5));
int iPlanetShow = StringToInt(GetStringRight(GetStringLeft(sPlanet,FindSubString(sPlanet,"&005&")),GetStringLength(GetStringLeft(sPlanet,FindSubString(sPlanet,"&005&")))-FindSubString(sPlanet,"&004&")-5));
string sZ = "_";int iM = FindSubString(sAreaDest,sZ)+1;
string sX = GetStringLeft(sAreaDest,iM-1);
string sY = GetStringRight(sAreaDest,GetStringLength(sAreaDest)-iM);
int iX = StringToInt(sX);if(GetStringLeft(sX,1)=="m"){iX = -StringToInt(GetStringRight(sX,GetStringLength(sX)-1));}
int iY = StringToInt(sY);if(GetStringLeft(sY,1)=="m"){iY = -StringToInt(GetStringRight(sY,GetStringLength(sY)-1));}

string sVar = GetPersistentString(oModule,sPlanetDest+"AreasX"+IntToString(iX));

if(iY<=-10){sCount1 = "-"+IntToString(-iY);}else if(iY<0){sCount1 = "-0"+IntToString(-iY);}else if(iY<10){sCount1 = "+0"+IntToString(iY);}else{sCount1 = "+"+IntToString(iY);}sCount1 = "&"+sCount1+"&";
if(iY-1<=-10){sCount2 = "-"+IntToString(-iY+1);}else if(iY-1<0){sCount2 = "-0"+IntToString(-iY+1);}else if(iY-1<10){sCount2 = "+0"+IntToString(iY-1);}else{sCount2 = "+"+IntToString(iY-1);}sCount2 = "&"+sCount2+"&";
if(iY==-iPlanetSize/2){sNewArea = GetStringLeft(sVar,FindSubString(sVar,sCount1));}else{sNewArea = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,sCount1)),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,sCount1)))-FindSubString(sVar,sCount2)-5);}
string sDiscovArea = sNewArea;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Area already used
if(sAreaChosen!="")
 {
iCheck = 1;oTargetArea = GetObjectByTag(sAreaChosen);
 }
////////////////////////////////////////////////////////////////////////////////
// Else pick up area in DB
else
 {
if(GetStringRight(sAreaDest,5)=="_Ship"){sAreaDest = GetStringLeft(sAreaDest,GetStringLength(sAreaDest)-5);}

if(GetStringRight(sDiscovArea,1)=="*")
  {
sNewArea = GetStringLeft(sNewArea,GetStringLength(sNewArea)-1);
  }
////////////////////////////////////////////////////////////////////////////////
// Choose area
// Space
if(sPlanetDest=="Space")
  {
i=0;j=0;
j = StringToInt(GetLocalString(oModule,"Systems"));
while(j>0)
   {
sSystem = GetLocalString(oModule,"System"+IntToString(j));
i = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
while(i>0)
    {
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(i));
sPlanetOrb = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
sPlanetPlace = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5);
sPlanetType = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&004&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&004&")))-FindSubString(sTot,"&003&")-5);

if(sPlanetPlace==sAreaDest){k=1;break;}
i--;
    }
if(k==1){break;}
j--;
   }
if(k==1){sNewArea = "space_"+sPlanetType+"_";}else{sNewArea = "space";}
  }
// Others
else if(sNewAreaSpecial!=""){sNewArea = sNewAreaSpecial;}
else if(sNewArea=="01"){sNewArea = "clouds";}
else if(sNewArea=="02"){sNewArea = "desert";}
else if(sNewArea=="03"){sNewArea = "foothills";}
else if(sNewArea=="04"){sNewArea = "forest";}
else if(sNewArea=="05"){sNewArea = "frozen";}
else if(sNewArea=="06"){sNewArea = "ground";}
else if(sNewArea=="07"){sNewArea = "hills";}
else if(sNewArea=="08"){sNewArea = "moon";}
else if(sNewArea=="09"){sNewArea = "mountain";}
else if(sNewArea=="10"){sNewArea = "mountsnow";}
else if(sNewArea=="11"){sNewArea = "mounts";}
else if(sNewArea=="12"){sNewArea = "ocean";}
else if(sNewArea=="13"){sNewArea = "plain";}
else if(sNewArea=="14"){sNewArea = "river";}
else if(sNewArea=="15"){sNewArea = "rural";}
else if(sNewArea=="16"){sNewArea = "ruralcastle";}
else if(sNewArea=="17"){sNewArea = "ruralswamp";}
else if(sNewArea=="18"){sNewArea = "seafloor";}
else if(sNewArea=="19"){sNewArea = "snow";}
else if(sNewArea=="20"){sNewArea = "swamp";}
else if(sNewArea=="21"){sNewArea = "tropical";}
else if(sNewArea=="22"){sNewArea = "gaz";}
////////////////////////////////////////////////////////////////////////////////
// Check if an area is free
i=0;
while(i<10)
  {
i++;if(i<10){sAreaNumber = "00"+IntToString(i);}else{sAreaNumber = "0"+IntToString(i);}
sTargetArea = sNewArea+sAreaNumber;oTargetArea = GetObjectByTag(sTargetArea);

if((GetIsObjectValid(oTargetArea))&&(GetLocalInt(oTargetArea,"Used")<1))
   {
if(sNewAreaSpecial!=""){sAreaDest = sAreaDest+"_Ship";}

SetLocalInt(oTargetArea,"Used",1);
SetLocalString(oModule,sPlanetDest+"_"+sAreaDest,sTargetArea);
SetLocalString(oTargetArea,"Planet",sPlanetDest);
SetLocalString(oTargetArea,"Area",sAreaDest);
if(k>0){SetLocalString(oTargetArea,"PlanetOrb",sPlanetOrb);SetLocalString(oTargetArea,"PlanetType",sPlanetType);}
if((GetStringLeft(GetTag(oTargetArea),5)!="space")&&(GetStringLeft(GetTag(oTargetArea),10)!="underwater")){ExecuteScript("area_ambiances",oTargetArea);}
iCheck = 2;
break;
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Discover the area
if((!GetIsDM(oPC))&&(!GetIsDMPossessed(oPC)))
 {
if((sPlanetDest=="Space")&&(sPlanet!="")&&(iPlanetShow==0)&&(GetPersistentInt(oModule,"Space"+sAreaDest+"Show")==0))
  {
iNewArea = 1;
SetPersistentInt(oModule,"Space"+sAreaDest+"Show",1);
  }
else if((sPlanetDest!="Space")&&(GetStringRight(sDiscovArea,1)!="*"))
  {
iNewArea = 1;
sVar = InsertString(sVar,"*",FindSubString(sVar,sCount1));
SetPersistentString(oModule,sPlanetDest+"AreasX"+IntToString(iX),sVar);
  }
 }
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
if(iCheck>0)
 {
// Go to ocean
if((!GetIsDM(oPC))&&(!GetIsDMPossessed(oPC))&&(sNewArea=="ocean")&&(GetStringLeft(GetTag(GetArea(oPC)),5)!="ocean"))
  {
object oShip = GetItemPossessedBy(oPC,"ship");if(oShip==OBJECT_INVALID){iCheck2 = 1;FloatingTextStringOnCreature("you need a Ship to undock",oPC);}
object oToolShip = GetItemPossessedBy(oPC,"tool_ship");if(oToolShip==OBJECT_INVALID){iCheck2 = 1;FloatingTextStringOnCreature("you need a Ship Tool to undock",oPC);}
  }

// Check if OK for transition
if(iCheck2!=1)
  {
// Destroy item
if(GetIsObjectValid(GetLocalObject(oPC,"DestroyIt"))){if(GetItemStackSize(GetLocalObject(oPC,"DestroyIt"))>1){SetItemStackSize(GetLocalObject(oPC,"DestroyIt"),GetItemStackSize(GetLocalObject(oPC,"DestroyIt"))-1);}else{DestroyObject(GetLocalObject(oPC,"DestroyIt"));}if(GetItemStackSize(GetLocalObject(oPC,"DestroyIt2"))>1){SetItemStackSize(GetLocalObject(oPC,"DestroyIt2"),GetItemStackSize(GetLocalObject(oPC,"DestroyIt2"))-1);}else{DestroyObject(GetLocalObject(oPC,"DestroyIt2"));}DeleteLocalInt(oPC,"TransMess1");DeleteLocalInt(oPC,"TransMess2");DeleteLocalInt(oPC,"TransMess3");DeleteLocalInt(oPC,"TransMess4");}
// First entry in the area = XPs for the discovering party
if(iNewArea==1){oParty = GetFirstFactionMember(oPC);while(GetIsObjectValid(oParty)){if((GetArea(oParty)==GetArea(oPC))&&(GetDistanceBetween(oPC,oParty)<=50.0)){iParty++;}oParty = GetNextFactionMember(oPC);}iXP = 10/iParty;oParty = GetFirstFactionMember(oPC);while(GetIsObjectValid(oParty)){if((GetArea(oParty)==GetArea(oPC))&&(GetDistanceBetween(oPC,oParty)<=50.0)){SetLocalInt(oParty,"Discover",iXP);}oParty = GetNextFactionMember(oPC);}}
// Henchmen with special transitions
if(iHenchs!=0){if(iHenchs==1){i=0;while(i<iMaxHenchs){i++;oHenchs = GetHenchman(oPC,i);RemoveHenchman(oPC,oHenchs);AssignCommand(oHenchs,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHenchs);}object oFamiliar1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);RemoveSummonedAssociate(oPC,oFamiliar1);AssignCommand(oFamiliar1,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar1);object oFamiliar2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);RemoveSummonedAssociate(oPC,oFamiliar2);AssignCommand(oFamiliar2,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar2);object oFamiliar3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);RemoveSummonedAssociate(oPC,oFamiliar3);AssignCommand(oFamiliar3,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar3);object oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);RemoveSummonedAssociate(oPC,oFamiliar4);AssignCommand(oFamiliar4,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar4);object oFamiliar5 = GetLocalObject(oPC,"Familiar4");AssignCommand(oFamiliar5,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar5);}}
// Lock target area
SetLocalString(oPC,"PlayerAreaTo",GetTag(oTargetArea));
// Jump player
lLoc = Location(oTargetArea,Vector(fX,fY,0.0),fFacing);
SetLocalLocation(oModule,GetName(oPC)+"Loc",lLoc);
if(iGate==1){DelayCommand(4.0,AssignCommand(oPC,ActionJumpToLocation(lLoc)));ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_GATE),oPC);SetXP(oPC,GetXP(oPC)-100);FloatingTextStringOnCreature("gate",oPC);}
else{AssignCommand(oPC,ActionJumpToLocation(lLoc));DeleteLocalInt(oPC,"Gate");}
  }
else if(iCheck==2)
  {
DeleteLocalInt(oTargetArea,"Used");
DeleteLocalString(oModule,sPlanetDest+"_"+sAreaDest);
DeleteLocalString(oTargetArea,"Planet");
DeleteLocalString(oTargetArea,"Area");
  }
 }
else
 {
FloatingTextStringOnCreature("*no area available*",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalString(oPC,"PlanetDest");
DeleteLocalString(oPC,"AreaDest");
DeleteLocalObject(oPC,"DestroyIt");
DeleteLocalObject(oPC,"DestroyIt2");
DeleteLocalString(oPC,"NewAreaSpecial");
DeleteLocalInt(oPC,"Henchs");
////////////////////////////////////////////////////////////////////////////////
}
