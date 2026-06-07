#include "aps_include"
#include "_module"
#include "dmfi_dmw_inc"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
//
object oStructure;string sName;string sMes;int iNum;int i;
////////////////////////////////////////////////////////////////////////////////
ExecuteScript("conv_dm_varempty",OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
// Check if structure linked
if(((iStructure>=5)&&(iStructure<=8))||(iStructure==21))
 {
while(i<9)
  {
i++;
iNum = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(iSlot)+IntToString(i));
oStructure = GetLocalObject(oArea,"StructureFlag"+IntToString(i));
if(iNum==1)
   {
     if(GetLocalInt(oStructure,"Structure")==5){sName = "Extractor";}
else if(GetLocalInt(oStructure,"Structure")==6){sName = "Factory";}
else if(GetLocalInt(oStructure,"Structure")==7){sName = "Farm";}
else if(GetLocalInt(oStructure,"Structure")==8){sName = "Field";}
else if(GetLocalInt(oStructure,"Structure")==21){sName = "Sawmill";}

sMes = sMes+"The "+ColorText(sName+" (slot "+IntToString(i)+")","g")+" is linked to this Factory (Master).\n\n";
   }
  }
i=0;
while(i<9)
  {
i++;
iNum = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(i)+IntToString(iSlot));
oStructure = GetLocalObject(oArea,"StructureFlag"+IntToString(i));
if(iNum==1)
   {
sMes = sMes+"This structure is linked to the "+ColorText("Factory (slot "+IntToString(i)+")","r")+" (Slave).\n\n";
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
if(sMes==""){sMes = "No special information";}
////////////////////////////////////////////////////////////////////////////////
if(iStructure==1){DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");SetCustomToken(10500,"Airship :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);}
if(iStructure==2){DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");SetCustomToken(10500,"Amusement Place :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);}
if(iStructure==3){DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");SetCustomToken(10500,"Casern :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);}
if(iStructure==4){DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");SetCustomToken(10500,"Dungeon :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone4",1);}
if(iStructure==5){DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");SetCustomToken(10500,"Extractor :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}
if(iStructure==6){DeleteLocalInt(OBJECT_SELF,"ChoiceDone6");SetCustomToken(10500,"Factory :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone6",1);}
if(iStructure==7){DeleteLocalInt(OBJECT_SELF,"ChoiceDone7");SetCustomToken(10500,"Farm :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone7",1);}
if(iStructure==8){DeleteLocalInt(OBJECT_SELF,"ChoiceDone8");SetCustomToken(10500,"Field :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone8",1);}
if(iStructure==9){DeleteLocalInt(OBJECT_SELF,"ChoiceDone9");SetCustomToken(10500,"Guild :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone9",1);}
if(iStructure==10){DeleteLocalInt(OBJECT_SELF,"ChoiceDone10");SetCustomToken(10500,"Hall :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone10",1);}
if(iStructure==11){DeleteLocalInt(OBJECT_SELF,"ChoiceDone11");SetCustomToken(10500,"House :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone11",1);}
if(iStructure==12){DeleteLocalInt(OBJECT_SELF,"ChoiceDone12");SetCustomToken(10500,"Inn :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone12",1);}
if(iStructure==13){DeleteLocalInt(OBJECT_SELF,"ChoiceDone13");SetCustomToken(10500,"Mission Office :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone13",1);}
if(iStructure==14){DeleteLocalInt(OBJECT_SELF,"ChoiceDone14");SetCustomToken(10500,"Personal House :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone14",1);}
if(iStructure==15){DeleteLocalInt(OBJECT_SELF,"ChoiceDone15");SetCustomToken(10500,"School :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone15",1);}
if(iStructure==16){DeleteLocalInt(OBJECT_SELF,"ChoiceDone16");SetCustomToken(10500,"Shop :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone16",1);}
if(iStructure==17){DeleteLocalInt(OBJECT_SELF,"ChoiceDone17");SetCustomToken(10500,"Starship :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone17",1);}
if(iStructure==18){DeleteLocalInt(OBJECT_SELF,"ChoiceDone18");SetCustomToken(10500,"Tavern :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone18",1);}
if(iStructure==19){DeleteLocalInt(OBJECT_SELF,"ChoiceDone19");SetCustomToken(10500,"Temple :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone19",1);}
if(iStructure==20){DeleteLocalInt(OBJECT_SELF,"ChoiceDone20");SetCustomToken(10500,"Tower :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone20",1);}
if(iStructure==21){DeleteLocalInt(OBJECT_SELF,"ChoiceDone21");SetCustomToken(10500,"Sawmill :\n\n"+sMes);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone21",1);}
////////////////////////////////////////////////////////////////////////////////
if((iStructure==5)||(iStructure==6)||(iStructure==7)||(iStructure==8)||(iStructure==11)||(iStructure==21)){ExecuteScript("domain_content",OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
}
