#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
// Universe of Arlandia - Galaxy Settings
////////////////////////////////////////////////////////////////////////////////
void main(){
object oModule = GetModule();
string sSystem;string sStartPlanet;string sPlanet;string sPlanetPlace;string sPlanetType;string sPlanetTile1;string sPlanetTile2;string sPlanetTile3;string sPlanetTile4;string sPlanetTile5;string sPlanetCre;string sPlanetRes;string sPlanetAmbi;string sPlanetDescription;string sTot;string sCount;string sCount1;string sCount2;string sVarUniv;string sVarPlanet;string sVarAreas;string sGalaxy;string sNewArea;string sX;string sY;string sArea;string sInterest;string sName;string sVar;string sVar2;string sPlanetName;string sOldArea;string sPlanets;string sSystemCenter;
int iPlanetSize;int iPlanetLevel;int iPlanetShow;int iPlanetCre;int iPlanetRes;int iPlanetTile1ProbTo;int iPlanetTile2ProbTo;int iPlanetTile3ProbTo;int iPlanetTile4ProbTo;int iPlanetTile5ProbTo;int iPlanetTownProbTo;int iPlanetDungProbTo;int iPlanetCastProbTo;int iPlanetRuinProbTo;int iPlanetAnReProbTo;int iPlanetReMoProbTo;int iPlanetAmusProbTo;int iPlanetInteresTot;int i;int j;int iTot;int jTot;int iRandomTot;int iX;int iY;int iCheck;int iVar;int iPlanetVar;
////////////////////////////////////////////////////////////////////////////////





// Constants (don't change) begin



////////////////////////////////////////////////////////////////////////////////
// Systems & Planets
////////////////////////////////////////////////////////////////////////////////
// Constants / Don't change them !
//
// Orb types
string B01 = "b01";                         // Black hole 01
string M01 = "m01";                         // Moon 01
string P01 = "p01";                         // Planet 01
string P02 = "p02";                         // Planet 02
string P03 = "p03";                         // Planet 03
string P04 = "p04";                         // Planet 04
string P05 = "p05";                         // Planet 05
string P06 = "p06";                         // Planet 06
string P07 = "p07";                         // Planet 07
string P08 = "p08";                         // Planet 08
string P09 = "p09";                         // Planet 09
string P10 = "p10";                         // Planet 10
string P11 = "p11";                         // Planet 11
string P12 = "p12";                         // Planet 12
string S01 = "s01";                         // Star 01
string S02 = "s02";                         // Star 02
string S03 = "s03";                         // Star 03
string S04 = "s04";                         // Star 04
// Available areas
string AREAS_CLOUDS = "01";                 // Clouds
string AREAS_DESERT = "02";                 // Desert
string AREAS_FOOTHILLS = "03";              // Foothills
string AREAS_FOREST = "04";                 // Forest
string AREAS_FROZEN_LAND = "05";            // Frozen land
string AREAS_GAZ = "22";                    // Gaz
string AREAS_GROUND = "06";                 // Ground
string AREAS_HILLS = "07";                  // Green hills
string AREAS_MOON = "08";                   // Moon
string AREAS_MOUNTAIN = "09";               // Grey mountain
string AREAS_MOUNTSNOW = "10";              // White mountain
string AREAS_MOUNTS = "11";                 // Green mountain
string AREAS_OCEAN = "12";                  // Ocean
string AREAS_PLAIN = "13";                  // Plain
string AREAS_RIVER = "14";                  // River
string AREAS_RURAL = "15";                  // Rural
string AREAS_RURALCASTLE = "16";            // Rural castle
string AREAS_RURALSWAMP = "17";             // Rural swamp
string AREAS_SEAFLOOR = "18";               // Sea floor
string AREAS_SNOW = "19";                   // Rural snow
string AREAS_SWAMP = "20";                  // Swamp
string AREAS_TROPICAL = "21";               // Tropical
// Available creatures families
string CRE_ = "";                           // creature
// Available resources families
string RES_ = "";                           // resource
// Available ambiances
string AMB_DEMONIA = "amb_demonia";         // ambiance
// For creatures/resources families and ambiances specific to the planet, use :
string SELF = "self";                       // self ambiance
// None
string DEFAULT = "default";                 // Don't change
string NONE = "none";                       // Don't change
////////////////////////////////////////////////////////////////////////////////

// Constants end



// Galaxy/Planets definition begin

////////////////////////////////////////////////////////////////////////////////
// Planets definition // To add a planet copy/paste the last "block" planet and change the variables !
////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////
// System 1  // Copy/Paste systems or planets to add systems/planets
sSystem = "Meth";                                  //*// Name of the system
sSystemCenter = "0_0";                             //*// Position of the center of the system
sStartPlanet = "Arland";                           //*// Starting planet of this system
//
i=0;j++;SetLocalString(oModule,"System"+IntToString(j),sSystem);SetLocalString(oModule,"Systems",IntToString(j));SetLocalString(oModule,sSystem+"Start",sStartPlanet);SetPersistentString(oModule,sSystem+"SystemCenter",sSystemCenter);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Arland";                                //*// Name of the planet
// Position, Type and Size
sPlanetPlace = "0_m12";                            //*// Position of the planet in the galaxy
iPlanetSize  = 40;                                 //*// Square size of the planet (+1)
sPlanetType  = P01;                                //*// Type of planet (see above constants)
iPlanetLevel = 1;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_RURAL;     iPlanetTile1ProbTo = 10;//*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_FOREST;    iPlanetTile2ProbTo = 4; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_RIVER;     iPlanetTile3ProbTo = 1; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = AREAS_HILLS;     iPlanetTile4ProbTo = 1; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = AREAS_MOUNTS;    iPlanetTile5ProbTo = 1; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 12;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 4;                             //*// Interests : total probability of an interest in each area (0% - 100%)
iPlanetTownProbTo = 2;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 6;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 1;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 1;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 2;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 1;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Arland is a peaceful planet with natural vegetation and harmless animals. Most of the newcomers settle in Arland.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Astdin";                                //*// Name of the planet
// Type and Size
sPlanetPlace = "m3_m5";                            //*// Position of the planet in the galaxy
iPlanetSize  = 20;                                 //*// Square size of the planet (+1)
sPlanetType  = P01;                                //*// Type of planet (see above constants)
iPlanetLevel = 4;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_PLAIN;     iPlanetTile1ProbTo = 4; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_FOREST;    iPlanetTile2ProbTo = 2; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_RIVER;     iPlanetTile3ProbTo = 1; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = AREAS_MOUNTAIN;  iPlanetTile4ProbTo = 4; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 10;   //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 3;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 2;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 8;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 1;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 1;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Planet of the Amazons, Astdin is a good place for adventurers who need more rooms for their affairs.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Belvedere";                             //*// Name of the planet
// Type and Size
sPlanetPlace = "0_0";                              //*// Position of the planet in the galaxy
iPlanetSize  = 0;                                  //*// Square size of the planet (+1)
sPlanetType  = S01;                                //*// Type of planet (see above constants)
iPlanetLevel = 0;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = NONE;       iPlanetTile1ProbTo = 0; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = NONE;            iPlanetCre = 0;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = NONE;            iPlanetRes = 0;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = NONE;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 0;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 0;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Brillar";                               //*// Name of the planet
// Type and Size
sPlanetPlace = "m3_4";                             //*// Position of the planet in the galaxy
iPlanetSize  = 20;                                 //*// Square size of the planet (+1)
sPlanetType  = P09;                                //*// Type of planet (see above constants)
iPlanetLevel = 6;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_SEAFLOOR;  iPlanetTile1ProbTo = 6; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_MOUNTAIN;  iPlanetTile2ProbTo = 2; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_SWAMP;     iPlanetTile3ProbTo = 1; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = AREAS_TROPICAL;  iPlanetTile4ProbTo = 1; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 10;   //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 5;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 2;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 3;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "This strange planet was discovered lately by the Naroks. It seems inhabited by golems of new types...";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Delendil";                              //*// Name of the planet
// Type and Size
sPlanetPlace = "m2_m9";                            //*// Position of the planet in the galaxy
iPlanetSize  = 32;                                 //*// Square size of the planet (+1)
sPlanetType  = P02;                                //*// Type of planet (see above constants)
iPlanetLevel = 3;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_PLAIN;     iPlanetTile1ProbTo = 3; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_RIVER;     iPlanetTile2ProbTo = 2; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_OCEAN;     iPlanetTile3ProbTo = 1; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = AREAS_TROPICAL;  iPlanetTile4ProbTo = 1; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 15;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 7;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 5;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 2;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 10;                            //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 2;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 1;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 1;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Delendil is a warm planet due to its special rotation around Belvedere. The vegetation is luxurious and the wildlife is very varied.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Galaxia";                               //*// Name of the planet
// Type and Size
sPlanetPlace = "6_1";                              //*// Position of the planet in the galaxy
iPlanetSize  = 60;                                 //*// Square size of the planet (+1)
sPlanetType  = P04;                                //*// Type of planet (see above constants)
iPlanetLevel = 6;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_RURAL;     iPlanetTile1ProbTo = 4; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_FOREST;    iPlanetTile2ProbTo = 2; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_RIVER;     iPlanetTile3ProbTo = 2; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = AREAS_FOOTHILLS; iPlanetTile4ProbTo = 1; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = AREAS_MOUNTS;    iPlanetTile5ProbTo = 1; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 20;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 10;   //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 4;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 10;                            //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 30;                            //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 2;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 2;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 1;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 3;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 1;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "The biggest planet of the Meth system and its green atmosphere makes it very attractive to many kind of creatures and resources. Some groups have made of Galaxia their operation center, due to the four moons surrounding it. A lot of expedition to the entire system start from Galaxia.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Hinz";                                  //*// Name of the planet
// Type and Size
sPlanetPlace = "4_m7";                             //*// Position of the planet in the galaxy
iPlanetSize  = 16;                                 //*// Square size of the planet (+1)
sPlanetType  = P03;                                //*// Type of planet (see above constants)
iPlanetLevel = 5;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_FROZEN_LAND;iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;            iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;            iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;            iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 7;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 12;   //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 1;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "This planet is totally recovered by ice, because the orbits of the other planets mostly hide the sun from its surface. Though it icy environment, some interesting creatures and resources still can be found.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Kartac";                                //*// Name of the planet
// Type and Size
sPlanetPlace = "3_m15";                            //*// Position of the planet in the galaxy
iPlanetSize  = 26;                                 //*// Square size of the planet (+1)
sPlanetType  = P02;                                //*// Type of planet (see above constants)
iPlanetLevel = 2;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_RURAL;     iPlanetTile1ProbTo = 3; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_FOREST;    iPlanetTile2ProbTo = 6; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_HILLS;     iPlanetTile3ProbTo = 1; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;            iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 6;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 2;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 8;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 1;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Kartac is a mainly forest planet with a few areas without trees. It is a perfect environment for all forest-liking creatures. Most of the Meth wood comes from Kartac.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Khanyo";                                //*// Name of the planet
// Type and Size
sPlanetPlace = "m5_0";                             //*// Position of the planet in the galaxy
iPlanetSize  = 36;                                 //*// Square size of the planet (+1)
sPlanetType  = P07;                                //*// Type of planet (see above constants)
iPlanetLevel = 4;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_OCEAN;     iPlanetTile1ProbTo = 20;//*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_RIVER;     iPlanetTile2ProbTo = 1; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;            iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;            iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 8;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 2;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 30;                            //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 4;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 20;                            //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 1;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 1;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Khanyo is a water planet, holding only a few islands with some interest points. But the biggest richness lays in the underwater.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Mo1";                                   //*// Name of the planet
// Type and Size
sPlanetPlace = "6_0";                              //*// Position of the planet in the galaxy
iPlanetSize  = 10;                                 //*// Square size of the planet (+1)
sPlanetType  = M01;                                //*// Type of planet (see above constants)
iPlanetLevel = 6;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_MOON; iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 8;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 1;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Mo1 is the first of the four Galaxia moons. Like its twin moon Mo2, it hides creatures who had to flee from Galaxia. Rare resources can also be found in its ground.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Mo2";                                   //*// Name of the planet
// Type and Size
sPlanetPlace = "5_1";                              //*// Position of the planet in the galaxy
iPlanetSize  = 10;                                 //*// Square size of the planet (+1)
sPlanetType  = M01;                                //*// Type of planet (see above constants)
iPlanetLevel = 6;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_MOON; iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 8;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 1;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Mo2 is the second of the four Galaxia moons. Like its twin moon Mo1, it hides creatures who had to flee from Galaxia. Rare resources can also be found in its ground.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Mo3";                                   //*// Name of the planet
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Type and Size
sPlanetPlace = "8_1";                              //*// Position of the planet in the galaxy
iPlanetSize  = 16;                                 //*// Square size of the planet (+1)
sPlanetType  = M01;                                //*// Type of planet (see above constants)
iPlanetLevel = 7;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_MOON; iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 10;   //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 3;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 4;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 1;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Mo3 is the third of the four Galaxia moons. It is also, with Ronde, the most dangerous moon around Galaxia. That makes it the prefered destination of the Galaxia residents.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Otun";                                  //*// Name of the planet
// Type and Size
sPlanetPlace = "1_m12";                            //*// Position of the planet in the galaxy
iPlanetSize  = 10;                                 //*// Square size of the planet (+1)
sPlanetType  = M01;                                //*// Type of planet (see above constants)
iPlanetLevel = 2;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_MOON;      iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;            iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;            iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;            iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 6;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 6;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 4;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Otun is the moon of the Arland planet. This quiet asteroid is the second place for all Arland activity. Most of the Arland rocks and special resources come from Otun.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Ozgurbur";                              //*// Name of the planet
// Type and Size
sPlanetPlace = "6_m5";                             //*// Position of the planet in the galaxy
iPlanetSize  = 40;                                 //*// Square size of the planet (+1)
sPlanetType  = P12;                                //*// Type of planet (see above constants)
iPlanetLevel = 5;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_GAZ;       iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;            iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;            iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;            iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 5;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 1;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 5;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Unlike the others, Ozgurbur is the only gas planet in the Meth system. But with some magic spread out in its atmosphere, it is now possible to settle in the clouds of the planet.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Ronde";                                 //*// Name of the planet
// Type and Size
sPlanetPlace = "6_3";                              //*// Position of the planet in the galaxy
iPlanetSize  = 16;                                 //*// Square size of the planet (+1)
sPlanetType  = M01;                                //*// Type of planet (see above constants)
iPlanetLevel = 7;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_MOON; iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 10;   //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 1;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 1;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 6;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Ronde is the fourth moon orbiting around Galaxia. It is mostly known as the 'Wyderl ascendant', as most of the expeditions to the farthest planet of Meth start from this moon instead of Galaxia itself.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Sand";                                  //*// Name of the planet
// Type and Size
sPlanetPlace = "m4_m1";                            //*// Position of the planet in the galaxy
iPlanetSize  = 10;                                 //*// Square size of the planet (+1)
sPlanetType  = M01;                                //*// Type of planet (see above constants)
iPlanetLevel = 4;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_MOON; iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 4;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 4;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 1;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 6;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Sand is the moon of Khanyo. And unlike it, the moon has a solid ground. The Naroks have settled here their main living place.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Tend";                                  //*// Name of the planet
// Type and Size
sPlanetPlace = "6_m9";                             //*// Position of the planet in the galaxy
iPlanetSize  = 40;                                 //*// Square size of the planet (+1)
sPlanetType  = P01;                                //*// Type of planet (see above constants)
iPlanetLevel = 7;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_PLAIN;     iPlanetTile1ProbTo = 10;//*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_RURAL;     iPlanetTile2ProbTo = 10;//*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_FOREST;    iPlanetTile3ProbTo = 5; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = AREAS_RIVER;     iPlanetTile4ProbTo = 2; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = AREAS_HILLS;     iPlanetTile5ProbTo = 1; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 3;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 5;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 2;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Although Tend is similar to Arland, there is a major difference : on Tend only dinosaurs live, and they don't like visitors. No other groups could ever settle on this planet.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Terlation";                             //*// Name of the planet
// Type and Size
sPlanetPlace = "2_m2";                             //*// Position of the planet in the galaxy
iPlanetSize  = 36;                                 //*// Square size of the planet (+1)
sPlanetType  = P08;                                //*// Type of planet (see above constants)
iPlanetLevel = 8;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_DESERT;    iPlanetTile1ProbTo = 20;//*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_TROPICAL;  iPlanetTile2ProbTo = 1; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;            iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;            iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 15;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 1;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 1;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 20;                            //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 3;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 1;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Terlation is the closest planet to the sun Belvedere. It is the hotest planet and its ground is only a waste desert. Known as the origin of the Meth system, now Terlation only holds quite strong creatures who could survive to the extreme climatic conditions.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Washisch";                              //*// Name of the planet
// Type and Size
sPlanetPlace = "9_m3";                             //*// Position of the planet in the galaxy
iPlanetSize  = 30;                                 //*// Square size of the planet (+1)
sPlanetType  = P06;                                //*// Type of planet (see above constants)
iPlanetLevel = 6;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_SNOW;       iPlanetTile1ProbTo = 10;//*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = AREAS_MOUNTSNOW;  iPlanetTile2ProbTo = 7; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = AREAS_FROZEN_LAND;iPlanetTile3ProbTo = 4; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = AREAS_OCEAN;      iPlanetTile4ProbTo = 1; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;             iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 10;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 10;   //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 3;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 1;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 8;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 1;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 1;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 1;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 1;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "This planet has a particularity, in the fact that it got only one season, winter. Always recovered by snow, the planet is, nevertheless, an interesting planet with huge beasts. It is also the home of the Tiklits.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Wyderl";                                //*// Name of the planet
// Type and Size
sPlanetPlace = "9_9";                              //*// Position of the planet in the galaxy
iPlanetSize  = 40;                                 //*// Square size of the planet (+1)
sPlanetType  = P05;                                //*// Type of planet (see above constants)
iPlanetLevel = 9;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_GROUND;iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 7;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 6;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 9;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "Wyderl is the farthest planet of the Meth system. It is the less known planet because only a very few of its visitors ever came back. Known as the planet of the great dragons, no permanent life is possible on its surface due to the magma ground and to the choking atmosphere. However the ground if full of very precious resources. Only a few settlers could create a small base somewhere on the planet.";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////










////////////////////////////////////////////////////////////////////////////////
// System 2  // Copy/Paste systems or planets to add systems/planets
sSystem = "Demonia";                               //*// Name of the system
sSystemCenter = "33_2";                            //*// Position of the center of the system
sStartPlanet = "Alderan";                          //*// Starting planet of this system
//
i=0;j++;SetLocalString(oModule,"System"+IntToString(j),sSystem);SetLocalString(oModule,"Systems",IntToString(j));SetLocalString(oModule,sSystem+"Start",sStartPlanet);SetPersistentString(oModule,sSystem+"SystemCenter",sSystemCenter);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Alderan";                               //*// Name of the planet
// Position, Type and Size
sPlanetPlace = "37_m3";                            //*// Position of the planet in the galaxy
iPlanetSize  = 40;                                 //*// Square size of the planet (+1)
sPlanetType  = P09;                                //*// Type of planet (see above constants)
iPlanetLevel = 1;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_GROUND;iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;        iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;        iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;        iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;        iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 12;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = AMB_DEMONIA;                        //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 3;                             //*// Interests : total probability of an interest in each area (0% - 100%)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 3;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 1;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Beleth";                                //*// Name of the planet
// Position, Type and Size
sPlanetPlace = "31_m2";                            //*// Position of the planet in the galaxy
iPlanetSize  = 30;                                 //*// Square size of the planet (+1)
sPlanetType  = P09;                                //*// Type of planet (see above constants)
iPlanetLevel = 4;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_GROUND;iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;        iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;        iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;        iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;        iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 12;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = AMB_DEMONIA;                        //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 9;                             //*// Interests : total probability of an interest in each area (0% - 100%)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 5;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Eth";                                   //*// Name of the planet
// Position, Type and Size
sPlanetPlace = "33_2";                             //*// Position of the planet in the galaxy
iPlanetSize  = 0;                                  //*// Square size of the planet (+1)
sPlanetType  = S02;                                //*// Type of planet (see above constants)
iPlanetLevel = 0;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = NONE;       iPlanetTile1ProbTo = 0; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;       iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;       iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;       iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;       iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = NONE;            iPlanetCre = 0;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = NONE;            iPlanetRes = 0;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = NONE;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 0;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 0;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 0;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Kah";                                   //*// Name of the planet
// Position, Type and Size
sPlanetPlace = "33_6";                             //*// Position of the planet in the galaxy
iPlanetSize  = 30;                                 //*// Square size of the planet (+1)
sPlanetType  = P08;                                //*// Type of planet (see above constants)
iPlanetLevel = 5;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_DESERT;iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;        iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;        iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;        iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;        iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 12;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = AMB_DEMONIA;                        //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 5;                             //*// Interests : total probability of an interest in each area (0% - 100%)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 3;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Kleth";                                 //*// Name of the planet
// Position, Type and Size
sPlanetPlace = "29_5";                             //*// Position of the planet in the galaxy
iPlanetSize  = 20;                                 //*// Square size of the planet (+1)
sPlanetType  = P09;                                //*// Type of planet (see above constants)
iPlanetLevel = 6;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_GROUND;iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;        iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;        iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;        iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;        iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 12;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = AMB_DEMONIA;                        //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 4;                             //*// Interests : total probability of an interest in each area (0% - 100%)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 1;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Narn";                                  //*// Name of the planet
// Type and Size
sPlanetPlace = "40_1";                             //*// Position of the planet in the galaxy
iPlanetSize  = 10;                                 //*// Square size of the planet (+1)
sPlanetType  = M01;                                //*// Type of planet (see above constants)
iPlanetLevel = 3;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_MOON;      iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;            iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;            iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;            iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;            iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 6;    //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 6;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = SELF;                               //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 2;                             //*// Interests : total probability of an interest in each area (in % 0 - 100)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 4;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 0;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Planet Name
sPlanet = "Sterign";                               //*// Name of the planet
// Position, Type and Size
sPlanetPlace = "38_0";                             //*// Position of the planet in the galaxy
iPlanetSize  = 30;                                 //*// Square size of the planet (+1)
sPlanetType  = P09;                                //*// Type of planet (see above constants)
iPlanetLevel = 2;                                  //*// Planet level (from 1 to 9)
iPlanetShow  = 1;                                  //*// Show planet on Galaxy map (1 = yes, 0 = no)
// Tiles
sPlanetTile1 = AREAS_GROUND;iPlanetTile1ProbTo = 1; //*// Tile 1 : type and probability (starting from 1)
sPlanetTile2 = NONE;        iPlanetTile2ProbTo = 0; //*// Tile 2 : type and probability (starting from Tile 1+1)
sPlanetTile3 = NONE;        iPlanetTile3ProbTo = 0; //*// Tile 3 : type and probability (starting from Tile 1+Tile 2+1)
sPlanetTile4 = NONE;        iPlanetTile4ProbTo = 0; //*// Tile 4 : type and probability (starting from Tile 1+Tile 2+Tile 3+1)
sPlanetTile5 = NONE;        iPlanetTile5ProbTo = 0; //*// Tile 5 : type and probability (starting from Tile 1+Tile 2+Tile 3+Tile 4+1)
// Creatures
sPlanetCre   = SELF;            iPlanetCre = 12;   //*// Creatures family & average number of creatures in each area (+-5)
// Resources
sPlanetRes   = SELF;            iPlanetRes = 8;    //*// Resources family & average number of resources in each area (+-5)
// Ambiance
sPlanetAmbi  = AMB_DEMONIA;                        //*// Ambiance of the planet
// Interests
iPlanetInteresTot = 5;                             //*// Interests : total probability of an interest in each area (0% - 100%)
iPlanetTownProbTo = 0;                             //*// Towns     : probability (added to the others+1)
iPlanetDungProbTo = 2;                             //*// Dungeons  : probability (added to the others+1)
iPlanetCastProbTo = 0;                             //*// Castle  : probability (added to the others+1)
iPlanetRuinProbTo = 3;                             //*// Ruins  : probability (added to the others+1)
iPlanetAnReProbTo = 0;                             //*// Animals reserves : probability (added to the others+1)
iPlanetReMoProbTo = 1;                             //*// Resources mountains  : probability (added to the others+1)
iPlanetAmusProbTo = 0;                             //*// Amusement places  : probability (added to the others+1)
// Planet Description
sPlanetDescription = "";
// Save variables (don't change)
i++;sTot = sPlanet+"&001&"+sPlanetPlace+"&002&"+IntToString(iPlanetSize)+"&003&"+sPlanetType+"&004&"+IntToString(iPlanetShow)+"&005&"+sPlanetTile1+"&006&"+sPlanetTile2+"&007&"+sPlanetTile3+"&008&"+sPlanetTile4+"&009&"+sPlanetTile5+"&010&"+IntToString(iPlanetTile1ProbTo)+"&011&"+IntToString(iPlanetTile2ProbTo)+"&012&"+IntToString(iPlanetTile3ProbTo)+"&013&"+IntToString(iPlanetTile4ProbTo)+"&014&"+IntToString(iPlanetTile5ProbTo)+"&015&"+sPlanetCre+"&016&"+IntToString(iPlanetCre)+"&017&"+sPlanetRes+"&018&"+IntToString(iPlanetRes)+"&019&"+sPlanetAmbi+"&020&"+IntToString(iPlanetInteresTot)+"&021&"+IntToString(iPlanetTownProbTo)+"&022&"+IntToString(iPlanetDungProbTo)+"&023&"+IntToString(iPlanetCastProbTo)+"&024&"+IntToString(iPlanetRuinProbTo)+"&025&"+IntToString(iPlanetAnReProbTo)+"&026&"+IntToString(iPlanetReMoProbTo)+"&027&"+IntToString(iPlanetAmusProbTo)+"&028&"+IntToString(iPlanetLevel)+"&029&"+sPlanetDescription+"&030&";SetLocalString(oModule,sSystem+"Planet"+IntToString(i),sTot);SetLocalString(oModule,sSystem+"Planets",IntToString(i));
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////



// Galaxy/Planets definition end










////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Systems
jTot = StringToInt(GetLocalString(oModule,"Systems"));
//
j=0;
while(j<jTot)
 {
j++;
sSystem = GetLocalString(oModule,"System"+IntToString(j));

if(sSystem!="")
  {
iTot = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
sVarPlanet = "";
i=0;
////////////////////////////////////////////////////////////////////////////////
// Planets
while(i<iTot)
   {
i++;
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(i));
sPlanet = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
sPlanetPlace = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5);
iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&003&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&003&")))-FindSubString(sTot,"&002&")-5));
sPlanetType = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&004&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&004&")))-FindSubString(sTot,"&003&")-5);
iPlanetShow = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&005&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&005&")))-FindSubString(sTot,"&004&")-5));
sPlanetTile1 = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&006&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&006&")))-FindSubString(sTot,"&005&")-5);
sPlanetTile2 = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&007")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&007&")))-FindSubString(sTot,"&006&")-5);
sPlanetTile3 = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&008&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&008&")))-FindSubString(sTot,"&007&")-5);
sPlanetTile4 = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5);
sPlanetTile5 = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&010&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&010&")))-FindSubString(sTot,"&009&")-5);
iPlanetTile1ProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&011&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&011&")))-FindSubString(sTot,"&010&")-5));
iPlanetTile2ProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&012&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&012&")))-FindSubString(sTot,"&011&")-5));
iPlanetTile3ProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&013&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&013&")))-FindSubString(sTot,"&012&")-5));
iPlanetTile4ProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&014&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&014&")))-FindSubString(sTot,"&013&")-5));
iPlanetTile5ProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&015&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&015&")))-FindSubString(sTot,"&014&")-5));
sPlanetCre = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&016&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&016&")))-FindSubString(sTot,"&015&")-5);
iPlanetCre = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&017&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&017&")))-FindSubString(sTot,"&016&")-5));
sPlanetRes = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&018&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&018&")))-FindSubString(sTot,"&017&")-5);
iPlanetRes = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&019&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&019&")))-FindSubString(sTot,"&018&")-5));
sPlanetAmbi = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&020&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&020&")))-FindSubString(sTot,"&019&")-5);
iPlanetInteresTot = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&021&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&021&")))-FindSubString(sTot,"&020&")-5));
iPlanetTownProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&022&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&022&")))-FindSubString(sTot,"&021&")-5));
iPlanetDungProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&023&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&023&")))-FindSubString(sTot,"&022&")-5));
iPlanetCastProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&024&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&024&")))-FindSubString(sTot,"&023&")-5));
iPlanetRuinProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&025&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&025&")))-FindSubString(sTot,"&024&")-5));
iPlanetAnReProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&026&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&026&")))-FindSubString(sTot,"&025&")-5));
iPlanetReMoProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&027&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&027&")))-FindSubString(sTot,"&026&")-5));
iPlanetAmusProbTo = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&028&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&028&")))-FindSubString(sTot,"&027&")-5));
iPlanetLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&029&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&029&")))-FindSubString(sTot,"&028&")-5));
sPlanetDescription = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&030&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&030&")))-FindSubString(sTot,"&029&")-5);
// Planet unique variable
if(sPlanet!=""){SetLocalInt(oModule,sSystem+sPlanet+"OK",1);}
if((sPlanet!="")&&(iPlanetSize<=iPlanetsMaxSize)&&(sTot!=GetPersistentString(oModule,"Space"+sPlanetPlace)))
    {
SetPersistentString(oModule,"Space"+sPlanetPlace,sTot);
DeletePersistentVariable(oModule,sPlanet);SetPersistentString(oModule,sPlanet,sPlanetPlace+"&001&"+IntToString(iPlanetSize)+"&002&"+sPlanetType+"&003&"+sPlanetCre+"&004&"+sPlanetRes+"&005&"+sPlanetAmbi+"&006&"+IntToString(iPlanetCre)+"&007&"+IntToString(iPlanetRes)+"&008&"+IntToString(iPlanetLevel)+"&009&"+sPlanetDescription+"&010&");
if((GetStringLeft(sPlanetType,1)=="m")||(GetStringLeft(sPlanetType,1)=="p"))
     {
////////////////////////////////////////////////////////////////////////////////
// Areas definitions
iX = -(iPlanetSize/2);

while(iX<=(iPlanetSize/2))
      {
iY = -(iPlanetSize/2);

while(iY<=(iPlanetSize/2))
       {
iCheck = 0;sInterest = "";sName = "";sVar = "";
sX = IntToString(iX);if(iX<0){sX = "m"+GetStringRight(IntToString(iX),GetStringLength(IntToString(iX))-1);}
sY = IntToString(iY);if(iY<0){sY = "m"+GetStringRight(IntToString(iY),GetStringLength(IntToString(iY))-1);}
sArea = sX+"_"+sY;

sVar2 = GetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX));

if(iY<=-10){sCount1 = "-"+IntToString(-iY);}else if(iY<0){sCount1 = "-0"+IntToString(-iY);}else if(iY<10){sCount1 = "+0"+IntToString(iY);}else{sCount1 = "+"+IntToString(iY);}sCount1 = "&"+sCount1+"&";
if(iY-1<=-10){sCount2 = "-"+IntToString(-iY+1);}else if(iY-1<0){sCount2 = "-0"+IntToString(-iY+1);}else if(iY-1<10){sCount2 = "+0"+IntToString(iY-1);}else{sCount2 = "+"+IntToString(iY-1);}sCount2 = "&"+sCount2+"&";
if(iY==-iPlanetSize/2){sOldArea = GetStringLeft(sVar2,FindSubString(sVar2,sCount1));}else{sOldArea = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,sCount1)),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,sCount1)))-FindSubString(sVar2,sCount2)-5);}

