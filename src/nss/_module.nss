////////////////////////////////////////////////////////////////////////////////
// Module of Arlandia - General Settings
// You can change the values
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Bank
int iAccount =          100;                    //*// Price for opening an account.
int iNormalInterest =   1;                      //*// Normal interest rate per day in %.
int iInvestmentInterest=3;                      //*// Investment interest rate per day in %.
int iInvestmentDelay =  20;                     //*// Investment delay in days until the money can be taken back.
////////////////////////////////////////////////////////////////////////////////
// Challenges
int iMonsterChallenge = 100;                    //*// XPs won or lost in monster challenge (success vs fail).
////////////////////////////////////////////////////////////////////////////////
// Death
int iXPlost =           500;                    //*// XPs lost when a player dies.
int iXPLifePoints =     300;                    //*// XPs lost when a player buy a "Life Point", which can be used to resurect without loosing more xps.
int iXPKilled =         9;                      //*// Constant of the xps gained when killing a creature.
////////////////////////////////////////////////////////////////////////////////
// Domains
int iDomainContainer =  10;                     //*// Max. number of items in each container (x2,x4)
int iDomainExtractor =  24;                     //*// Game hours needed for an extractor to generate 1 resource item.
int iDomainItemCost =   25;                     //*// GP cost for each extractor resource item taken (in % of the item GP value).
int iDomainFactory =    24;                     //*// Game hours needed for a factory to craft 1 item.
int iDomainFacItemCost= 25;                     //*// GP cost for each factory item crafted (in % of the item GP value).
int iDomainFarm =       48;                     //*// Game hours needed for a farm to generate 1 animal.
int iDomainAniCost =    25;                     //*// GP cost for each farm animal taken (in % of the item GP value).
int iDomainField =      12;                     //*// Game hours needed for a field to generate 1 plant.
int iDomainPlantCost =  25;                     //*// GP cost for each field plant taken (in % of the item GP value).
int iDomainSawmill =    24;                     //*// Game hours needed for a sawmill to generate 1 plank of wood.
int iDomainPlankCost =  25;                     //*// GP cost for each sawmill plank taken (in % of the item GP value).

int iDomainCasern =     48;                     //*// Game hours needed for a casern to generate 1 level 1 hench (x2,x3,x5,x7 for level 2 to level 5).

int iDomainGuildMB =    7;                      //*// Domain guild membership expires after iDomainGuildMB days.
int iDomainGuildGP =    500;                    //*// Cost to enter a domain guild.
int iDomainGuildMin =   3;                      //*// There must be min iDomainGuildMin members to apply the bonuses.
int iDomainGuildXP1 =   1;                      //*// XPs bonus at level 1.
int iDomainGuildXP3 =   4;                      //*// XPs bonus at level 3.

