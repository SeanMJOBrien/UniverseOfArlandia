////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sSystem = GetLocalString(oModule,sPlanet+"System");
string sPos = GetLocalString(OBJECT_SELF,"Word");
int iRace = GetLocalInt(oGoldbag,"Race");
int iPos = FindSubString(sPos," ")+1;
int iM = FindSubString(sPos,"_")+1;
float fX = 120.0;float fY = 60.0;
//
string sPlanetDest;string sAreaDest;int iX;int iY;;string sX;string sY;int i;int j;int k;string sTot;string sPlanetName;int iPlanetSize;string sPlanetType;
////////////////////////////////////////////////////////////////////////////////
// Planet Area
if(iPos!=0)
 {
sPlanetDest = GetStringLeft(sPos,iPos-1);
sAreaDest = GetStringRight(sPos,GetStringLength(sPos)-iPos);
iM = FindSubString(sAreaDest,"_")+1;
 }
// Area
else if((iPos==0)&&(iM!=0))
 {
sPlanetDest = sPlanet;
sAreaDest = sPos;
 }
// Planet
else
 {
sPlanetDest = sPos;
sAreaDest = "0_0";
iM = FindSubString(sAreaDest,"_")+1;
 }
////////////////////////////////////////////////////////////////////////////////
if(sPlanetDest=="Space")
 {
k = 1;
 }
else
 {
j = StringToInt(GetLocalString(oModule,"Systems"));
while(j>0)
  {
sSystem = GetLocalString(oModule,"System"+IntToString(j));
i = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
while(i>0)
   {
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(i));
sPlanetName = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&003&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&003&")))-FindSubString(sTot,"&002&")-5));
sPlanetType = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&004&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&004&")))-FindSubString(sTot,"&003&")-5);

if((sPlanetName!="")&&(sPlanetName==sPlanetDest)&&((GetStringLeft(sPlanetType,1)=="m")||(GetStringLeft(sPlanetType,1)=="p"))){k = 1;break;}
i--;
   }
if(k==1){break;}
j--;
  }
 }
////////////////////////////////////////////////////////////////////////////////
if(iM==0){k = 0;}
////////////////////////////////////////////////////////////////////////////////
sX = GetStringLeft(sAreaDest,iM-1);
sY = GetStringRight(sAreaDest,GetStringLength(sAreaDest)-iM);
if(GetStringLeft(sX,1)=="m"){iX = -StringToInt(GetStringRight(sX,GetStringLength(sX)-1));}else{iX = StringToInt(sX);}
if(GetStringLeft(sY,1)=="m"){iY = -StringToInt(GetStringRight(sY,GetStringLength(sY)-1));}else{iY = StringToInt(sY);}
if(iX<0){iX = -iX;sX = "m"+IntToString(iX);}else{sX = IntToString(iX);}
if(iY<0){iY = -iY;sY = "m"+IntToString(iY);}else{sY = IntToString(iY);}
sAreaDest = sX+"_"+sY;

if((sPlanetDest!="Space")&&((iX>iPlanetSize/2)||(iY>iPlanetSize/2))){k = 0;}
////////////////////////////////////////////////////////////////////////////////
if((sPlanetDest==sPlanet)&&(sAreaDest==sArea)){k = 0;}
////////////////////////////////////////////////////////////////////////////////
if(k==1)
 {
SetLocalString(oPC,"PlanetDest",sPlanetDest);
SetLocalString(oPC,"AreaDest",sAreaDest);
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",DIRECTION_NORTH);
//
if((iRace==17)||(iRace==19)){SetLocalInt(oPC,"Gate",1);}
ExecuteScript("transitions",oPC);
 }
else
 {
FloatingTextStringOnCreature("*destination invalid*",oPC);
 }
DeleteLocalInt(oPC,"Null");
////////////////////////////////////////////////////////////////////////////////
}