if(GetStringRight(sOldArea,1)!="*")
        {
////////////////////////////////////////////////////////////////////////////////
// Common areas (random)
     if(sPlanetTile2=="none"){iRandomTot = iPlanetTile1ProbTo;}
else if(sPlanetTile3=="none"){iRandomTot = iPlanetTile1ProbTo+iPlanetTile2ProbTo;}
else if(sPlanetTile4=="none"){iRandomTot = iPlanetTile1ProbTo+iPlanetTile2ProbTo+iPlanetTile3ProbTo;}
else if(sPlanetTile5=="none"){iRandomTot = iPlanetTile1ProbTo+iPlanetTile2ProbTo+iPlanetTile3ProbTo+iPlanetTile4ProbTo;}
else                         {iRandomTot = iPlanetTile1ProbTo+iPlanetTile2ProbTo+iPlanetTile3ProbTo+iPlanetTile4ProbTo+iPlanetTile5ProbTo;}
//
iRandomTot = Random(iRandomTot)+1;
//
     if(iRandomTot<=iPlanetTile1ProbTo){sNewArea = sPlanetTile1;}
else if(iRandomTot<=(iPlanetTile1ProbTo)+(iPlanetTile2ProbTo)){sNewArea = sPlanetTile2;}
else if(iRandomTot<=(iPlanetTile1ProbTo)+(iPlanetTile2ProbTo)+(iPlanetTile3ProbTo)){sNewArea = sPlanetTile3;}
else if(iRandomTot<=(iPlanetTile1ProbTo)+(iPlanetTile2ProbTo)+(iPlanetTile3ProbTo)+(iPlanetTile4ProbTo)){sNewArea = sPlanetTile4;}
else if(iRandomTot<=(iPlanetTile1ProbTo)+(iPlanetTile2ProbTo)+(iPlanetTile3ProbTo)+(iPlanetTile4ProbTo)+(iPlanetTile5ProbTo)){sNewArea = sPlanetTile5;}
////////////////////////////////////////////////////////////////////////////////
// Special areas (define)
// Cities & bases
     if((sPlanet=="Arland")&&(sArea=="0_0")){sNewArea = "citya";sInterest = "1";sName = "Arlandia";sVar = "016";iCheck = 1;}
else if((sNewArea==AREAS_MOON)&&(sArea=="0_0")){iRandomTot = Random(3)+1;if(iRandomTot==1){sNewArea = "citye";}else if(iRandomTot==2){sNewArea = "cityf";}else if(iRandomTot==3){sNewArea = "cityg";}sInterest = "1";sName = RandomName(NAME_LAST_HUMAN);SetLocalString(oModule,"StorePlanet",sPlanet);SetLocalString(oModule,"StoreArea",sArea);ExecuteScript("stores",oModule);sVar = GetLocalString(oModule,"Var");iCheck = 1;}
else if(sArea=="0_0"){if(iPlanetSize>=40){iRandomTot = Random(3)+1;}else{iRandomTot = Random(6)+1;}if(iRandomTot==1){sNewArea = "cityb";}else if(iRandomTot==2){sNewArea = "cityc";}else if(iRandomTot==3){sNewArea = "cityd";}else if(iRandomTot==4){sNewArea = "citye";}else if(iRandomTot==5){sNewArea = "cityf";}else if(iRandomTot==6){sNewArea = "cityg";}sInterest = "1";sName = RandomName(NAME_LAST_HUMAN);SetLocalString(oModule,"StorePlanet",sPlanet);SetLocalString(oModule,"StoreArea",sArea);ExecuteScript("stores",oModule);sVar = GetLocalString(oModule,"Var");iCheck = 1;}
// Defined areas
else if((sPlanet=="Arland")&&((((iX==7)||(iX==12))&&(iY>=0)&&(iY<=2))||((iX>=8)&&(iX<=11)&&(iY>=-1)&&(iY<=3)&&(sArea!="10_1")))){sNewArea = AREAS_OCEAN;sInterest = "";sName = "";sVar = "";}
else if((sPlanet=="Arland")&&((((iX==-12)||(iX==-7))&&(iY>=1)&&(iY<=2))||((iX>=-11)&&(iX<=-8)&&(iY>=1)&&(iY<=3)))){sNewArea = AREAS_FOREST;sInterest = "";sName = "";sVar = "";}

else if((sPlanet=="")&&(sArea=="X_X")){sNewArea = "";sInterest = "";sName = "";sVar = "";}










// Interest
if((iCheck==0)&&(sNewArea!=AREAS_OCEAN)){iRandomTot = Random(100)+1;if(iRandomTot<=iPlanetInteresTot){SetLocalString(oModule,"InterestPlanet",sPlanet);SetLocalString(oModule,"InterestArea",sArea);ExecuteScript("interests",oModule);sInterest = GetLocalString(oModule,"Interest");sName = GetLocalString(oModule,"Name");sVar = GetLocalString(oModule,"Var");}if(sInterest!=""){iCheck = 1;}}
////////////////////////////////////////////////////////////////////////////////
// Areas variable
sCount = IntToString(iY);if(iY<=-10){sCount = "-"+IntToString(-iY);}else if(iY<0){sCount = "-0"+IntToString(-iY);}else if(iY<10){sCount = "+0"+IntToString(iY);}else{sCount = "+"+IntToString(iY);}sCount = "&"+sCount+"&";
sVarAreas = sVarAreas+sNewArea+sCount;
// Store area interests variable
if(iCheck==1){SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests",sInterest+"&1&"+sName+"&2&"+sVar+"&3&1&4&");}else{DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Interests");}
//
        }
