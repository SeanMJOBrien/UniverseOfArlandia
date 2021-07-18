////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
int iPage = GetLocalInt(OBJECT_SELF,"Page");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
//
string sAreaDest;string sAreaArea;string sName;int iDist;int iPrice;int i;
////////////////////////////////////////////////////////////////////////////////
while(i<10){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);SetCustomToken(10410+i,"");SetCustomToken(10420+i,"");}i=0;
////////////////////////////////////////////////////////////////////////////////
// Airships
if(iChoice1==1)
 {
while(i<10)
  {
i++;
sAreaDest = GetLocalString(OBJECT_SELF,"AirShipDest"+IntToString(iPage*10+i));
sName = GetLocalString(OBJECT_SELF,"AirShipName"+IntToString(iPage*10+i));
iDist = GetLocalInt(OBJECT_SELF,"AirShipLength"+IntToString(iPage*10+i));
iPrice = GetLocalInt(OBJECT_SELF,"AirShipPrice"+IntToString(iPage*10+i));

if(sAreaDest!="")
   {
SetCustomToken(10410+i,sName);
SetCustomToken(10420+i,IntToString(iPrice));
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Starships
else if(iChoice1==2)
 {
while(i<10)
  {
i++;
sAreaDest = GetLocalString(OBJECT_SELF,"StarShipDest"+IntToString(iPage*10+i));
sAreaArea = GetLocalString(OBJECT_SELF,"StarShipArea"+IntToString(iPage*10+i));
sName = GetLocalString(OBJECT_SELF,"StarShipName"+IntToString(iPage*10+i));
iDist = GetLocalInt(OBJECT_SELF,"StarShipLength"+IntToString(iPage*10+i));
iPrice = GetLocalInt(OBJECT_SELF,"StarShipPrice"+IntToString(iPage*10+i));

if(sAreaDest!="")
   {
SetCustomToken(10410+i,sName);
SetCustomToken(10420+i,IntToString(iPrice));
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(OBJECT_SELF,"Page",iPage+1);
////////////////////////////////////////////////////////////////////////////////
}