int iDomainHouseGP =    500;                    //*// GP rent per month.
int iPCStorageChests =  4;                      //*// Storage chests each ACCOUNT gets (_pcstorage.nss). Contents follow the player, not the house.
int iDomainRentDays =   30;                     //*// Game days a month's house rent buys (see _domainuser.nss's expiry clock).
int iDomainMailItems =  10;                     //*// Max. items a mailbox can contain (out of sent mails).
////////////////////////////////////////////////////////////////////////////////
// Dungeons chests
int iChestFull =        12;                     //*// Treasures chests will be full when less than iChestFull creatures are alive (dungeons).
////////////////////////////////////////////////////////////////////////////////
// Feats
int iCraftingFeat1 =    200;                    //*// XP cost for learning the 1st crafting feat (multiplied by the feat multiplier).
int iCraftingFeat2 =    500;                    //*// XP cost for learning the 2nd crafting feat (multiplied by the feat multiplier).
int iCraftingFeat3 =    1000;                   //*// XP cost for learning the 3rd crafting feat (multiplied by the feat multiplier).
//
int iAlchemistFeat =    5;                      //*// Feat multiplier.
int iAnimalerFeat =     1;                      //*// Feat multiplier.
int iArchitectFeat =    1;                      //*// Feat multiplier.
int iArmorsmithFeat =   8;                      //*// Feat multiplier.
int iBankerFeat =       1;                      //*// Feat multiplier.
int iBlacksmithFeat =   8;                      //*// Feat multiplier.
int iBooksellerFeat =   2;                      //*// Feat multiplier.
int iCasterFeat =       10;                     //*// Feat multiplier.
int iEngineerFeat =     2;                      //*// Feat multiplier.
int iFoodmakerFeat =    2;                      //*// Feat multiplier.
int iHealerFeat =       2;                      //*// Feat multiplier.
int iJewelerFeat =      3;                      //*// Feat multiplier.
int iTailorFeat =       3;                      //*// Feat multiplier.
int iTavernerFeat =     2;                      //*// Feat multiplier.
int iTrainerFeat =      1;                      //*// Feat multiplier.
int iWeaponsmithFeat =  8;                      //*// Feat multiplier.
// Henchs
int iGradeUpgradeGP =   300;                    //*// GPs cost to upgrade the military grade (iGradeUpgradeGP * target grade).
int iGradeUpgradeXP =   1000;                   //*// XPs cost to upgrade the military grade (iGradeUpgradeXP * target grade).
int iMaxHenchs =        99;                     //*// Max number of henchs players can have (max = 99).
int iHenchsPrice =      50;                     //*// Price of non-domain henchs.
int iSoldierLevelUpCost = 100;                  //*// Gold cost per level for a posted Soldier's "Level up" dialog option (conv_hench028/cond_hench028).
int iHenchArmorACBase = 4;                      //*// Max armor AC a level 1-3 henchman may wear (4 = scale mail / chain shirt).
int iHenchArmorACLevels = 3;                    //*// Hit dice per +1 to that cap (so full plate, AC 8, needs level 13).
int iHenchArmorACMax =  8;                      //*// Highest armor AC any henchman may wear (8 = full plate).
int iHenchLevelUpCostPerLevel = 100;            //*// Gold cost per level for the hench level-up dialog option.
int iHenchLevelUpMaxLevel =     20;             //*// Max character level a hired adventurer hench can be leveled up to.
////////////////////////////////////////////////////////////////////////////////
// Inn
int iInn =              10;                     //*// Price of one night sleep at the inn.
////////////////////////////////////////////////////////////////////////////////
// Maps (website)
int iShowAreas =        0;                      //*// 1 = Show the areas totally revealed on the website planet maps.  Qlippoth changed to 1
int iShowInterests =    0;                      //*// 1 = Show the interests on the website planets maps even if not discovered.
////////////////////////////////////////////////////////////////////////////////
// Gold auto-loot (_loot.nss, via loot_gold.nss and treasures.nss)
int iAutoLootGold =     1;                      //*// 1 = Opening a corpse, bodybag, chest or crate hands its gold straight to the player.
int iAutoLootGoldClose = 1;                     //*// 1 = Skip opening the loot window when gold was all a corpse held (corpses only).
string sGoldResRef = "nw_it_gold001";           //*// Blueprint UOA seeds gold with (treasures.nss, creatures_spawn.nss).
int iAutoLootGoldDebug = 1;                     //*// 1 = Log every gold sweep to the server log ("[loot] ..."). Set 0 once the feature is confirmed working.
////////////////////////////////////////////////////////////////////////////////
// Missions
int iMaxMissions =      3;                      //*// Max number of mission a player can take at the same time per plot giver.
int iXPDistBonus =      5;                      //*// XP bonus for each area crossed to accomplish a mission.
int iGPDistBonus =      5;                      //*// GP bonus for each area crossed to accomplish a mission.
////////////////////////////////////////////////////////////////////////////////
// Planets max size
int iPlanetsMaxSize =   100;                    //*// Max size of the planets. Don't increase it above 100 or you may experience troubles !
////////////////////////////////////////////////////////////////////////////////
// Reboot (NWNX2)
int iReboot =           8;                      //*// Reboot server after iReboot real hours. Players will be warned since 30 min before reboot.
////////////////////////////////////////////////////////////////////////////////
// Resting
int iWeight = 20;                                //*// Max weight players can carry on their chest when resting.   Qlippoth changed from 1
int iBedrollBrake =     20;                     //*// Bedroll brake after iBedrollBrake rests.
int iBedrollBrakeProb = 50;                     //*// Probabiliy in % the bedroll brakes.
int iRestBonus =        10;                     //*// Bonus hit points when players sleep with a bedroll.
int iTentRest =         10;                     //*// Hit points bonus in % of the total hit points * level of the tent.
float fTentRest =       5.0;                    //*// Distance max for a player to have bonus hit points when resting near a tent or campfire.
int iTentSmall =        20;                     //*// Max number of uses for the small tent.
int iTentMedium =       40;                     //*// Max number of uses for the medium tent.
int iTentBig =          60;                     //*// Max number of uses for the big tent.
int iFireRest =         20;                     //*// Number of bonus HP players received when resting near a campfire.
////////////////////////////////////////////////////////////////////////////////
// Temple
int iReLevelUp =        100;                    //*// XPs cost to redesign a character from level 1 at a temple.
////////////////////////////////////////////////////////////////////////////////
// Tools
int iGauntletsWear =    100;                    //*// Tool gauntlets will have 1 chance on 10 to break after iGauntletsWear hits
int iToolWear =         60;                     //*// Tools will have 1 chance on 5 to break after iToolWear hits
////////////////////////////////////////////////////////////////////////////////
// Torch
int iTorch =            20;                     //*// Torch burn out after iTorch real minutes.
////////////////////////////////////////////////////////////////////////////////
// Transports
int iAirship1 =         8;                     //*// Hour of the first airship.
int iAirship2 =         14;                     //*// Hour of the second airship.
int iAirship3 =         20;                     //*// Hour of the third airship.
int iAirshipCost =      10;                     //*// GP price for each area crossed with an airship.
int iAirshipSec =       5;                      //*// Seconds of travel for each area crossed with an airship.
//
int iStarship =         12;                     //*// Hour of the starship.
int iStarshipCost =     100;                    //*// GP price for each area crossed with a starship.
int iStarshipDist =     6;                      //*// Max. distance (in areas) a starship can cross.
int iStarshipSec =      60;                     //*// Seconds of travel for each area crossed with a starship.
//
int iStarshipLvl =      6;                      //*// Players must be min. level iStarshipLvl to be able to travel in the Universe (starships or personal starships).
int iStarshipPass =     100;                    //*// Cost of the intergalactical star pass.
//
// Decorative space asteroids (area_resources.nss) are offset by a random
// +/- this many decimetres on Z, so a starfield reads as layered depth rather
// than a flat plane. Re-rolled every time the area populates, which the
// iReady!=1 gate in area_recall.nss makes once per coordinate per server boot.
int iAsteroidJitterZ =  30;                     //*// Max +/- Z offset for decorative space asteroids, in decimetres (30 = +/-3.0m).
//
// Players can name each ship they own (_shipname.nss); the name is meant to
// replace the pilot's own while they are wearing the ship model. That swap is
// OFF until the GetName(oPC) audit in TASK-33 is done: this module keys 96
// lookups on the player's name, including the area-save gate at
// area_exit.nss:19, so renaming a pilot mid-flight silently breaks their
// area saves. Naming, storage and the rename window all work regardless.
// A character may rent at most one house at a time (_domainuser.nss). Nothing
// enforced this before - cond_domain018 only checked the SLOT was free, so one
// character could rent every unrented house in every domain simultaneously.
int iDomainOneRental =  1;                      //*// 1 = a PC may rent only one house at a time. 0 = no limit (the old behaviour).
//
int iShipNameRename =   0;                      //*// 1 = a named ship replaces the pilot's name while in ship form. Needs TASK-33 first.
//
// Personal-flight party cabins (see inc_flight.nss): when a PC pilots their own
// airship/starship, party PCs standing within this radius are boarded into a
// freshly-cloned cabin area and rejoin the pilot via the cabin's hatch.
float fFlightBoardRadius = 12.0;                 //*// Boarding radius (m) for party co-flight.
////////////////////////////////////////////////////////////////////////////////
// UOA references
int iUOAreferences =    30;                     //*// Number of references in the UOA book.
////////////////////////////////////////////////////////////////////////////////
// Wear values
//  Categorie                   Days
int iCatA = 100;            int iWearA = 16;     int iFixA = 50; //*// items with gold value up to iCatA will brake after iWearA days and the fix will cost iFixA % of the item price.
int iCatB = 1500;           int iWearB = 32;    int iFixB = 25; //*// items with gold value up to iCatB will brake after iWearB days and the fix will cost iFixB % of the item price.
int iCatC = 5000;           int iWearC = 64;    int iFixC = 12; //*// items with gold value up to iCatC will brake after iWearC days and the fix will cost iFixC % of the item price.
int iCatD = 20000;          int iWearD = 128;    int iFixD = 6;  //*// items with gold value up to iCatD will brake after iWearD days and the fix will cost iFixD % of the item price.
                            int iWearE = 256;   int iFixE = 3;  //*// items with gold value up to iCatE will brake after iWearE days and the fix will cost iFixE % of the item price.
