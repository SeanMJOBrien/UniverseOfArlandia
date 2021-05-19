#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(oModule,"InterestPlanet");
string sArea = GetLocalString(oModule,"InterestArea");
int iInterestChosen = GetLocalInt(oModule,"InterestChosen");
int InterestType = GetLocalInt(oModule,"InterestType");
//
int i;int j;int k;string sSystem;string sTot2;string sPlanetName;int iPlanetInteresTot;int iPlanetTownProbTo;int iPlanetDungProbTo;int iPlanetCastProbTo;int iPlanetRuinProbTo;int iPlanetAnReProbTo;int iPlanetReMoProbTo;int iPlanetAmusProbTo;string sTot;
j = StringToInt(GetLocalString(oModule,"Systems"));
while(j>0)
 {
sSystem = GetLocalString(oModule,"System"+IntToString(j));
i = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
while(i>0)
  {
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(i));
sPlanetName = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
iPlanetInteresTot = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&021&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&021&")))-FindSubString(sTot,"&020&")-5));
iPlanetTownProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&022&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&022&")))-FindSubString(sTot,"&021&")-5));
iPlanetDungProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&023&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&023&")))-FindSubString(sTot,"&022&")-5));
iPlanetCastProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&024&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&024&")))-FindSubString(sTot,"&023&")-5));
iPlanetRuinProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&025&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&025&")))-FindSubString(sTot,"&024&")-5));
iPlanetAnReProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&026&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&026&")))-FindSubString(sTot,"&025&")-5));
iPlanetReMoProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&027&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&027&")))-FindSubString(sTot,"&026&")-5));
iPlanetAmusProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&028&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&028&")))-FindSubString(sTot,"&027&")-5));

if(sPlanetName==sPlanet){k=1;break;}
i--;
  }
if(k==1){break;}
j--;
 }
//
int iRandomTot;string sInterest;string sName;string sVar;int iDungRand;int iReserveRand1;int iReserveRand2;int iReserveRand3;int iReserveRand4;int iReserveRand5;int iReserveRand6;
int i001;int i002;int i003;int i004;int i005;int i006;int i007;int i008;int i009;int i010;int i011;int i012;int i013;int i014;int i015;int i016;int i017;int i018;int i019;int i020;int i021;int i022;int i023;int i024;int i025;int i026;int i027;int i028;int i029;int i030;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
sInterest = "";sName = "";
////////////////////////////////////////////////////////////////////////////////
// Define interest
     if(iInterestChosen==1){iRandomTot = iPlanetTownProbTo;}
else if(iInterestChosen==2){iRandomTot = iPlanetTownProbTo+iPlanetDungProbTo;}
else if(iInterestChosen==3){iRandomTot = iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo;}
else if(iInterestChosen==4){iRandomTot = iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo;}
else if(iInterestChosen==5){iRandomTot = iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo+iPlanetAnReProbTo;}
else if(iInterestChosen==6){iRandomTot = iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo+iPlanetAnReProbTo+iPlanetReMoProbTo;}
else if(iInterestChosen==7){iRandomTot = iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo+iPlanetAnReProbTo+iPlanetReMoProbTo+iPlanetAmusProbTo;}
else                       {iRandomTot = Random(iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo+iPlanetAnReProbTo+iPlanetReMoProbTo+iPlanetAmusProbTo)+1;}
////////////////////////////////////////////////////////////////////////////////
// Towns (1)
////////////////////////////////////////////////////////////////////////////////
if(iRandomTot<=iPlanetTownProbTo)
 {
sInterest = "1_A_1";
sName = RandomName(NAME_LAST_HUMAN);

SetLocalString(oModule,"StorePlanet",sPlanet);SetLocalString(oModule,"StoreArea",sArea);ExecuteScript("stores",oModule);
sVar = GetLocalString(oModule,"Var");
 }
