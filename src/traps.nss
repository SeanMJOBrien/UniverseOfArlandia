#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sTot = GetPersistentString(oModule,sPlanet);
string sLeftTag = GetStringLeft(GetTag(OBJECT_SELF),5);
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));
if(sLeftTag=="chest"){iLevel = StringToInt(GetStringRight(GetTag(OBJECT_SELF),1));}
//
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;
//
int iRand;int i;int iTot;object oTrap;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Traps level 1-2
if(iLevel<3){iTot = Random(10)+1;if(sLeftTag=="chest"){if(Random(2)==1){SetLocked(OBJECT_SELF,TRUE);}if(Random(2)==1){iTot = 1;}else{iTot = 0;}}while(iTot>0){iTot--;
////////////////////////////////////////////////////////////////////////////////
iRand = Random(11)+1; // Probability of the traps
////////////////////////////////////////////////////////////////////////////////
     if(iRand==1) {i = TRAP_BASE_TYPE_MINOR_ACID;}
else if(iRand==2) {i = TRAP_BASE_TYPE_MINOR_ACID_SPLASH;}
else if(iRand==3) {i = TRAP_BASE_TYPE_MINOR_ELECTRICAL;}
else if(iRand==4) {i = TRAP_BASE_TYPE_MINOR_FIRE;}
else if(iRand==5) {i = TRAP_BASE_TYPE_MINOR_FROST;}
else if(iRand==6) {i = TRAP_BASE_TYPE_MINOR_GAS;}
else if(iRand==7) {i = TRAP_BASE_TYPE_MINOR_HOLY;}
else if(iRand==8) {i = TRAP_BASE_TYPE_MINOR_NEGATIVE;}
else if(iRand==9) {i = TRAP_BASE_TYPE_MINOR_SONIC;}
else if(iRand==10){i = TRAP_BASE_TYPE_MINOR_SPIKE;}
else if(iRand==11){i = TRAP_BASE_TYPE_MINOR_TANGLE;}
////////////////////////////////////////////////////////////////////////////////
if(sLeftTag=="chest"){CreateTrapOnObject(i,OBJECT_SELF,STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(OBJECT_SELF,"key002");}else{oTrap = CreateTrapAtLocation(i,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),DIRECTION_SOUTH),2.0,"",STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(oTrap,"key002");}}}
////////////////////////////////////////////////////////////////////////////////
// Traps level 3-4
else if(iLevel<5){iTot = Random(20)+1;if(sLeftTag=="chest"){if(Random(2)==1){SetLocked(OBJECT_SELF,TRUE);}if(Random(2)==1){iTot = 1;}else{iTot = 0;}}while(iTot>0){iTot--;
////////////////////////////////////////////////////////////////////////////////
iRand = Random(11)+1; // Probability of the traps
////////////////////////////////////////////////////////////////////////////////
     if(iRand==1) {i = TRAP_BASE_TYPE_AVERAGE_ACID;}
else if(iRand==2) {i = TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH;}
else if(iRand==3) {i = TRAP_BASE_TYPE_AVERAGE_ELECTRICAL;}
else if(iRand==4) {i = TRAP_BASE_TYPE_AVERAGE_FIRE;}
else if(iRand==5) {i = TRAP_BASE_TYPE_AVERAGE_FROST;}
else if(iRand==6) {i = TRAP_BASE_TYPE_AVERAGE_GAS;}
else if(iRand==7) {i = TRAP_BASE_TYPE_AVERAGE_HOLY;}
else if(iRand==8) {i = TRAP_BASE_TYPE_AVERAGE_NEGATIVE;}
else if(iRand==9) {i = TRAP_BASE_TYPE_AVERAGE_SONIC;}
else if(iRand==10){i = TRAP_BASE_TYPE_AVERAGE_SPIKE;}
else if(iRand==11){i = TRAP_BASE_TYPE_AVERAGE_TANGLE;}
////////////////////////////////////////////////////////////////////////////////
if(sLeftTag=="chest"){CreateTrapOnObject(i,OBJECT_SELF,STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(OBJECT_SELF,"key002");}else{oTrap = CreateTrapAtLocation(i,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),DIRECTION_SOUTH),2.0,"",STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(oTrap,"key002");}}}
////////////////////////////////////////////////////////////////////////////////
// Traps level 5-6
else if(iLevel<7){iTot = Random(30)+1;if(sLeftTag=="chest"){if(Random(2)==1){SetLocked(OBJECT_SELF,TRUE);}if(Random(2)==1){iTot = 1;}else{iTot = 0;}}while(iTot>0){iTot--;
////////////////////////////////////////////////////////////////////////////////
iRand = Random(11)+1; // Probability of the traps
////////////////////////////////////////////////////////////////////////////////
     if(iRand==1) {i = TRAP_BASE_TYPE_STRONG_ACID;}
else if(iRand==2) {i = TRAP_BASE_TYPE_STRONG_ACID_SPLASH;}
else if(iRand==3) {i = TRAP_BASE_TYPE_STRONG_ELECTRICAL;}
else if(iRand==4) {i = TRAP_BASE_TYPE_STRONG_FIRE;}
else if(iRand==5) {i = TRAP_BASE_TYPE_STRONG_FROST;}
else if(iRand==6) {i = TRAP_BASE_TYPE_STRONG_GAS;}
else if(iRand==7) {i = TRAP_BASE_TYPE_STRONG_HOLY;}
else if(iRand==8) {i = TRAP_BASE_TYPE_STRONG_NEGATIVE;}
else if(iRand==9) {i = TRAP_BASE_TYPE_STRONG_SONIC;}
else if(iRand==10){i = TRAP_BASE_TYPE_STRONG_SPIKE;}
else if(iRand==11){i = TRAP_BASE_TYPE_STRONG_TANGLE;}
////////////////////////////////////////////////////////////////////////////////
if(sLeftTag=="chest"){CreateTrapOnObject(i,OBJECT_SELF,STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(OBJECT_SELF,"key002");}else{oTrap = CreateTrapAtLocation(i,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),DIRECTION_SOUTH),2.0,"",STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(oTrap,"key002");}}}
////////////////////////////////////////////////////////////////////////////////
// Traps level 7-8
else if(iLevel<9){iTot = Random(40)+1;if(sLeftTag=="chest"){if(Random(2)==1){SetLocked(OBJECT_SELF,TRUE);}if(Random(2)==1){iTot = 1;}else{iTot = 0;}}while(iTot>0){iTot--;
////////////////////////////////////////////////////////////////////////////////
iRand = Random(11)+1; // Probability of the traps
////////////////////////////////////////////////////////////////////////////////
     if(iRand==1) {i = TRAP_BASE_TYPE_DEADLY_ACID;}
else if(iRand==2) {i = TRAP_BASE_TYPE_DEADLY_ACID_SPLASH;}
else if(iRand==3) {i = TRAP_BASE_TYPE_DEADLY_ELECTRICAL;}
else if(iRand==4) {i = TRAP_BASE_TYPE_DEADLY_FIRE;}
else if(iRand==5) {i = TRAP_BASE_TYPE_DEADLY_FROST;}
else if(iRand==6) {i = TRAP_BASE_TYPE_DEADLY_GAS;}
else if(iRand==7) {i = TRAP_BASE_TYPE_DEADLY_HOLY;}
else if(iRand==8) {i = TRAP_BASE_TYPE_DEADLY_NEGATIVE;}
else if(iRand==9) {i = TRAP_BASE_TYPE_DEADLY_SONIC;}
else if(iRand==10){i = TRAP_BASE_TYPE_DEADLY_SPIKE;}
else if(iRand==11){i = TRAP_BASE_TYPE_DEADLY_TANGLE;}
////////////////////////////////////////////////////////////////////////////////
if(sLeftTag=="chest"){CreateTrapOnObject(i,OBJECT_SELF,STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(OBJECT_SELF,"key002");}else{oTrap = CreateTrapAtLocation(i,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),DIRECTION_SOUTH),2.0,"",STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(oTrap,"key002");}}}
////////////////////////////////////////////////////////////////////////////////
// Traps level 9
else if(iLevel==9){iTot = Random(50)+1;if(sLeftTag=="chest"){if(Random(2)==1){SetLocked(OBJECT_SELF,TRUE);}if(Random(2)==1){iTot = 1;}else{iTot = 0;}}while(iTot>0){iTot--;
////////////////////////////////////////////////////////////////////////////////
iRand = Random(4)+1; // Probability of the traps
////////////////////////////////////////////////////////////////////////////////
     if(iRand==1){i = TRAP_BASE_TYPE_EPIC_ELECTRICAL;}
else if(iRand==2){i = TRAP_BASE_TYPE_EPIC_FIRE;}
else if(iRand==3){i = TRAP_BASE_TYPE_EPIC_FROST;}
else if(iRand==4){i = TRAP_BASE_TYPE_EPIC_SONIC;}
////////////////////////////////////////////////////////////////////////////////
if(sLeftTag=="chest"){CreateTrapOnObject(i,OBJECT_SELF,STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(OBJECT_SELF,"key002");}else{oTrap = CreateTrapAtLocation(i,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),DIRECTION_SOUTH),2.0,"",STANDARD_FACTION_HOSTILE,"unlock_disarm");SetTrapKeyTag(oTrap,"key002");}}}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(OBJECT_SELF,"Level");
////////////////////////////////////////////////////////////////////////////////
}