// Item breaks once its Wear% (remaining condition) drops to this or lower.
// wear.nss used to derive the break point from a formula that folded this
// threshold in implicitly instead of checking it directly - it worked out to
// ~14%/24%/39%/56%/72% remaining for categories A-E respectively (higher-value
// items broke with MORE life left, backwards from the intent), which is why a
// high-value item could snap at 79% remaining with most of its wear budget
// untouched. This constant is the actual, fixed threshold now.
int iWearBreakThreshold = 20; //*// item breaks when Wear% remaining is <= this, for every category.
// wear.nss runs on the module heartbeat, which ticks roughly every 5 real
// seconds - the same cadence iTorch's "iTorch*12" burn-out math above already
// assumes (12 ticks/real minute). Out of combat, only worn armor (the CHEST
// slot) still wears at all; everything else takes none. This is how many of
// those ~5-second ticks make up the 10-minute interval between armor's idle
// wear applications - change iWearIdleArmorMinutes, not this, to retune it.
int iWearIdleArmorMinutes = 10; //*// real minutes between each out-of-combat armor wear tick.
int iWearIdleArmorTicks = iWearIdleArmorMinutes*12;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// References
////////////////////////////////////////////////////////////////////////////////
// Custom token
//
// 10000 - 10050 : Domains
// 10061         : Inn night price
// 10062         : Tavern news
// 10063         : Henchs hiring
// 10064         : Commoner random sentences
// 10065 - 10066 : Domains
// 10067 - 10100 : Message Board
// 10101 - 10110 : Start (galaxy choice)
// 10111 - 10130 : Blacksmith
// 10131 - 10132 : Architect
// 10133 - 10134 : Life Points
// 10135 - 10138 : Bank
// 10139         : Talents
// 10140 - 10170 : Missions
// 10171 - 10174 : Craft feat
// 10175         : Re-Level Up
// 10176         : Card games
// 10181 - 10184 : Grades
// 10186 - 10187 : Custom scroll
// 10201 - 10220 : Wand crafting
// 10311 - 10350 : Crafting
// 10401 - 10410 : Enigms
// 10411 - 10430 : Transports
// 10431 - 10440 : Planet land
// 10451         : Repair Kit
// 10461 - 10470 : Falcon
// 10500 - 10699 : Domain structures
// 20001 - 29999 : DM conv
////////////////////////////////////////////////////////////////////////////////
// Keys
//
// key001 (generic)     : common doors
// key002 (eye)         : traps
// key003 (round)       : treasure doors
// key004 (double-face) :
// key005 (vorpal)      :
// key006 (skeleton)    :
////////////////////////////////////////////////////////////////////////////////
// Items save scripts
//
// area_recall/save
// chestplay_close/open
// henchs
// mail_close/open
// store_close/open
////////////////////////////////////////////////////////////////////////////////

