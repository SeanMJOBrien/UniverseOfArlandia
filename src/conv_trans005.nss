////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
object oItem = GetFirstItemInInventory(oPC);
string sTag = GetTag(OBJECT_SELF);
//
string sPlanetProv;string sPlanetDest;string sAreaProv;string sAreaDest;string sName;string sVar;int iType;int iDist;int i;
////////////////////////////////////////////////////////////////////////////////
while(i<10){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);DeleteLocalInt(OBJECT_SELF,"Type"+IntToString(i));DeleteLocalString(OBJECT_SELF,"Dest"+IntToString(i));DeleteLocalInt(OBJECT_SELF,"Dist"+IntToString(i));SetCustomToken(10410+i,"");}DeleteLocalInt(OBJECT_SELF,"Choice1");i=0;
////////////////////////////////////////////////////////////////////////////////
while((GetIsObjectValid(oItem))&&(i<10))
 {
sVar = GetLocalString(oItem,"Var");
iType = StringToInt(GetStringLeft(sVar,FindSubString(sVar,"&1&")));
sPlanetProv = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&2&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&2&")))-FindSubString(sVar,"&1&")-3);
sPlanetDest = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&3&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&3&")))-FindSubString(sVar,"&2&")-3);
sAreaProv = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&4&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&4&")))-FindSubString(sVar,"&3&")-3);
sAreaDest = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&5&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&5&")))-FindSubString(sVar,"&4&")-3);
sName = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&6&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&6&")))-FindSubString(sVar,"&5&")-3);
iDist = StringToInt(GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&7&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&7&")))-FindSubString(sVar,"&6&")-3));

if((GetTag(oItem)=="ticket")&&(((sTag=="transport1")&&(sAreaProv==sArea)&&(iType==1))||((sTag=="transport2")&&(sPlanetProv==sPlanet)&&(iType==2))))
  {
i++;
SetLocalInt(OBJECT_SELF,"Type"+IntToString(i),iType);
SetLocalString(OBJECT_SELF,"PlanetProv"+IntToString(i),sPlanetProv);
SetLocalString(OBJECT_SELF,"PlanetDest"+IntToString(i),sPlanetDest);
SetLocalString(OBJECT_SELF,"AreaProv"+IntToString(i),sAreaProv);
SetLocalString(OBJECT_SELF,"AreaDest"+IntToString(i),sAreaDest);
SetLocalInt(OBJECT_SELF,"Dist"+IntToString(i),iDist);
SetLocalObject(OBJECT_SELF,"Ticket"+IntToString(i),oItem);

DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
SetCustomToken(10410+i,sName);
  }
oItem = GetNextItemInInventory(oPC);
 }
////////////////////////////////////////////////////////////////////////////////
}
