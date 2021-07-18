#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(oModule,"StorePlanet");
string sArea = GetLocalString(oModule,"StoreArea");
// Area resources
string sTot = GetPersistentString(oModule,sPlanet);
string sPlanetRes = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&005&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&005&")))-FindSubString(sTot,"&004&")-5);
//
int InterestType = GetLocalInt(oModule,"InterestType");
string sVar;int iRandom;
////////////////////////////////////////////////////////////////////////////////
// Stores list prob        Num
// Rocks
int iArmors = 3;        // 3
int iJeweler = 2;       // 6
int iRogues = 1;        // 7
int iWeapons = 3;       // 2
// Trees
int iAnimals = 3;       // 11
int iArchitect = 2;     // 16
int iClothes = 3;       // 8
int iLibrary = 2;       // 9
// Plants
int iAlchemist = 3;     // 5
int iMagic = 2;         // 4
int iTemple = 2;        // 15
int iTrainer = 2;       // 17
// Everywhere
// iBank = 0;           // 10
// iBlacksmith = 0;     // 12
// iGeneral = 0;        // 1
// iInn = 0;            // 13
// iTavern = 0;         // 14
////////////////////////////////////////////////////////////////////////////////
// Choose store
////////////////////////////////////////////////////////////////////////////////
if(InterestType!=0){if(InterestType<10){sVar = "00"+IntToString(InterestType);}else if(InterestType<100){sVar = "0"+IntToString(InterestType);}else{sVar = IntToString(InterestType);}}else{
////////////////////////////////////////////////////////////////////////////////
// Rocks
if(GetStringLeft(sPlanetRes,4)=="rock")
  {
iRandom = Random(iArmors+iJeweler+iRogues+iWeapons)+1;
     if(iRandom<=iArmors){sVar = "003";}
else if(iRandom<=(iArmors+iJeweler)){sVar = "006";}
else if(iRandom<=(iArmors+iJeweler+iRogues)){sVar = "007";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons)){sVar = "002";}
  }
// Trees
else if(GetStringLeft(sPlanetRes,4)=="tree")
  {
iRandom = Random(iAnimals+iArchitect+iClothes+iLibrary)+1;
     if(iRandom<=iAnimals){sVar = "011";}
else if(iRandom<=(iAnimals+iArchitect)){sVar = "016";}
else if(iRandom<=(iAnimals+iArchitect+iClothes)){sVar = "008";}
else if(iRandom<=(iAnimals+iArchitect+iClothes+iLibrary)){sVar = "009";}
  }
// Plants
else if(GetStringLeft(sPlanetRes,5)=="plant")
  {
iRandom = Random(iAlchemist+iMagic+iTemple+iTrainer)+1;
     if(iRandom<=iAlchemist){sVar = "005";}
else if(iRandom<=(iAlchemist+iMagic)){sVar = "004";}
else if(iRandom<=(iAlchemist+iMagic+iTemple)){sVar = "015";}
else if(iRandom<=(iAlchemist+iMagic+iTemple+iTrainer)){sVar = "017";}
  }
// Mix or none
else
  {
iRandom = Random(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iClothes+iLibrary+iAlchemist+iArchitect+iMagic+iTemple+iTrainer)+1;
     if(iRandom<=iArmors){sVar = "003";}
else if(iRandom<=(iArmors+iJeweler)){sVar = "006";}
else if(iRandom<=(iArmors+iJeweler+iRogues)){sVar = "007";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons)){sVar = "002";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals)){sVar = "011";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iArchitect)){sVar = "016";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iArchitect+iClothes)){sVar = "008";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iArchitect+iClothes+iLibrary)){sVar = "009";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iArchitect+iClothes+iLibrary+iAlchemist)){sVar = "005";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iArchitect+iClothes+iLibrary+iAlchemist+iMagic)){sVar = "004";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iArchitect+iClothes+iLibrary+iAlchemist+iMagic+iTemple)){sVar = "015";}
else if(iRandom<=(iArmors+iJeweler+iRogues+iWeapons+iAnimals+iArchitect+iClothes+iLibrary+iAlchemist+iMagic+iTemple+iTrainer)){sVar = "017";}
  }
////////////////////////////////////////////////////////////////////////////////
// Save choosen special store
 }
SetLocalString(oModule,"Var",sVar);
DeleteLocalString(oModule,"StorePlanet");
DeleteLocalString(oModule,"StoreArea");
DeleteLocalInt(oModule,"InterestType");
////////////////////////////////////////////////////////////////////////////////
}
