#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oObjects = GetFirstObjectInArea(oArea);
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
location lLoc;int i;
////////////////////////////////////////////////////////////////////////////////
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterestType = GetStringLeft(sInterest,FindSubString(sInterest,"&1&"));
string sMaster = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")))-FindSubString(sInterest,"&1&")-3);
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
string sVisible = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")))-FindSubString(sInterest,"&3&")-3);
// Slots
string sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_01_"));
string sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_02_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_02_")))-FindSubString(sVar,"_01_")-4);
string sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_03_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_03_")))-FindSubString(sVar,"_02_")-4);
string sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_04_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_04_")))-FindSubString(sVar,"_03_")-4);
string sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_05_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_05_")))-FindSubString(sVar,"_04_")-4);
string sVar6 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_06_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_06_")))-FindSubString(sVar,"_05_")-4);
string sVar7 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_07_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_07_")))-FindSubString(sVar,"_06_")-4);
string sVar8 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_08_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_08_")))-FindSubString(sVar,"_07_")-4);
string sVar9 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_09_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_09_")))-FindSubString(sVar,"_08_")-4);
string sVar10 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_10_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_10_")))-FindSubString(sVar,"_09_")-4);
string sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
// Types & Levels
string sVar1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));string sVar1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);
string sVar2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));string sVar2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);
string sVar3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));string sVar3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);
string sVar4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));string sVar4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);
string sVar5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));string sVar5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);
string sVar6L = GetStringLeft(sVar6,FindSubString(sVar6,"%"));string sVar6R = GetStringRight(sVar6,GetStringLength(sVar6)-FindSubString(sVar6,"%")-1);
string sVar7L = GetStringLeft(sVar7,FindSubString(sVar7,"%"));string sVar7R = GetStringRight(sVar7,GetStringLength(sVar7)-FindSubString(sVar7,"%")-1);
string sVar8L = GetStringLeft(sVar8,FindSubString(sVar8,"%"));string sVar8R = GetStringRight(sVar8,GetStringLength(sVar8)-FindSubString(sVar8,"%")-1);
string sVar9L = GetStringLeft(sVar9,FindSubString(sVar9,"%"));string sVar9R = GetStringRight(sVar9,GetStringLength(sVar9)-FindSubString(sVar9,"%")-1);
string sVar10L = GetStringLeft(sVar10,FindSubString(sVar10,"%"));string sVar10R = GetStringRight(sVar10,GetStringLength(sVar10)-FindSubString(sVar10,"%")-1);
//
string sS;
////////////////////////////////////////////////////////////////////////////////
ExecuteScript("starship_destroy",OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
     if(iChoice2==1){sVar1 = "%";}
else if(iChoice2==2){sVar2 = "%";}
else if(iChoice2==3){sVar3 = "%";}
else if(iChoice2==4){sVar4 = "%";}
else if(iChoice2==5){sVar5 = "%";}
else if(iChoice2==6){sVar6 = "%";}
else if(iChoice2==7){sVar7 = "%";}
else if(iChoice2==8){sVar8 = "%";}
else if(iChoice2==9){sVar9 = "%";}
else if(iChoice2==10){sVar10 = "%";}

sVar = sVar1+"_01_"+sVar2+"_02_"+sVar3+"_03_"+sVar4+"_04_"+sVar5+"_05_"+sVar6+"_06_"+sVar7+"_07_"+sVar8+"_08_"+sVar9+"_09_"+sVar10+"_10_"+sVar11+"_11_";
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests",sInterestType+"&1&"+sMaster+"&2&"+sVar+"&3&"+sVisible+"&4&");
DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iChoice2));
DeleteLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iChoice2));
DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iChoice2)+"Counter");
DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iChoice2));
DeleteLocalInt(oGoldbag,sPlanet+"&BoardPriv");
while(i<9){i++;DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iChoice2)+"Counter"+IntToString(i));DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(iChoice2)+IntToString(i));}
////////////////////////////////////////////////////////////////////////////////
while(GetIsObjectValid(oObjects))
  {
if((GetLocalInt(oObjects,"Hench")==0)&&(GetLocalInt(oObjects,"Slot")==iChoice2))
   {
lLoc = GetLocation(oObjects);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);
SetImmortal(oObjects,FALSE);
SetPlotFlag(oObjects,FALSE);
AssignCommand(oObjects,SetIsDestroyable(TRUE,FALSE,FALSE));
DestroyObject(oObjects);
   }
oObjects = GetNextObjectInArea(oArea);
  }
////////////////////////////////////////////////////////////////////////////////
}
