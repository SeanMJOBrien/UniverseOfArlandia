////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
//
object oStructure;string sName;int iLevel;int iNum;int i;
////////////////////////////////////////////////////////////////////////////////
while(i<12){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}i=0;
////////////////////////////////////////////////////////////////////////////////
// Check linked/unlinked structure
if(iChoice1==0)
 {
// Check structures
while(i<9)
  {
i++;
iNum = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(iSlot)+IntToString(i));
oStructure = GetLocalObject(oArea,"StructureFlag"+IntToString(i));
iLevel = StringToInt(GetStringRight(GetName(oStructure),1));

// Linked
if(iNum==1)
   {
     if(GetLocalInt(oStructure,"Structure")==5){sName = "Extractor";}
else if(GetLocalInt(oStructure,"Structure")==6){sName = "Factory";}
else if(GetLocalInt(oStructure,"Structure")==7){sName = "Farm";}
else if(GetLocalInt(oStructure,"Structure")==8){sName = "Field";}
else if(GetLocalInt(oStructure,"Structure")==21){sName = "Sawmill";}
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(10+i));
SetCustomToken(10620+i,"UnLink from "+sName+" (slot "+IntToString(i)+")");
   }
// Not linked
else if(((GetLocalInt(oStructure,"Structure")==5)||(GetLocalInt(oStructure,"Structure")==6)||(GetLocalInt(oStructure,"Structure")==7)||(GetLocalInt(oStructure,"Structure")==8)||(GetLocalInt(oStructure,"Structure")==21))&&(iLevel>=5)&&(i!=iSlot))
   {
     if(GetLocalInt(oStructure,"Structure")==5){sName = "Extractor";}
else if(GetLocalInt(oStructure,"Structure")==6){sName = "Factory";}
else if(GetLocalInt(oStructure,"Structure")==7){sName = "Farm";}
else if(GetLocalInt(oStructure,"Structure")==8){sName = "Field";}
else if(GetLocalInt(oStructure,"Structure")==21){sName = "Sawmill";}
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
SetCustomToken(10610+i,"Link to "+sName+" (slot "+IntToString(i)+")");
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Link/Unlink
else if(iChoice1>0)
 {
if(iChoice1<7)
  {
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(iSlot)+IntToString(iChoice1),1);
oStructure = GetLocalObject(oArea,"StructureFlag"+IntToString(iChoice1));
     if(GetLocalInt(oStructure,"Structure")==5){sName = "Extractor";}
else if(GetLocalInt(oStructure,"Structure")==6){sName = "Factory";}
else if(GetLocalInt(oStructure,"Structure")==7){sName = "Farm";}
else if(GetLocalInt(oStructure,"Structure")==8){sName = "Field";}
else if(GetLocalInt(oStructure,"Structure")==21){sName = "Sawmill";}
FloatingTextStringOnCreature(sName+" on slot "+IntToString(iChoice1)+" linked",oPC);
  }
else
  {
DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(iSlot)+IntToString(iChoice1-10));
oStructure = GetLocalObject(oArea,"StructureFlag"+IntToString(iChoice1));
     if(GetLocalInt(oStructure,"Structure")==5){sName = "Extractor";}
else if(GetLocalInt(oStructure,"Structure")==6){sName = "Factory";}
else if(GetLocalInt(oStructure,"Structure")==7){sName = "Farm";}
else if(GetLocalInt(oStructure,"Structure")==8){sName = "Field";}
else if(GetLocalInt(oStructure,"Structure")==21){sName = "Sawmill";}
FloatingTextStringOnCreature(sName+" on slot "+IntToString(iChoice1)+" unlinked",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