iY++;
       }
// Store planet areas variable
SetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX),sVarAreas);sVarAreas = "";
//
iX++;
      }
     }
    }
////////////////////////////////////////////////////////////////////////////////
// Galaxy unique variable (planets in system)
sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "_"+sCount+"_";
sVarPlanet = sVarPlanet+sPlanet+sCount;
   }
////////////////////////////////////////////////////////////////////////////////
// Galaxy unique variable (systems in galaxy)
sCount = IntToString(j);if(j<10){sCount = "00"+IntToString(j);}else if(j<100){sCount = "0"+IntToString(j);}sCount = "&"+sCount+"&";
sVarUniv = sVarUniv+sVarPlanet+"#"+sSystem+"##"+sCount;
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Delete destroyed planets variables
sGalaxy = GetPersistentString(oModule,"Galaxy");
iVar = StringToInt(GetStringLeft(GetStringRight(sGalaxy,4),3));

while(iVar>0)
 {
sCount1 = IntToString(iVar);if(iVar<10){sCount1 = "00"+IntToString(iVar);}else if(iVar<100){sCount1 = "0"+IntToString(iVar);}sCount1 = "&"+sCount1+"&";
sCount2 = IntToString(iVar-1);if((iVar-1)<10){sCount2 = "00"+IntToString(iVar-1);}else if((iVar-1)<100){sCount2 = "0"+IntToString(iVar-1);}sCount2 = "&"+sCount2+"&";
if(iVar==1){sTot = GetStringLeft(sGalaxy,FindSubString(sGalaxy,sCount1));}else{sTot = GetStringRight(GetStringLeft(sGalaxy,FindSubString(sGalaxy,sCount1)),GetStringLength(GetStringLeft(sGalaxy,FindSubString(sGalaxy,sCount1)))-FindSubString(sGalaxy,sCount2)-5);}

sSystem = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"##")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"##")))-FindSubString(sTot,"#")-1);
sPlanets = GetStringLeft(sTot,FindSubString(sTot,"#"));
iPlanetVar = StringToInt(GetStringLeft(GetStringRight(sPlanets,4),3));