////////////////////////////////////////////////////////////////////////////////
// Dungeons (2)
////////////////////////////////////////////////////////////////////////////////
else if(iRandomTot<=(iPlanetTownProbTo+iPlanetDungProbTo))
 {
// 1 = Temple
// 2 = Cave + Cliff
// 3 = Pyramid
// 4 = Castle
// 5 = Crypt
// 6 = White tower
// 7 = Black tower
// 8 = Dungeon
iDungRand = Random(8)+1;if(InterestType>0){iDungRand = InterestType;}
//                 Dungeon type                   Dungeon number
sInterest = "2_A_"+IntToString(iDungRand)+"_B_"+IntToString(Random(1)+1)+"_C_";sName = "";sVar = "";
//
 }
////////////////////////////////////////////////////////////////////////////////
// Castles
else if(iRandomTot<=(iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo))
 {
sInterest = "3_A_1";sName = "";sVar = "";
 }
////////////////////////////////////////////////////////////////////////////////
// Ruins
else if(iRandomTot<=(iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo))
 {
sInterest = "4_A_1";sName = "";sVar = "";
 }
////////////////////////////////////////////////////////////////////////////////
// Animals reserves
else if(iRandomTot<=(iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo+iPlanetAnReProbTo))
 {
// Choices made by DM
if(GetLocalInt(oModule,"Choice5")!=0)
  {
iReserveRand2 = GetLocalInt(oModule,"Choice5");if(iReserveRand2!=0){iReserveRand1++;}
iReserveRand3 = GetLocalInt(oModule,"Choice6");if(iReserveRand3!=0){iReserveRand1++;}
iReserveRand4 = GetLocalInt(oModule,"Choice7");if(iReserveRand4!=0){iReserveRand1++;}
iReserveRand5 = GetLocalInt(oModule,"Choice8");if(iReserveRand5!=0){iReserveRand1++;}
iReserveRand6 = GetLocalInt(oModule,"Choice9");if(iReserveRand6!=0){iReserveRand1++;}
  }
else
  {
// Number of full pens
iReserveRand1 = Random(4)+2;
// Animal choices
iReserveRand2 = Random(6)+1;iReserveRand3 = Random(6)+1;iReserveRand4 = Random(6)+1;iReserveRand5 = Random(6)+1;iReserveRand6 = Random(6)+1;
  }
//
sInterest = "5_A_"+IntToString(iReserveRand1)+"_B_"+IntToString(iReserveRand2)+"_C_"+IntToString(iReserveRand3)+"_D_"+IntToString(iReserveRand4)+"_E_"+IntToString(iReserveRand5)+"_F_"+IntToString(iReserveRand6)+"_G_";sName = "";sVar = "";
DeleteLocalInt(oModule,"Choice5");DeleteLocalInt(oModule,"Choice6");DeleteLocalInt(oModule,"Choice7");DeleteLocalInt(oModule,"Choice8");DeleteLocalInt(oModule,"Choice9");
 }
////////////////////////////////////////////////////////////////////////////////
// Resources mountains
else if(iRandomTot<=(iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo+iPlanetAnReProbTo+iPlanetReMoProbTo))
 {
sInterest = "6_A_1";sName = "";sVar = "";
 }
////////////////////////////////////////////////////////////////////////////////
// Amusement places
else if(iRandomTot<=(iPlanetTownProbTo+iPlanetDungProbTo+iPlanetCastProbTo+iPlanetRuinProbTo+iPlanetAnReProbTo+iPlanetReMoProbTo+iPlanetAmusProbTo))
 {
sInterest = "7_A_1";sName = "";sVar = "";
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Save choosen interest
SetLocalString(oModule,"Interest",sInterest);
SetLocalString(oModule,"Name",sName);
SetLocalString(oModule,"Var",sVar);
DeleteLocalString(oModule,"InterestPlanet");
DeleteLocalString(oModule,"InterestArea");
DeleteLocalInt(oModule,"InterestChosen");
DeleteLocalInt(oModule,"InterestType");
////////////////////////////////////////////////////////////////////////////////
}