while(iPlanetVar>0)
  {
sCount1 = IntToString(iPlanetVar);if(iPlanetVar<10){sCount1 = "00"+IntToString(iPlanetVar);}else if(iPlanetVar<100){sCount1 = "0"+IntToString(iPlanetVar);}sCount1 = "_"+sCount1+"_";
sCount2 = IntToString(iPlanetVar-1);if((iPlanetVar-1)<10){sCount2 = "00"+IntToString(iPlanetVar-1);}else if((iPlanetVar-1)<100){sCount2 = "0"+IntToString(iPlanetVar-1);}sCount2 = "_"+sCount2+"_";
if(iPlanetVar==1){sPlanet = GetStringLeft(sPlanets,FindSubString(sPlanets,sCount1));}else{sPlanet = GetStringRight(GetStringLeft(sPlanets,FindSubString(sPlanets,sCount1)),GetStringLength(GetStringLeft(sPlanets,FindSubString(sPlanets,sCount1)))-FindSubString(sPlanets,sCount2)-5);}

if(GetLocalInt(oModule,sSystem+sPlanet+"OK")!=1)
   {
// Planet does not exist any more. Destroy all variables
sPlanetPlace = GetPersistentString(oModule,sPlanet);
sPlanetPlace = GetStringLeft(sPlanetPlace,FindSubString(sPlanetPlace,"&001&"));

iX = -(iPlanetsMaxSize/2);
while(iX<(iPlanetsMaxSize/2))
    {
iY = -(iPlanetsMaxSize/2);
while(iY<(iPlanetsMaxSize/2))
    {
sX = IntToString(iX);if(iX<0){sX = "m"+GetStringRight(IntToString(iX),GetStringLength(IntToString(iX))-1);}
sY = IntToString(iY);if(iY<0){sY = "m"+GetStringRight(IntToString(iY),GetStringLength(IntToString(iY))-1);}
sArea = sX+"_"+sY;

DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Interests");
iY++;
     }
DeletePersistentVariable(oModule,sPlanet+"AreasX"+IntToString(iX));
iX++;
    }
DeletePersistentVariable(oModule,"Space"+sPlanetPlace);
DeletePersistentVariable(oModule,sPlanet);
   }
iPlanetVar--;
  }
iVar--;
 }
////////////////////////////////////////////////////////////////////////////////
if(sVarUniv!=sGalaxy){SetPersistentString(oModule,"Galaxy",sVarUniv);}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Delete dungeons variables
////////////////////////////////////////////////////////////////////////////////
int iDungeons = GetPersistentInt(oModule,"Dungeons");

while(iDungeons>0)
 {
DeletePersistentVariable(oModule,"Dungeons"+IntToString(iDungeons));
iDungeons--;
 }
DeletePersistentVariable(oModule,"Dungeons");
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
SetPersistentString(oModule,"ShowAreas",IntToString(iShowAreas));
SetPersistentString(oModule,"ShowInterests",IntToString(iShowInterests));
////////////////////////////////////////////////////////////////////////////////
DeleteLocalString(oModule,"Interest");
DeleteLocalString(oModule,"Name");
DeleteLocalString(oModule,"Var");
////////////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////
