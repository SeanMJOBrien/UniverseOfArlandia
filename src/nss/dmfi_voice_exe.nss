//DMFI Voice script
#include "dmfi_db_inc"
#include "dmfi_lang_inc"

int AppearType (string sCom)
{
if (sCom == "ARANEA")
    return APPEARANCE_TYPE_ARANEA;
if (sCom == "ALLIP")
    return APPEARANCE_TYPE_ALLIP;
if (sCom == "ARCH_TARGET")
    return APPEARANCE_TYPE_ARCH_TARGET;
if (sCom == "ARIBETH")
    return APPEARANCE_TYPE_ARIBETH;
if (sCom == "ASABI_CHIEFTAIN")
    return APPEARANCE_TYPE_ASABI_CHIEFTAIN;
if (sCom == "ASABI_SHAMAN")
    return APPEARANCE_TYPE_ASABI_SHAMAN;
if (sCom == "ASABI_WARRIOR")
    return APPEARANCE_TYPE_ASABI_WARRIOR;
if (sCom == "BADGER")
    return APPEARANCE_TYPE_BADGER;
if (sCom == "BADGER_DIRE")
    return APPEARANCE_TYPE_BADGER_DIRE;
if (sCom == "BALOR")
    return APPEARANCE_TYPE_BALOR;
if (sCom == "BARTENDER")
    return APPEARANCE_TYPE_BARTENDER;
if (sCom == "BASILISK")
    return APPEARANCE_TYPE_BASILISK;
if (sCom == "BAT")
    return APPEARANCE_TYPE_BAT;
if (sCom == "BAT_HORROR")
    return APPEARANCE_TYPE_BAT_HORROR;
if (sCom == "BEAR_BLACK")
    return APPEARANCE_TYPE_BEAR_BLACK;
if (sCom == "BEAR_BROWN")
    return APPEARANCE_TYPE_BEAR_BROWN;
if (sCom == "BEAR_DIRE")
    return APPEARANCE_TYPE_BEAR_DIRE;
if (sCom == "BEAR_KODIAK")
    return APPEARANCE_TYPE_BEAR_KODIAK;
if (sCom == "BEAR_POLAR")
    return APPEARANCE_TYPE_BEAR_POLAR;
if (sCom == "BEETLE_FIRE")
    return APPEARANCE_TYPE_BEETLE_FIRE;
if (sCom == "BEETLE_SLICER")
    return APPEARANCE_TYPE_BEETLE_SLICER;
if (sCom == "BEETLE_STAG")
    return APPEARANCE_TYPE_BEETLE_STAG;
if (sCom == "BEETLE_STINK")
    return APPEARANCE_TYPE_BEETLE_STINK;
if (sCom == "BEGGER")
    return APPEARANCE_TYPE_BEGGER;
if (sCom == "BLOOD_SAILER")
    return APPEARANCE_TYPE_BLOOD_SAILER;
if (sCom == "BOAR")
    return APPEARANCE_TYPE_BOAR;
if (sCom == "BOAR_DIRE")
    return APPEARANCE_TYPE_BOAR_DIRE;
if (sCom == "BODAK")
    return APPEARANCE_TYPE_BODAK;
if (sCom == "BUGBEAR_A")
    return APPEARANCE_TYPE_BUGBEAR_A;
if (sCom == "BUGBEAR_B")
    return APPEARANCE_TYPE_BUGBEAR_B;
if (sCom == "BUGBEAR_CHIEFTAIN_A")
    return APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_A;
if (sCom == "BUGBEAR_CHIEFTAIN_B")
    return APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_B;
if (sCom == "BUGBEAR_SHAMAN_A")
    return APPEARANCE_TYPE_BUGBEAR_SHAMAN_A;
if (sCom == "BUGBEAR_SHAMAN_B")
    return APPEARANCE_TYPE_BUGBEAR_SHAMAN_B;
if (sCom == "CAT_CAT_DIRE")
    return APPEARANCE_TYPE_CAT_CAT_DIRE;
if (sCom == "CAT_COUGAR")
    return APPEARANCE_TYPE_CAT_COUGAR;
if (sCom == "CAT_CRAG_CAT")
    return APPEARANCE_TYPE_CAT_CRAG_CAT;
if (sCom == "CAT_JAGUAR")
    return APPEARANCE_TYPE_CAT_JAGUAR;
if (sCom == "CAT_KRENSHAR")
    return APPEARANCE_TYPE_CAT_KRENSHAR;
if (sCom == "CAT_LEOPARD")
    return APPEARANCE_TYPE_CAT_LEOPARD;
if (sCom == "CAT_LION")
    return APPEARANCE_TYPE_CAT_LION;
if (sCom == "CAT_MPANTHER")
    return APPEARANCE_TYPE_CAT_MPANTHER;
if (sCom == "CAT_PANTHER")
    return APPEARANCE_TYPE_CAT_PANTHER;
if (sCom == "CHICKEN")
    return APPEARANCE_TYPE_CHICKEN;
if (sCom == "COCKATRICE")
    return APPEARANCE_TYPE_COCKATRICE;
if (sCom == "COMBAT_DUMMY")
    return APPEARANCE_TYPE_COMBAT_DUMMY;
if (sCom == "CONVICT")
    return APPEARANCE_TYPE_CONVICT;
if (sCom == "COW")
    return APPEARANCE_TYPE_COW;
if (sCom == "CULT_MEMBER")
    return APPEARANCE_TYPE_CULT_MEMBER;
if (sCom == "DEER")
    return APPEARANCE_TYPE_DEER;
if (sCom == "DEER_STAG")
    return APPEARANCE_TYPE_DEER_STAG;
if (sCom == "DEVIL")
    return APPEARANCE_TYPE_DEVIL;
if (sCom == "DOG")
    return APPEARANCE_TYPE_DOG;
if (sCom == "DOG_BLINKDOG")
    return APPEARANCE_TYPE_DOG_BLINKDOG;
if (sCom == "DOG_DIRE_WOLF")
    return APPEARANCE_TYPE_DOG_DIRE_WOLF;
if (sCom == "DOG_FENHOUND")
    return APPEARANCE_TYPE_DOG_FENHOUND;
if (sCom == "DOG_HELL_HOUND")
    return APPEARANCE_TYPE_DOG_HELL_HOUND;
if (sCom == "DOG_SHADOW_MASTIF")
    return APPEARANCE_TYPE_DOG_SHADOW_MASTIF;
if (sCom == "DOG_WINTER_WOLF")
    return APPEARANCE_TYPE_DOG_WINTER_WOLF;
if (sCom == "DOG_WORG")
    return APPEARANCE_TYPE_DOG_WORG;
if (sCom == "DOG_WOLF")
    return APPEARANCE_TYPE_DOG_WOLF;
if (sCom == "DOOM_KNIGHT")
    return APPEARANCE_TYPE_DOOM_KNIGHT;
if (sCom == "DRAGON_BLACK")
    return APPEARANCE_TYPE_DRAGON_BLACK;
if (sCom == "DRAGON_BLUE")
    return APPEARANCE_TYPE_DRAGON_BLUE;
if (sCom == "DRAGON_BRASS")
    return APPEARANCE_TYPE_DRAGON_BRASS;
if (sCom == "DRAGON_BRONZE")
    return APPEARANCE_TYPE_DRAGON_BRONZE;
if (sCom == "DRAGON_COPPER")
    return APPEARANCE_TYPE_DRAGON_COPPER;
if (sCom == "DRAGON_GOLD")
    return APPEARANCE_TYPE_DRAGON_GOLD;
if (sCom == "DRAGON_GREEN")
    return APPEARANCE_TYPE_DRAGON_GREEN;
if (sCom == "DRAGON_RED")
    return APPEARANCE_TYPE_DRAGON_RED;
if (sCom == "DRAGON_SILVER")
    return APPEARANCE_TYPE_DRAGON_SILVER;
if (sCom == "DRAGON_WHITE")
    return APPEARANCE_TYPE_DRAGON_WHITE;
if (sCom == "DROW_CLERIC")
    return APPEARANCE_TYPE_DROW_CLERIC;
if (sCom == "DROW_FIGHTER")
    return APPEARANCE_TYPE_DROW_FIGHTER;
if (sCom == "DRUEGAR_CLERIC")
    return APPEARANCE_TYPE_DRUEGAR_CLERIC;
if (sCom == "DRUEGAR_FIGHTER")
    return APPEARANCE_TYPE_DRUEGAR_FIGHTER;
if (sCom == "DRYAD")
    return APPEARANCE_TYPE_DRYAD;
if (sCom == "DWARF")
    return APPEARANCE_TYPE_DWARF;
if (sCom == "DWARF_NPC_FEMALE")
    return APPEARANCE_TYPE_DWARF_NPC_FEMALE;
if (sCom == "DWARF_NPC_MALE")
    return APPEARANCE_TYPE_DWARF_NPC_MALE;
if (sCom == "ELEMENTAL_AIR")
    return APPEARANCE_TYPE_ELEMENTAL_AIR;
if (sCom == "ELEMENTAL_AIR_ELDER")
    return APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER;
if (sCom == "ELEMENTAL_EARTH")
    return APPEARANCE_TYPE_ELEMENTAL_EARTH;
if (sCom == "ELEMENTAL_EARTH_ELDER")
    return APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER;
if (sCom == "ELEMENTAL_FIRE")
    return APPEARANCE_TYPE_ELEMENTAL_FIRE;
if (sCom == "ELEMENTAL_FIRE_ELDER")
    return APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER;
if (sCom == "ELEMENTAL_WATER")
    return APPEARANCE_TYPE_ELEMENTAL_WATER;
if (sCom == "ELEMENTAL_WATER_ELDER")
    return APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER;
if (sCom == "ELF")
    return APPEARANCE_TYPE_ELF;
if (sCom == "ELF_NPC_FEMALE")
    return APPEARANCE_TYPE_ELF_NPC_FEMALE;
if (sCom == "ELF_NPC_MALE_01")
    return APPEARANCE_TYPE_ELF_NPC_MALE_01;
if (sCom == "ELF_NPC_MALE_02")
    return APPEARANCE_TYPE_ELF_NPC_MALE_02;
if (sCom == "ETTERCAP")
    return APPEARANCE_TYPE_ETTERCAP;
if (sCom == "ETTIN")
    return APPEARANCE_TYPE_ETTIN;
if (sCom == "FAERIE_DRAGON")
    return APPEARANCE_TYPE_FAERIE_DRAGON;
if (sCom == "FAIRY")
    return APPEARANCE_TYPE_FAIRY;
if (sCom == "FALCON")
    return APPEARANCE_TYPE_FALCON;
if (sCom == "FEMALE_01")
    return APPEARANCE_TYPE_FEMALE_01;
if (sCom == "FEMALE_02")
    return APPEARANCE_TYPE_FEMALE_02;
if (sCom == "FEMALE_03")
    return APPEARANCE_TYPE_FEMALE_03;
if (sCom == "FEMALE_04")
    return APPEARANCE_TYPE_FEMALE_04;
if (sCom == "FORMIAN_MYRMARCH")
    return APPEARANCE_TYPE_FORMIAN_MYRMARCH;
if (sCom == "FORMIAN_QUEEN")
    return APPEARANCE_TYPE_FORMIAN_QUEEN;
if (sCom == "FORMIAN_WARRIOR")
    return APPEARANCE_TYPE_FORMIAN_WARRIOR;
if (sCom == "FORMIAN_WORKER")
    return APPEARANCE_TYPE_FORMIAN_WORKER;
if (sCom == "GARGOYLE")
    return APPEARANCE_TYPE_GARGOYLE;
if (sCom == "GHAST")
    return APPEARANCE_TYPE_GHAST;
if (sCom == "GHOUL")
    return APPEARANCE_TYPE_GHOUL;
if (sCom == "GHOUL_LORD")
    return APPEARANCE_TYPE_GHOUL_LORD;
if (sCom == "GIANT_FIRE")
    return APPEARANCE_TYPE_GIANT_FIRE;
if (sCom == "GIANT_FIRE_FEMALE")
    return APPEARANCE_TYPE_GIANT_FIRE_FEMALE;
if (sCom == "GIANT_FROST")
    return APPEARANCE_TYPE_GIANT_FROST;
if (sCom == "GIANT_FROST_FEMALE")
    return APPEARANCE_TYPE_GIANT_FROST_FEMALE;
if (sCom == "GIANT_HILL")
    return APPEARANCE_TYPE_GIANT_HILL;
if (sCom == "GIANT_MOUNTAIN")
    return APPEARANCE_TYPE_GIANT_MOUNTAIN;
if (sCom == "GNOLL_WARRIOR")
    return APPEARANCE_TYPE_GNOLL_WARRIOR;
if (sCom == "GNOLL_WIZ")
    return APPEARANCE_TYPE_GNOLL_WIZ;
if (sCom == "GNOME")
    return APPEARANCE_TYPE_GNOME;
if (sCom == "GNOME_NPC_FEMALE")
    return APPEARANCE_TYPE_GNOME_NPC_FEMALE;
if (sCom == "GNOME_NPC_MALE")
    return APPEARANCE_TYPE_GNOME_NPC_MALE;
if (sCom == "GOBLIN_A")
    return APPEARANCE_TYPE_GOBLIN_A;
if (sCom == "GOBLIN_B")
    return APPEARANCE_TYPE_GOBLIN_B;
if (sCom == "GOBLIN_CHIEF_A")
    return APPEARANCE_TYPE_GOBLIN_CHIEF_A;
if (sCom == "GOBLIN_CHIEF_B")
    return APPEARANCE_TYPE_GOBLIN_CHIEF_B;
if (sCom == "GOBLIN_SHAMAN_A")
    return APPEARANCE_TYPE_GOBLIN_SHAMAN_A;
if (sCom == "GOBLIN_SHAMAN_B")
    return APPEARANCE_TYPE_GOBLIN_SHAMAN_B;
if (sCom == "GOLEM_BONE")
    return APPEARANCE_TYPE_GOLEM_BONE;
if (sCom == "GOLEM_CLAY")
    return APPEARANCE_TYPE_GOLEM_CLAY;
if (sCom == "GOLEM_FLESH")
    return APPEARANCE_TYPE_GOLEM_FLESH;
if (sCom == "GOLEM_IRON")
    return APPEARANCE_TYPE_GOLEM_IRON;
if (sCom == "GOLEM_STONE")
    return APPEARANCE_TYPE_GOLEM_STONE;
if (sCom == "GORGON")
    return APPEARANCE_TYPE_GORGON;
if (sCom == "GREY_RENDER")
    return APPEARANCE_TYPE_GREY_RENDER;
if (sCom == "GYNOSPHINX")
    return APPEARANCE_TYPE_GYNOSPHINX;
if (sCom == "HALF_ELF")
    return APPEARANCE_TYPE_HALF_ELF;
if (sCom == "HALF_ORC")
    return APPEARANCE_TYPE_HALF_ORC;
if (sCom == "HALF_ORC_NPC_FEMALE")
    return APPEARANCE_TYPE_HALF_ORC_NPC_FEMALE;
if (sCom == "HALF_ORC_NPC_MALE_01")
    return APPEARANCE_TYPE_HALF_ORC_NPC_MALE_01;
if (sCom == "HALF_ORC_NPC_MALE_02")
    return APPEARANCE_TYPE_HALF_ORC_NPC_MALE_02;
if (sCom == "HALFLING")
    return APPEARANCE_TYPE_HALFLING;
if (sCom == "HALFLING_NPC_FEMALE")
    return APPEARANCE_TYPE_HALFLING_NPC_FEMALE;
if (sCom == "HALFLING_NPC_MALE")
    return APPEARANCE_TYPE_HALFLING_NPC_MALE;
if (sCom == "HELMED_HORROR")
    return APPEARANCE_TYPE_HELMED_HORROR;
if (sCom == "HEURODIS_LICH")
    return APPEARANCE_TYPE_HEURODIS_LICH;
if (sCom == "HOBGOBLIN_WARRIOR")
    return APPEARANCE_TYPE_HOBGOBLIN_WARRIOR;
if (sCom == "HOOK_HORROR")
    return APPEARANCE_TYPE_HOOK_HORROR;
if (sCom == "HOBGOBLIN_WIZARD")
    return APPEARANCE_TYPE_HOBGOBLIN_WIZARD;
if (sCom == "HOUSE_GUARD")
    return APPEARANCE_TYPE_HOUSE_GUARD;
if (sCom == "HUMAN")
    return APPEARANCE_TYPE_HUMAN;
if (sCom == "HUMAN_NPC_FEMALE_01")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_01;
if (sCom == "HUMAN_NPC_FEMALE_02")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_02;
if (sCom == "HUMAN_NPC_FEMALE_03")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_03;
if (sCom == "HUMAN_NPC_FEMALE_04")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_04;
if (sCom == "HUMAN_NPC_FEMALE_05")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_05;
if (sCom == "HUMAN_NPC_FEMALE_06")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_06;
if (sCom == "HUMAN_NPC_FEMALE_07")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_07;
if (sCom == "HUMAN_NPC_FEMALE_08")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_08;
if (sCom == "HUMAN_NPC_FEMALE_09")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_09;
if (sCom == "HUMAN_NPC_FEMALE_10")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_10;
if (sCom == "HUMAN_NPC_FEMALE_11")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_11;
if (sCom == "HUMAN_NPC_FEMALE_12")
    return APPEARANCE_TYPE_HUMAN_NPC_FEMALE_12;
if (sCom == "HUMAN_NPC_MALE_01")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_01;
if (sCom == "HUMAN_NPC_MALE_02")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_02;
if (sCom == "HUMAN_NPC_MALE_03")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_03;
if (sCom == "HUMAN_NPC_MALE_04")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_04;
if (sCom == "HUMAN_NPC_MALE_05")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_05;
if (sCom == "HUMAN_NPC_MALE_06")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_06;
if (sCom == "HUMAN_NPC_MALE_07")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_07;
if (sCom == "HUMAN_NPC_MALE_08")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_08;
if (sCom == "HUMAN_NPC_MALE_09")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_09;
if (sCom == "HUMAN_NPC_MALE_10")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_10;
if (sCom == "HUMAN_NPC_MALE_11")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_11;
if (sCom == "HUMAN_NPC_MALE_12")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_12;
if (sCom == "HUMAN_NPC_MALE_13")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_13;
if (sCom == "HUMAN_NPC_MALE_14")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_14;
if (sCom == "HUMAN_NPC_MALE_15")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_15;
if (sCom == "HUMAN_NPC_MALE_16")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_16;
if (sCom == "HUMAN_NPC_MALE_17")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_17;
if (sCom == "HUMAN_NPC_MALE_18")
    return APPEARANCE_TYPE_HUMAN_NPC_MALE_18;
if (sCom == "IMP")
    return APPEARANCE_TYPE_IMP;
if (sCom == "INN_KEEPER")
    return APPEARANCE_TYPE_INN_KEEPER;
if (sCom == "INTELLECT_DEVOURER")
    return APPEARANCE_TYPE_INTELLECT_DEVOURER;
if (sCom == "INVISIBLE_HUMAN_MALE")
    return APPEARANCE_TYPE_INVISIBLE_HUMAN_MALE;
if (sCom == "INVISIBLE_STALKER")
    return APPEARANCE_TYPE_INVISIBLE_STALKER;
if (sCom == "KID_FEMALE")
    return APPEARANCE_TYPE_KID_FEMALE;
if (sCom == "KID_MALE")
    return APPEARANCE_TYPE_KID_MALE;
if (sCom == "KOBOLD_A")
    return APPEARANCE_TYPE_KOBOLD_A;
if (sCom == "KOBOLD_B")
    return APPEARANCE_TYPE_KOBOLD_B;
if (sCom == "KOBOLD_CHIEF_A")
    return APPEARANCE_TYPE_KOBOLD_CHIEF_A;
if (sCom == "KOBOLD_CHIEF_B")
    return APPEARANCE_TYPE_KOBOLD_CHIEF_B;
if (sCom == "KOBOLD_SHAMAN_A")
    return APPEARANCE_TYPE_KOBOLD_SHAMAN_A;
if (sCom == "KOBOLD_SHAMAN_B")
    return APPEARANCE_TYPE_KOBOLD_SHAMAN_B;
if (sCom == "LANTERN_ARCHON")
    return APPEARANCE_TYPE_LANTERN_ARCHON;
if (sCom == "LICH")
    return APPEARANCE_TYPE_LICH;
if (sCom == "LIZARDFOLK_A")
    return APPEARANCE_TYPE_LIZARDFOLK_A;
if (sCom == "LIZARDFOLK_B")
    return APPEARANCE_TYPE_LIZARDFOLK_B;
if (sCom == "LIZARDFOLK_SHAMAN_A")
    return APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_A;
if (sCom == "LIZARDFOLK_SHAMAN_B")
    return APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_B;
if (sCom == "LIZARDFOLK_WARRIOR_A")
    return APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A;
if (sCom == "LIZARDFOLK_WARRIOR_B")
    return APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_B;
if (sCom == "LUSKAN_GUARD")
    return APPEARANCE_TYPE_LUSKAN_GUARD;
if (sCom == "MALE_01")
    return APPEARANCE_TYPE_MALE_01;
if (sCom == "MALE_02")
    return APPEARANCE_TYPE_MALE_02;
if (sCom == "MALE_03")
    return APPEARANCE_TYPE_MALE_03;
if (sCom == "MALE_04")
    return APPEARANCE_TYPE_MALE_04;
if (sCom == "MALE_05")
    return APPEARANCE_TYPE_MALE_05;
if (sCom == "MANTICORE")
    return APPEARANCE_TYPE_MANTICORE;
if (sCom == "MEDUSA")
    return APPEARANCE_TYPE_MEDUSA;
if (sCom == "MEPHIT_AIR")
    return APPEARANCE_TYPE_MEPHIT_AIR;
if (sCom == "MEPHIT_DUST")
    return APPEARANCE_TYPE_MEPHIT_DUST;
if (sCom == "MEPHIT_EARTH")
    return APPEARANCE_TYPE_MEPHIT_EARTH;
if (sCom == "MEPHIT_FIRE")
    return APPEARANCE_TYPE_MEPHIT_FIRE;
if (sCom == "MEPHIT_ICE")
    return APPEARANCE_TYPE_MEPHIT_ICE;
if (sCom == "MEPHIT_MAGMA")
    return APPEARANCE_TYPE_MEPHIT_MAGMA;
if (sCom == "MEPHIT_OOZE")
    return APPEARANCE_TYPE_MEPHIT_OOZE;
if (sCom == "MEPHIT_SALT")
    return APPEARANCE_TYPE_MEPHIT_SALT;
if (sCom == "MEPHIT_STEAM")
    return APPEARANCE_TYPE_MEPHIT_STEAM;
if (sCom == "MEPHIT_WATER")
    return APPEARANCE_TYPE_MEPHIT_WATER;
if (sCom == "MINOGON")
    return APPEARANCE_TYPE_MINOGON;
if (sCom == "MINOTAUR")
    return APPEARANCE_TYPE_MINOTAUR;
if (sCom == "MINOTAUR_CHIEFTAIN")
    return APPEARANCE_TYPE_MINOTAUR_CHIEFTAIN;
if (sCom == "MINOTAUR_SHAMAN")
    return APPEARANCE_TYPE_MINOTAUR_SHAMAN;
if (sCom == "MOHRG")
    return APPEARANCE_TYPE_MOHRG;
if (sCom == "MUMMY_COMMON")
    return APPEARANCE_TYPE_MUMMY_COMMON;
if (sCom == "MUMMY_FIGHTER_2")
    return APPEARANCE_TYPE_MUMMY_FIGHTER_2;
if (sCom == "MUMMY_GREATER")
    return APPEARANCE_TYPE_MUMMY_GREATER;
if (sCom == "MUMMY_WARRIOR")
    return APPEARANCE_TYPE_MUMMY_WARRIOR;
if (sCom == "NW_MILITIA_MEMBER")
    return APPEARANCE_TYPE_NW_MILITIA_MEMBER;
if (sCom == "NWN_AARIN")
    return APPEARANCE_TYPE_NWN_AARIN;
if (sCom == "NWN_ARIBETH_EVIL")
    return APPEARANCE_TYPE_NWN_ARIBETH_EVIL;
if (sCom == "NWN_HAEDRALINE")
    return APPEARANCE_TYPE_NWN_HAEDRALINE;
if (sCom == "NWN_MAUGRIM")
    return APPEARANCE_TYPE_NWN_MAUGRIM;
if (sCom == "NWN_MORAG")
    return APPEARANCE_TYPE_NWN_MORAG;
if (sCom == "NWN_NASHER")
    return APPEARANCE_TYPE_NWN_NASHER;
if (sCom == "NWN_SEDOS")
    return APPEARANCE_TYPE_NWN_SEDOS;
if (sCom == "NYMPH")
    return APPEARANCE_TYPE_NYMPH;
if (sCom == "OGRE")
    return APPEARANCE_TYPE_OGRE;
if (sCom == "OGRE_CHIEFTAIN")
    return APPEARANCE_TYPE_OGRE_CHIEFTAIN;
if (sCom == "OGRE_CHIEFTAINB")
    return APPEARANCE_TYPE_OGRE_CHIEFTAINB;
if (sCom == "OGRE_MAGE")
    return APPEARANCE_TYPE_OGRE_MAGE;
if (sCom == "OGRE_MAGEB")
    return APPEARANCE_TYPE_OGRE_MAGEB;
if (sCom == "OGREB")
    return APPEARANCE_TYPE_OGREB;
if (sCom == "OLD_MAN")
    return APPEARANCE_TYPE_OLD_MAN;
if (sCom == "OLD_WOMAN")
    return APPEARANCE_TYPE_OLD_WOMAN;
if (sCom == "ORC_A")
    return APPEARANCE_TYPE_ORC_A;
if (sCom == "ORC_B")
    return APPEARANCE_TYPE_ORC_B;
if (sCom == "ORC_CHIEFTAIN_A")
    return APPEARANCE_TYPE_ORC_CHIEFTAIN_A;
if (sCom == "ORC_CHIEFTAIN_B")
    return APPEARANCE_TYPE_ORC_CHIEFTAIN_B;
if (sCom == "ORC_SHAMAN_A")
    return APPEARANCE_TYPE_ORC_SHAMAN_A;
if (sCom == "ORC_SHAMAN_B")
    return APPEARANCE_TYPE_ORC_SHAMAN_B;
if (sCom == "OX")
    return APPEARANCE_TYPE_OX;
if (sCom == "PENGUIN")
    return APPEARANCE_TYPE_PENGUIN;
if (sCom == "PLAGUE_VICTIM")
    return APPEARANCE_TYPE_PLAGUE_VICTIM;
if (sCom == "PROSTITUTE_01")
    return APPEARANCE_TYPE_PROSTITUTE_01;
if (sCom == "PROSTITUTE_02")
    return APPEARANCE_TYPE_PROSTITUTE_02;
if (sCom == "PSEUDODRAGON")
    return APPEARANCE_TYPE_PSEUDODRAGON;
if (sCom == "QUASIT")
    return APPEARANCE_TYPE_QUASIT;
if (sCom == "RAKSHASA_BEAR_MALE")
    return APPEARANCE_TYPE_RAKSHASA_BEAR_MALE;
if (sCom == "RAKSHASA_TIGER_FEMALE")
    return APPEARANCE_TYPE_RAKSHASA_TIGER_FEMALE;
if (sCom == "RAKSHASA_TIGER_MALE")
    return APPEARANCE_TYPE_RAKSHASA_TIGER_MALE;
if (sCom == "RAKSHASA_WOLF_MALE")
    return APPEARANCE_TYPE_RAKSHASA_WOLF_MALE;
if (sCom == "RAT")
    return APPEARANCE_TYPE_RAT;
if (sCom == "RAT_DIRE")
    return APPEARANCE_TYPE_RAT_DIRE;
if (sCom == "RAVEN")
    return APPEARANCE_TYPE_RAVEN;
if (sCom == "SHADOW")
    return APPEARANCE_TYPE_SHADOW;
if (sCom == "SHADOW_FIEND")
    return APPEARANCE_TYPE_SHADOW_FIEND;
if (sCom == "SHIELD_GUARDIAN")
    return APPEARANCE_TYPE_SHIELD_GUARDIAN;
if (sCom == "SHOP_KEEPER")
    return APPEARANCE_TYPE_SHOP_KEEPER;
if (sCom == "SKELETAL_DEVOURER")
    return APPEARANCE_TYPE_SKELETAL_DEVOURER;
if (sCom == "SKELETON_CHIEFTAIN")
    return APPEARANCE_TYPE_SKELETON_CHIEFTAIN;
if (sCom == "SKELETON_COMMON")
    return APPEARANCE_TYPE_SKELETON_COMMON;
if (sCom == "SKELETON_MAGE")
    return APPEARANCE_TYPE_SKELETON_MAGE;
if (sCom == "SKELETON_WARRIOR")
    return APPEARANCE_TYPE_SKELETON_WARRIOR;
if (sCom == "SKELETON_PRIEST")
    return APPEARANCE_TYPE_SKELETON_PRIEST;
if (sCom == "SKELETON_WARRIOR_1")
    return APPEARANCE_TYPE_SKELETON_WARRIOR_1;
if (sCom == "SKELETON_WARRIOR_2")
    return APPEARANCE_TYPE_SKELETON_WARRIOR_2;
if (sCom == "SPHINX")
    return APPEARANCE_TYPE_SPHINX;
if (sCom == "SPIDER_WRAITH")
    return APPEARANCE_TYPE_SPIDER_WRAITH;
if (sCom == "STINGER")
    return APPEARANCE_TYPE_STINGER;
if (sCom == "STINGER_CHIEFTAIN")
    return APPEARANCE_TYPE_STINGER_CHIEFTAIN;
if (sCom == "STINGER_MAGE")
    return APPEARANCE_TYPE_STINGER_MAGE;
if (sCom == "STINGER_WARRIOR")
    return APPEARANCE_TYPE_STINGER_WARRIOR;
if (sCom == "SUCCUBUS")
    return APPEARANCE_TYPE_SUCCUBUS;
if (sCom == "TROLL")
    return APPEARANCE_TYPE_TROLL;
if (sCom == "TROLL_CHIEFTAIN")
    return APPEARANCE_TYPE_TROLL_CHIEFTAIN;
if (sCom == "TROLL_SHAMAN")
    return APPEARANCE_TYPE_TROLL_SHAMAN;
if (sCom == "UMBERHULK")
    return APPEARANCE_TYPE_UMBERHULK;
if (sCom == "UTHGARD_ELK_TRIBE")
    return APPEARANCE_TYPE_UTHGARD_ELK_TRIBE;
if (sCom == "UTHGARD_TIGER_TRIBE")
    return APPEARANCE_TYPE_UTHGARD_TIGER_TRIBE;
if (sCom == "VAMPIRE_FEMALE")
    return APPEARANCE_TYPE_VAMPIRE_FEMALE;
if (sCom == "VAMPIRE_MALE")
    return APPEARANCE_TYPE_VAMPIRE_MALE;
if (sCom == "VROCK")
    return APPEARANCE_TYPE_VROCK;
if (sCom == "WAITRESS")
    return APPEARANCE_TYPE_WAITRESS;
if (sCom == "WAR_DEVOURER")
    return APPEARANCE_TYPE_WAR_DEVOURER;
if (sCom == "WERECAT")
    return APPEARANCE_TYPE_WERECAT;
if (sCom == "WERERAT")
    return APPEARANCE_TYPE_WERERAT;
if (sCom == "WEREWOLF")
    return APPEARANCE_TYPE_WEREWOLF;
if (sCom == "WIGHT")
    return APPEARANCE_TYPE_WIGHT;
if (sCom == "WILL_O_WISP")
    return APPEARANCE_TYPE_WILL_O_WISP;
if (sCom == "WRAITH")
    return APPEARANCE_TYPE_WRAITH;
if (sCom == "WYRMLING_BLACK")
    return APPEARANCE_TYPE_WYRMLING_BLACK;
if (sCom == "WYRMLING_BLUE")
    return APPEARANCE_TYPE_WYRMLING_BLUE;
if (sCom == "WYRMLING_BRASS")
    return APPEARANCE_TYPE_WYRMLING_BRASS;
if (sCom == "WYRMLING_BRONZE")
    return APPEARANCE_TYPE_WYRMLING_BRONZE;
if (sCom == "WYRMLING_COPPER")
    return APPEARANCE_TYPE_WYRMLING_COPPER;
if (sCom == "WYRMLING_GOLD")
    return APPEARANCE_TYPE_WYRMLING_GOLD;
if (sCom == "WYRMLING_GREEN")
    return APPEARANCE_TYPE_WYRMLING_GREEN;
if (sCom == "WYRMLING_RED")
    return APPEARANCE_TYPE_WYRMLING_RED;
if (sCom == "WYRMLING_SILVER")
    return APPEARANCE_TYPE_WYRMLING_SILVER;
if (sCom == "WYRMLING_WHITE")
    return APPEARANCE_TYPE_WYRMLING_WHITE;
if (sCom == "YUAN_TI")
    return APPEARANCE_TYPE_YUAN_TI;
if (sCom == "YUAN_TI_CHIEFTEN")
    return APPEARANCE_TYPE_YUAN_TI_CHIEFTEN;
if (sCom == "YUAN_TI_WIZARD")
    return APPEARANCE_TYPE_YUAN_TI_WIZARD;
if (sCom == "ZOMBIE")
    return APPEARANCE_TYPE_ZOMBIE;
if (sCom == "ZOMBIE_ROTTING")
    return APPEARANCE_TYPE_ZOMBIE_ROTTING;
if (sCom == "ZOMBIE_TYRANT_FOG")
    return APPEARANCE_TYPE_ZOMBIE_TYRANT_FOG;
if (sCom == "ZOMBIE_WARRIOR_1")
    return APPEARANCE_TYPE_ZOMBIE_WARRIOR_1;
if (sCom == "ZOMBIE_WARRIOR_2")
    return APPEARANCE_TYPE_ZOMBIE_WARRIOR_2;

return -1;
}

 void dmw_CleanUp(object oMySpeaker)
{
   int nCount;
   int nCache;
   //DeleteLocalObject(oMySpeaker, "dmfi_univ_target");
   DeleteLocalLocation(oMySpeaker, "dmfi_univ_location");
   DeleteLocalObject(oMySpeaker, "dmw_item");
   DeleteLocalString(oMySpeaker, "dmw_repamt");
   DeleteLocalString(oMySpeaker, "dmw_repargs");
   nCache = GetLocalInt(oMySpeaker, "dmw_playercache");
   for(nCount = 1; nCount <= nCache; nCount++)
   {
      DeleteLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCount));
   }
   DeleteLocalInt(oMySpeaker, "dmw_playercache");
   nCache = GetLocalInt(oMySpeaker, "dmw_itemcache");
   for(nCount = 1; nCount <= nCache; nCount++)
   {
      DeleteLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount));
   }
   DeleteLocalInt(oMySpeaker, "dmw_itemcache");
   for(nCount = 1; nCount <= 10; nCount++)
   {
      DeleteLocalString(oMySpeaker, "dmw_dialog" + IntToString(nCount));
      DeleteLocalString(oMySpeaker, "dmw_function" + IntToString(nCount));
      DeleteLocalString(oMySpeaker, "dmw_params" + IntToString(nCount));
   }
   DeleteLocalString(oMySpeaker, "dmw_playerfunc");
   DeleteLocalInt(oMySpeaker, "dmw_started");
}
//Smoking Function by Jason Robinson
location GetLocationAboveAndInFrontOf(object oPC, float fDist, float fHeight)
{
    float fDistance = -fDist;
    object oTarget = (oPC);
    object oArea = GetArea(oTarget);
    vector vPosition = GetPosition(oTarget);
    vPosition.z += fHeight;
    float fOrientation = GetFacing(oTarget);
    vector vNewPos = AngleToVector(fOrientation);
    float vZ = vPosition.z;
    float vX = vPosition.x - fDistance * vNewPos.x;
    float vY = vPosition.y - fDistance * vNewPos.y;
    fOrientation = GetFacing(oTarget);
    vX = vPosition.x - fDistance * vNewPos.x;
    vY = vPosition.y - fDistance * vNewPos.y;
    vNewPos = AngleToVector(fOrientation);
    vZ = vPosition.z;
    vNewPos = Vector(vX, vY, vZ);
    return Location(oArea, vNewPos, fOrientation);
}

//Smoking Function by Jason Robinson
void SmokePipe(object oActivator)
{
    string sEmote1 = "*puffs on a pipe*";
    string sEmote2 = "*inhales from a pipe*";
    string sEmote3 = "*pulls a mouthful of smoke from a pipe*";
    float fHeight = 1.7;
    float fDistance = 0.1;
    // Set height based on race and gender
    if (GetGender(oActivator) == GENDER_MALE)
    {
        switch (GetRacialType(oActivator))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.7; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.55; fDistance = 0.08; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.15; fDistance = 0.12; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.12; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.9; fDistance = 0.2; break;
        }
    }
    else
    {
        // FEMALES
        switch (GetRacialType(oActivator))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.6; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.45; fDistance = 0.12; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.1; fDistance = 0.075; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.1; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.8; fDistance = 0.13; break;
        }
    }
    location lAboveHead = GetLocationAboveAndInFrontOf(oActivator, fDistance, fHeight);
    // emotes
    switch (d3())
    {
        case 1: AssignCommand(oActivator, ActionSpeakString(sEmote1)); break;
        case 2: AssignCommand(oActivator, ActionSpeakString(sEmote2)); break;
        case 3: AssignCommand(oActivator, ActionSpeakString(sEmote3));break;
    }
    // glow red
    AssignCommand(oActivator, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oActivator, 0.15)));
    // wait a moment
    AssignCommand(oActivator, ActionWait(3.0));
    // puff of smoke above and in front of head
    AssignCommand(oActivator, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), lAboveHead)));
    // if female, turn head to left
    if ((GetGender(oActivator) == GENDER_FEMALE) && (GetRacialType(oActivator) != RACIAL_TYPE_DWARF))
        AssignCommand(oActivator, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 5.0));
}

void ParseEmote(string sEmote, object oPC)
{
    DeleteLocalInt(oPC, "dmfi_univ_int");
    object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLeftHand =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    //PrintString("<Conv>"+GetName(GetArea(oPC))+ " " + GetName(oPC) + ": " + sEmote + " </Conv>");
    if (!GetIsPC(oPC)) AssignCommand(oPC, SpeakString(sEmote));

    if (GetStringLeft(sEmote, 1) == "*")
    {
        int iToggle;
        string sBuffer;
        sBuffer = GetStringRight(sEmote, GetStringLength(sEmote)-1);
        while (!iToggle && GetStringLength(sBuffer) > 1)
        {
            if (GetStringLeft(sBuffer,1) == "*")
                iToggle = abs(iToggle - 1);
            sBuffer = GetStringRight(sBuffer, GetStringLength(sBuffer)-1);
        }
        sEmote = GetStringLeft(sEmote, GetStringLength(sEmote)-GetStringLength(sBuffer));
    }

    int iSit;
    object oArea;
    object oChair;

    //*emote* rolls
    if ((FindSubString(sEmote, "Strength") != -1) ||
        (FindSubString(sEmote, "strength") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 61);
    else if ((FindSubString(sEmote, "Dexterity") != -1)||
             (FindSubString(sEmote, "dexterity") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 62);
    else if ((FindSubString(sEmote, "Constitution") != -1)||
           (FindSubString(sEmote, "constitution") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 63);
    else if ((FindSubString(sEmote, "Intelligence") != -1)||
            (FindSubString(sEmote, "intelligence") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 64);
    else if ((FindSubString(sEmote, "Wisdom") != -1) ||
            (FindSubString(sEmote, "wisdom") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 65);
    else if ((FindSubString(sEmote, "Charisma") != -1)||
            (FindSubString(sEmote, "charisma") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 66);
    else if ((FindSubString(sEmote, "Fortitude") != -1)||
           (FindSubString(sEmote, "fortitude") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 67);
    else if ((FindSubString(sEmote, "Reflex") != -1) ||
            (FindSubString(sEmote, "reflex") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 68);
    else if ((FindSubString(sEmote, "Will") != -1) ||
            (FindSubString(sEmote, "will") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 69);
    else if ((FindSubString(sEmote, "Animal Empathy") != -1)||
           (FindSubString(sEmote, "animal empathy") != -1)||
           (FindSubString(sEmote, "Animal Empathy") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 71);
    else if ((FindSubString(sEmote, "Appraise") != -1)||
            (FindSubString(sEmote, "appraise") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 72);
     else if ((FindSubString(sEmote, "Bluff") != -1) ||
             (FindSubString(sEmote, "bluff") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 73);
    else if ((FindSubString(sEmote, "Concentration") != -1) ||
            (FindSubString(sEmote, "concentration") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 74);
     else if ((FindSubString(sEmote, "Craft Armor") != -1) ||
            (FindSubString(sEmote, "Craft armor") != -1)||
            (FindSubString(sEmote, "craft armor") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 75);
     else if ((FindSubString(sEmote, "Craft Trap") != -1) ||
             (FindSubString(sEmote, "Craft trap") != -1)||
             (FindSubString(sEmote, "craft trap") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 76);
     else if ((FindSubString(sEmote, "Craft Weapon") != -1) ||
             (FindSubString(sEmote, "Craft weapon") != -1)||
             (FindSubString(sEmote, "craft weapon") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 77);
     else if ((FindSubString(sEmote, "Disable Trap") != -1) ||
             (FindSubString(sEmote, "Disable trap") != -1)||
             (FindSubString(sEmote, "disable trap") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 78);
    else if ((FindSubString(sEmote, "Discipline") != -1)||
            (FindSubString(sEmote, "discipline") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 79);
    else if ((FindSubString(sEmote, "Heal") != -1)||
             (FindSubString(sEmote, "heal") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 81);
    else if ((FindSubString(sEmote, "Hide") != -1)||
             (FindSubString(sEmote, "hide") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 82);
    else if ((FindSubString(sEmote, "Intimidate") != -1) ||
             (FindSubString(sEmote, "intimidate") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 83);
    else if ((FindSubString(sEmote, "Listen") != -1)||
             (FindSubString(sEmote, "listen") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 84);
    else if ((FindSubString(sEmote, "Lore") != -1)||
             (FindSubString(sEmote, "lore") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 85);
    else if ((FindSubString(sEmote, "Move Silently") != -1)||
            (FindSubString(sEmote, "Move silently") != -1)||
            (FindSubString(sEmote, "move silently") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 86);
    else if ((FindSubString(sEmote, "Open Lock") != -1)||
             (FindSubString(sEmote, "Open lock") != -1)||
             (FindSubString(sEmote, "open lock") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 87);
    else if ((FindSubString(sEmote, "Parry") != -1)||
            (FindSubString(sEmote, "parry") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 88);
    else if ((FindSubString(sEmote, "Perform") != -1)||
            (FindSubString(sEmote, "perform") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 89);
    else if ((FindSubString(sEmote, "Persuade") != -1) ||
            (FindSubString(sEmote, "persuade") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 91);
    else if ((FindSubString(sEmote, "Pickpocket") != -1) ||
             (FindSubString(sEmote, "Pick Pocket") != -1) ||
             (FindSubString(sEmote, "pickpocket") != -1)||
             (FindSubString(sEmote, "Pick pocket") != -1)||
             (FindSubString(sEmote, "pick pocket") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 92);
    else if ((FindSubString(sEmote, "Search") != -1)||
            (FindSubString(sEmote, "search") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 93);
    else if ((FindSubString(sEmote, "Set Trap") != -1)||
            (FindSubString(sEmote, "Set trap") != -1)||
            (FindSubString(sEmote, "set trap") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 94);
    else if ((FindSubString(sEmote, "Spellcraft") != -1)||
             (FindSubString(sEmote, "spellcraft") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 95);
    else if ((FindSubString(sEmote, "Spot") != -1)||
             (FindSubString(sEmote, "spot") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 96);
    else if ((FindSubString(sEmote, "Taunt") != -1)||
            (FindSubString(sEmote, "taunt") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 97);
    else if ((FindSubString(sEmote, "Tumble") != -1)||
             (FindSubString(sEmote, "tumble") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 98);
    else if ((FindSubString(sEmote, "Use Magic Device") != -1)||
            (FindSubString(sEmote, "use magic device") != -1)||
            (FindSubString(sEmote, "Use magic device") != -1))
        SetLocalInt(oPC, "dmfi_univ_int", 99);

    if (GetLocalInt(oPC, "dmfi_univ_int"))
    {
        SetLocalString(oPC, "dmfi_univ_conv", "pc_dicebag");
        ExecuteScript("dmfi_execute", oPC);
        return;
    }

    //*emote*
    if (FindSubString(GetStringLowerCase(sEmote), "*bows") != -1 ||
        FindSubString(GetStringLowerCase(sEmote), " bows") != -1 ||
        FindSubString(GetStringLowerCase(sEmote), "curtsey") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "drink") != -1 ||
             FindSubString(GetStringLowerCase(sEmote), "sips") != -1)
            AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "drinks") != -1 &&
             FindSubString(GetStringLowerCase(sEmote), "sits") != -1)
             {
                AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0f));
                DelayCommand(1.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_FIREFORGET_DRINK, 1.0)));
                DelayCommand(3.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0)));
             }
    else if (FindSubString(GetStringLowerCase(sEmote), "reads") != -1 &&
             FindSubString(GetStringLowerCase(sEmote), "sits") != -1)
             {
                AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0f));
                DelayCommand(1.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0)));
                DelayCommand(3.0f, AssignCommand(oPC, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0)));
             }
    else if (FindSubString(GetStringLowerCase(sEmote), "sit")!= -1)
            {
            AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0f));
            }
    else if (FindSubString(GetStringLowerCase(sEmote), "greet")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "wave") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "yawn")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "stretch") != -1 ||
             FindSubString(GetStringLowerCase(sEmote), "bored") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "scratch")!= -1)
    {
        AssignCommand(oPC,ActionUnequipItem(oRightHand));
        AssignCommand(oPC,ActionUnequipItem(oLeftHand));
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "*reads")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " reads")!= -1||
             FindSubString(GetStringLowerCase(sEmote), "read")!= -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "salute")!= -1)
    {
        AssignCommand(oPC,ActionUnequipItem(oRightHand));
        AssignCommand(oPC,ActionUnequipItem(oLeftHand));
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "steal")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "swipe") != -1)
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "taunt")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "mock") != -1)
    {
        PlayVoiceChat(VOICE_CHAT_TAUNT, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
    }
    else if ((FindSubString(GetStringLowerCase(sEmote), "smokes") != -1)||
            (FindSubString(GetStringLowerCase(sEmote), "smoke") != -1))
    {
        SmokePipe(oPC);
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "cheer ")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "cheer*")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_CHEER, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "hooray")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_CHEER, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "celebrate")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_CHEER, oPC);
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "giggle")!= -1 && GetGender(oPC) == GENDER_FEMALE)
        AssignCommand(oPC, PlaySound("vs_fshaldrf_haha"));
    else if (FindSubString(GetStringLowerCase(sEmote), "flop")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "prone")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "bends")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "stoop")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "fiddle")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 5.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "nod")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "agree")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 4.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "peers")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "scans")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "search")!= -1)
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "*pray")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " pray")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "meditate")!= -1)
    {
        AssignCommand(oPC,ActionUnequipItem(oRightHand));
        AssignCommand(oPC,ActionUnequipItem(oLeftHand));
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 99999.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "drunk")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "woozy")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "tired")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "fatigue")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "exhausted")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_REST, oPC);
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 3.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "fidget")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "shifts")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "sits")!= -1 &&
             (FindSubString(GetStringLowerCase(sEmote), "floor")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "ground")!= -1))
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "demand")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "threaten")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "laugh")!= -1 ||
            FindSubString(GetStringLowerCase(sEmote), "chuckle")!= -1)
    {
        PlayVoiceChat(VOICE_CHAT_LAUGH, oPC);
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "begs")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "plead")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "worship")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "snore")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "*naps")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " naps")!= -1||
             FindSubString(GetStringLowerCase(sEmote), "nap")!= -1)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPC);
    else if (FindSubString(GetStringLowerCase(sEmote), "*sings")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), " sings")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "hums")!= -1)
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), oPC, 6.0f);
    else if (FindSubString(GetStringLowerCase(sEmote), "whistles")!= -1)
        AssignCommand(oPC, PlaySound("as_pl_whistle2"));
    else if (FindSubString(GetStringLowerCase(sEmote), "talks")!= -1 ||
             FindSubString(GetStringLowerCase(sEmote), "chats")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "shakes head")!= -1)
    {
        AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 0.25f));
        DelayCommand(0.15f, AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.0, 0.25f)));
        DelayCommand(0.40f, AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 0.25f)));
        DelayCommand(0.65f, AssignCommand(oPC, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.0, 0.25f)));
    }
    else if (FindSubString(GetStringLowerCase(sEmote), "ducks")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "dodge")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "cantrip")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "spellcast")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "fall")!= -1 &&
             FindSubString(GetStringLowerCase(sEmote), "back")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 99999.0));
    else if (FindSubString(GetStringLowerCase(sEmote), "spasm")!= -1)
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 99999.0));
}

int GetIsAlphanumeric(string sCharacter)
{
    if (sCharacter == "a" ||
        sCharacter == "b" ||
        sCharacter == "c" ||
        sCharacter == "d" ||
        sCharacter == "e" ||
        sCharacter == "f" ||
        sCharacter == "g" ||
        sCharacter == "h" ||
        sCharacter == "i" ||
        sCharacter == "j" ||
        sCharacter == "k" ||
        sCharacter == "l" ||
        sCharacter == "m" ||
        sCharacter == "n" ||
        sCharacter == "o" ||
        sCharacter == "p" ||
        sCharacter == "q" ||
        sCharacter == "r" ||
        sCharacter == "s" ||
        sCharacter == "t" ||
        sCharacter == "u" ||
        sCharacter == "v" ||
        sCharacter == "w" ||
        sCharacter == "x" ||
        sCharacter == "y" ||
        sCharacter == "z" ||
        sCharacter == "A" ||
        sCharacter == "B" ||
        sCharacter == "C" ||
        sCharacter == "D" ||
        sCharacter == "E" ||
        sCharacter == "F" ||
        sCharacter == "G" ||
        sCharacter == "H" ||
        sCharacter == "I" ||
        sCharacter == "J" ||
        sCharacter == "K" ||
        sCharacter == "L" ||
        sCharacter == "M" ||
        sCharacter == "N" ||
        sCharacter == "O" ||
        sCharacter == "P" ||
        sCharacter == "Q" ||
        sCharacter == "R" ||
        sCharacter == "S" ||
        sCharacter == "T" ||
        sCharacter == "U" ||
        sCharacter == "V" ||
        sCharacter == "W" ||
        sCharacter == "X" ||
        sCharacter == "Y" ||
        sCharacter == "Z" ||
        sCharacter == "1" ||
        sCharacter == "2" ||
        sCharacter == "3" ||
        sCharacter == "4" ||
        sCharacter == "5" ||
        sCharacter == "6" ||
        sCharacter == "7" ||
        sCharacter == "8" ||
        sCharacter == "9" ||
        sCharacter == "0")
        return TRUE;

    return FALSE;
}

void ParseCommand(object oNPC, object oPC, string sCom)
{
    int iOffset=0;
    if (GetIsDM(oNPC) &&
        (oNPC != oPC))
        return; //DMs can only be affected by their own .commands

    if (!GetIsObjectValid(oNPC))
    {
        SendMessageToPC(oPC, "No current voice command target - no voice targeting commands will function.");
        return;
    }

    if (GetStringLowerCase(GetStringLeft(sCom, 12)) ==".appearance ")
    {
        string sNew = GetStringRight(sCom, GetStringLength(sCom)-12);
        SendMessageToPC(oPC, "Parse command: " + sNew);
        int Appear = AppearType(sNew);

        if (Appear!=-1)
           {SetCreatureAppearanceType(GetLocalObject(oPC, "dmfi_univ_target"), Appear);}
        else
           {FloatingTextStringOnCreature("Invalid Appearance Type", oPC);}


    dmw_CleanUp(oPC);
    return;
    }


    if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".loc")
    {
        SetLocalInt(oPC, "dmfi_dicebag", 2);
        SetCustomToken(20681, "Local");
        SetDMFIPersistentInt("dmfi", "dmfi_dicebag", 2, oPC);
        FloatingTextStringOnCreature("Broadcast Mode set to Local", oPC, FALSE); return;
    }
    if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".glo")
    {
        SetLocalInt(oPC, "dmfi_dicebag", 1);
        SetCustomToken(20681, "Global");
        SetDMFIPersistentInt("dmfi", "dmfi_dicebag", 1, oPC);
        FloatingTextStringOnCreature("Broadcast Mode set to Global", oPC, FALSE); return;
    }
    if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".pri")
    {
        SetLocalInt(oPC, "dmfi_dicebag", 0);
        SetCustomToken(20681, "Private");
        SetDMFIPersistentInt("dmfi", "dmfi_dicebag", 0, oPC);
        FloatingTextStringOnCreature("Broadcast Mode set to Private", oPC, FALSE); return;
    }
    if (GetStringLowerCase(GetStringLeft(sCom, 3)) == ".dm")
    {
        SetLocalInt(oPC, "dmfi_dicebag", 3);
        SetCustomToken(20681, "DM Only");
        SetDMFIPersistentInt("dmfi", "dmfi_dicebag", 3, oPC);
        FloatingTextStringOnCreature("Broadcast Mode set to DM Only", oPC, FALSE); return;
    }
    if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".aniy")
    {
        SetLocalInt(oPC, "dmfi_dice_no_animate", 0);
        FloatingTextStringOnCreature("Rolls will show animation", oPC, FALSE); return;
    }
    if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".anin")
    {
        SetLocalInt(oPC, "dmfi_dice_no_animate", 1);
        FloatingTextStringOnCreature("Rolls will NOT show animation", oPC, FALSE); return;
    }

    if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".stre")
       iOffset=  11;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".dext")
       iOffset = 12;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".cons")
       iOffset = 13;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".inte")
       iOffset = 14;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".wisd")
       iOffset = 15;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".char")
       iOffset = 16;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".fort")
       iOffset = 17;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".refl")
       iOffset = 18;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".anim")
       iOffset = 21;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".appr")
       iOffset = 22;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".bluf")
       iOffset =  23;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".conc")
       iOffset = 24;
    else if (GetStringLowerCase(GetStringLeft(sCom, 9)) == ".craft ar")
       iOffset =  25;
    else if (GetStringLowerCase(GetStringLeft(sCom, 9)) == ".craft tr")
       iOffset =  26;
    else if (GetStringLowerCase(GetStringLeft(sCom, 9)) == ".craft we")
       iOffset =  27;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".disa")
       iOffset =  28;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".disc")
       iOffset =  29;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".heal")
       iOffset =  31;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".hide")
       iOffset =  32;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".inti")
       iOffset =  33;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".list")
       iOffset =  34;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".lore")
       iOffset =  35;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".move")
       iOffset =  36;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".open")
       iOffset =   37;
     else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".parr")
       iOffset =  38;
     else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".perf")
       iOffset =  39;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".pers")
       iOffset =  41;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".pick")
       iOffset =  42;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".sear")
       iOffset =  43;
    else if (GetStringLowerCase(GetStringLeft(sCom, 6)) == ".set t")
       iOffset =  44;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".spel")
       iOffset =  45;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".spot")
       iOffset =  46;
     else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".taun")
       iOffset =   47;
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".tumb")
       iOffset =  48;
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".use")
       iOffset =   49;

    if (iOffset!=0)
    {
        if (FindSubString(GetStringLowerCase(sCom), "all") != -1)
            SetLocalInt(oPC, "dmfi_univ_int", iOffset+40);
        else
            SetLocalInt(oPC, "dmfi_univ_int", iOffset);

        SetLocalString(oPC, "dmfi_univ_conv", "dicebag");
        //SetLocalObject(oPC, "dmfi_univ_target", oNPC);
        //should still send last DMFI target
        if (!GetIsObjectValid(GetLocalObject(oPC, "dmfi_univ_target")))
        {
            SetLocalObject(oPC, "dmfi_univ_target", oNPC);
            SendMessageToPC(oPC, "No valid DMFI target:  Transferred to voice widget target");
        }

        ExecuteScript("dmfi_execute", oPC);
        dmw_CleanUp(oPC);
        return;
    }


    if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".set")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        while (sCom != "")
        {
            if (GetStringLeft(sCom, 1) == " " ||
                GetStringLeft(sCom, 1) == "[" ||
                GetStringLeft(sCom, 1) == "." ||
                GetStringLeft(sCom, 1) == ":" ||
                GetStringLeft(sCom, 1) == ";" ||
                GetStringLeft(sCom, 1) == "*" ||
                GetIsAlphanumeric(GetStringLeft(sCom, 1)))
                sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            else
            {
                SetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sCom, 1), oNPC);
                FloatingTextStringOnCreature("The Control character for " + GetName(oNPC) + " is " + GetStringLeft(sCom, 1), oPC, FALSE);
                return;
            }
        }
        FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".ani")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            AssignCommand(oNPC, ClearAllActions(TRUE));
            AssignCommand(oNPC, ActionPlayAnimation(iCom, 1.0, 99999.0f));
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".buf")
    {
        if (FindSubString(GetStringLowerCase(sCom), "low") !=-1)
            {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(3, AC_NATURAL_BONUS), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_BARKSKIN), oNPC, 3600.0f);
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_RESISTANCE, oNPC, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, oNPC, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_CLARITY,  oNPC,METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            FloatingTextStringOnCreature("Low Buff applied: " + GetName(oNPC), oPC);   return;
            }
        else if (FindSubString(GetStringLowerCase(sCom), "mid") !=-1)
            {
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_LESSER_SPELL_MANTLE, oNPC, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_STONESKIN, oNPC, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD,  oNPC,METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            FloatingTextStringOnCreature("Mid Buff applied: " + GetName(oNPC), oPC);  return;
            }
         else if (FindSubString(GetStringLowerCase(sCom), "high") !=-1)
            {
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_SPELL_MANTLE, oNPC, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_STONESKIN, oNPC, METAMAGIC_ANY, TRUE,15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_SHADOW_SHIELD,  oNPC,METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            FloatingTextStringOnCreature("High Buff applied: " + GetName(oNPC), oPC);  return;
            }
        else if (FindSubString(GetStringLowerCase(sCom), "epic") !=-1)
            {
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_GREATER_SPELL_MANTLE, oNPC, METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_SPELL_RESISTANCE, oNPC, METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_SHADOW_SHIELD,  oNPC,METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            AssignCommand(oNPC, ActionCastSpellAtObject(SPELL_CLARITY,  oNPC,METAMAGIC_ANY, TRUE, 20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
            FloatingTextStringOnCreature("Epic Buff applied: " + GetName(oNPC), oPC);  return;
            }
        else if (FindSubString(GetStringLowerCase(sCom), "barkskin") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(3, AC_NATURAL_BONUS), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_BARKSKIN), oNPC, 3600.0f);  return;
        }
        else if (FindSubString(GetStringLowerCase(sCom), "elements") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_COLD, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_FIRE, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_ACID, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_SONIC, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 20, 40), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS), oNPC, 3600.0f);  return;
        }
        else if (FindSubString(GetStringLowerCase(sCom), "haste") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHaste(), oNPC, 3600.0f);  return;
        }
        else if (FindSubString(GetStringLowerCase(sCom), "invis") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oNPC, 3600.0f);   return;
        }
        else if (FindSubString(GetStringLowerCase(sCom), "unplot") != -1)
        {
            SetPlotFlag(oNPC, FALSE);
            FloatingTextStringOnCreature("The target is set to non-Plot.", oPC, FALSE); return;
        }
        else if (FindSubString(GetStringLowerCase(sCom), "plot") != -1)
        {
            SetPlotFlag(oNPC, TRUE);
            FloatingTextStringOnCreature("The target is set to Plot.", oPC, FALSE);  return;
        }
        else if (FindSubString(GetStringLowerCase(sCom), "stoneskin") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageReduction(10, DAMAGE_POWER_PLUS_THREE, 100), oNPC, 3600.0f);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN), oNPC, 3600.0f); return;
        }
        else if (FindSubString(GetStringLowerCase(sCom), "trues") != -1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTrueSeeing(), oNPC, 3600.0f); return;
        }
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".dam")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iCom, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL), oNPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), oNPC);
            FloatingTextStringOnCreature(GetName(oNPC) + " has taken " + sCom + " damage.", oPC, FALSE);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 5)) == ".dism")
    {
        DestroyObject(oNPC);
        FloatingTextStringOnCreature(GetName(oNPC) + " dismissed", oPC, FALSE); return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".inv")
    {
        OpenInventory(oNPC, oPC);
        FloatingTextStringOnCreature(GetName(oNPC) + " dismissed", oPC, FALSE); return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".dmt")
    {
        SetLocalInt(GetModule(), "dmfi_DMToolLock", abs(GetLocalInt(GetModule(), "dmfi_DMToolLock") -1)); return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".dms")
    {
        SetDMFIPersistentInt("dmfi", "dmfi_DMSpy", abs(GetDMFIPersistentInt("dmfi", "dmfi_DMSpy", oPC) -1), oPC); return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fac")
    {
        if (FindSubString(GetStringLowerCase(sCom), "hostile") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
            FloatingTextStringOnCreature("Faction set to hostile", oPC, FALSE);
            if (GetIsImmune(oNPC, IMMUNITY_TYPE_BLINDNESS))
            {
            SendMessageToPC(oPC, "Targeted creature is blind immune - no attack will occur until new perception event is fired");
            return;
            }
            else
            {
            effect eInvis =EffectBlindness();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oNPC, 6.1);
            SendMessageToPC(oPC, "Faction Adjusted - will take effect in 6 seconds");
            return;
           }


       }
        else if (FindSubString(GetStringLowerCase(sCom), "commoner") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_COMMONER);
            FloatingTextStringOnCreature("Faction set to commoner", oPC, FALSE);
            if (GetIsImmune(oNPC, IMMUNITY_TYPE_BLINDNESS))
            {
                SendMessageToPC(oPC, "Targeted creature is blind immune - no attack will occur until new perception event is fired");
                return;
            }
            else
            {
                effect eInvis =EffectBlindness();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oNPC, 6.1);
                SendMessageToPC(oPC, "Faction Adjusted - will take effect in 6 seconds");
                return;
            }
        }
        else if (FindSubString(GetStringLowerCase(sCom), "defender") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_DEFENDER);
            FloatingTextStringOnCreature("Faction set to defender", oPC, FALSE);
            if (GetIsImmune(oNPC, IMMUNITY_TYPE_BLINDNESS))
            {
                SendMessageToPC(oPC, "Targeted creature is blind immune - no attack will occur until new perception event is fired");
                return;
            }
            else
            {
                effect eInvis =EffectBlindness();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oNPC, 6.1);
                SendMessageToPC(oPC, "Faction Adjusted - will take effect in 6 seconds");
                return;
            }
        }
        else if (FindSubString(GetStringLowerCase(sCom), "merchant") != -1)
        {
            ChangeToStandardFaction(oNPC, STANDARD_FACTION_MERCHANT);
            FloatingTextStringOnCreature("Faction set to merchant", oPC, FALSE);
            if (GetIsImmune(oNPC, IMMUNITY_TYPE_BLINDNESS))
            {
                SendMessageToPC(oPC, "Targeted creature is blind immune - no attack will occur until new perception event is fired");
                return;
            }
            else
            {
                effect eInvis =EffectBlindness();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oNPC, 6.1);
                SendMessageToPC(oPC, "Faction Adjusted - will take effect in 6 seconds");
                return;
            }
        }
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fle")
    {
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, ActionMoveAwayFromObject(oPC, TRUE));
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fly")
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(), oNPC);
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fol")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            FloatingTextStringOnCreature(GetName(oNPC) + " will follow you for "+sCom+" seconds.", oPC, FALSE);
            AssignCommand(oNPC, ClearAllActions(TRUE));
            AssignCommand(oNPC, ActionForceMoveToObject(oPC, TRUE, 2.0f, IntToFloat(iCom)));
            DelayCommand(IntToFloat(iCom), FloatingTextStringOnCreature(GetName(oNPC) + " has stopped following you.", oPC, FALSE));
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".fre")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " frozen", oPC, FALSE);
        SetCommandable(TRUE, oNPC);
        AssignCommand(oNPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, SetCommandable(FALSE, oNPC));
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".get")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        while (sCom != "")
        {
            if (GetStringLeft(sCom, 1) == " " ||
                GetStringLeft(sCom, 1) == "[" ||
                GetStringLeft(sCom, 1) == "." ||
                GetStringLeft(sCom, 1) == ":" ||
                GetStringLeft(sCom, 1) == ";" ||
                GetStringLeft(sCom, 1) == "*" ||
                GetIsAlphanumeric(GetStringLeft(sCom, 1)))
                sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            else
            {
                object oJump = GetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sCom, 1));
                if (GetIsObjectValid(oJump))
                {
                    AssignCommand(oJump, ClearAllActions());
                    AssignCommand(oJump, ActionJumpToLocation(GetLocation(oPC)));
                    return;
                }
                else
                    FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
                return;
            }
        }
        FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
        return;

    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".got")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        while (sCom != "")
        {
            if (GetStringLeft(sCom, 1) == " " ||
                GetStringLeft(sCom, 1) == "[" ||
                GetStringLeft(sCom, 1) == "." ||
                GetStringLeft(sCom, 1) == ":" ||
                GetStringLeft(sCom, 1) == ";" ||
                GetStringLeft(sCom, 1) == "*" ||
                GetIsAlphanumeric(GetStringLeft(sCom, 1)))
                sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            else
            {
                object oJump = GetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sCom, 1));
                if (GetIsObjectValid(oJump))
                {
                    AssignCommand(oPC, ClearAllActions());
                    AssignCommand(oPC, ActionJumpToLocation(GetLocation(oJump)));
                }
                else
                    FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
                return;
            }
        }
        FloatingTextStringOnCreature("Your Control Character is not valid. Perhaps you are using a reserved character.", oPC, FALSE);
       return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".hea")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(iCom), oNPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_M), oNPC);
            FloatingTextStringOnCreature(GetName(oNPC) + " has healed " + sCom + " hp.", oPC, FALSE);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".ite")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            object oCreate = CreateItemOnObject(sCom, oNPC, 1);
            if (GetIsObjectValid(oCreate))
                FloatingTextStringOnCreature("Item " + GetName(oCreate) + " created.", oPC, FALSE);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".lan") //sets the language of the target
    {
        int iSpace = FindSubString(sCom, " ");
        int iLang = 0;
        if (iSpace != -1)
            iLang = LangFromName(GetStringRight(sCom, GetStringLength(sCom) - iSpace - 1));
        if (!iLang)
        {
            FloatingTextStringOnCreature("Unknown language. Use .lan <elven|gnome|halfling|dwarven|orc|goblin|draconic|animal|cant|celestial|abyssal|infernal|drow>", oPC, FALSE);
            return;
        }
        SetLocalInt(oNPC, DMFI_LANG_VAR_SPEAKING, iLang);
        SetLocalString(oNPC, DMFI_LANG_VAR_SPEAKING_NAME, LangName(iLang));
        FloatingTextStringOnCreature("Language set to " + LangName(iLang), oPC, FALSE);
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".mut")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " muted", oPC, FALSE);
        SetLocalInt(oNPC, "dmfi_Mute", 1);
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".npc")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            object oCreate = CreateObject(OBJECT_TYPE_CREATURE, sCom, GetLocation(oNPC));
            if (GetIsObjectValid(oCreate))
                FloatingTextStringOnCreature("NPC " + GetName(oCreate) + " created.", oPC, FALSE);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".pla")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            object oCreate = CreateObject(OBJECT_TYPE_PLACEABLE, sCom, GetLocation(oNPC));
            if (GetIsObjectValid(oCreate))
                FloatingTextStringOnCreature("Placeable " + GetName(oCreate) + " created.", oPC, FALSE);
            return;
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".rem")
    {
        effect eRemove = GetFirstEffect(oNPC);
        while (GetIsEffectValid(eRemove))
        {
            RemoveEffect(oNPC, eRemove);
            eRemove = GetNextEffect(oNPC);
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".say")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 5);
        int iCom = StringToInt(sCom);
        if (GetDMFIPersistentString("dmfi", "hls206" + IntToString(iCom)) != "")
        {
            AssignCommand(oNPC, SpeakString(GetDMFIPersistentString("dmfi", "hls206" + IntToString(iCom))));
        }
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".tar")
    {
        object oGet = GetFirstObjectInArea(GetArea(oPC));
        if (GetStringLeft(sCom, 5) == ".tar ") sCom = GetStringRight(sCom, GetStringLength(sCom) - 5);
        else if (GetStringLeft(sCom, 8) == ".target ") sCom = GetStringRight(sCom, GetStringLength(sCom) - 8);
        while (GetIsObjectValid(oGet))
        {
            if (FindSubString(GetName(oGet), sCom) != -1)
            {
                SetLocalObject(oPC, "dmfi_VoiceTarget", oGet);
                FloatingTextStringOnCreature("You have targeted " + GetName(oGet) + " with the Voice Widget", oPC, FALSE);
                return;
            }
            oGet = GetNextObjectInArea(GetArea(oPC));
        }
        FloatingTextStringOnCreature("Target not found.", oPC, FALSE);
        return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".unf")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " unfrozen", oPC, FALSE);
        SetCommandable(TRUE, oNPC); return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".unm")
    {
        FloatingTextStringOnCreature(GetName(oNPC) + " un-muted", oPC, FALSE);
        DeleteLocalInt(oNPC, "dmfi_Mute"); return;
    }
    else if (GetStringLowerCase(GetStringLeft(sCom, 4)) == ".vfx")
    {
        sCom = GetStringRight(sCom, GetStringLength(sCom) - 4);
        //Parses the characters until there is a space.
        while (GetStringLeft(sCom, 1) != " " && sCom != "")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
        }
        if (sCom != "" && GetStringLeft(sCom, 1) == " ")
        {
            sCom = GetStringRight(sCom, GetStringLength(sCom) - 1);
            int iCom = StringToInt(sCom);
            if (GetTag(oNPC) == "dmfi_voice")
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(iCom), GetLocation(oNPC), 10.0f);
            else
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(iCom), oNPC, 10.0f);
            return;
        }
        return;
    }
}

// Clears the duplicate-line guard once the same chat line has been heard by
// every voice listener, so a player can repeat a line a moment later.
void ClearVoiceBuffer(string sBufferKey)
{
    if (GetLocalString(GetModule(), "hls_voicebuffer") == sBufferKey)
        DeleteLocalString(GetModule(), "hls_voicebuffer");
}

void TranslateToLanguage(string sSaid, object oShouter)
{
    int iTranslate = GetSpokenLanguage(oShouter);

    // Drop the opening "[" and the closing "]" (and any space before it).
    sSaid = GetStringRight(sSaid, GetStringLength(sSaid) - 1);
    while (GetStringRight(sSaid, 1) == "]" || GetStringRight(sSaid, 1) == " ")
        sSaid = GetStringLeft(sSaid, GetStringLength(sSaid) - 1);

    // [dwarven: text] speaks this one line in another language.
    int iColon = FindSubString(sSaid, ":");
    if (iColon > 0 && iColon <= DMFI_LANG_PREFIX_MAX_LENGTH)
    {
        int iOverride = LangFromName(GetStringLeft(sSaid, iColon));
        if (iOverride)
        {
            if (GetIsPC(oShouter) && !GetKnowsLanguage(oShouter, iOverride))
            {
                SendMessageToPC(oShouter, "You do not speak " + LangName(iOverride) + ".");
                return;
            }
            iTranslate = iOverride;
            sSaid = GetStringRight(sSaid, GetStringLength(sSaid) - iColon - 1);
            while (GetStringLeft(sSaid, 1) == " ")
                sSaid = GetStringRight(sSaid, GetStringLength(sSaid) - 1);
        }
    }

    if (!iTranslate)
    {
        SendMessageToPC(oShouter, "You have no language set. Type .languages to see your options.");
        return;
    }
    if (sSaid == "") return;

    LangSpeak(oShouter, iTranslate, sSaid);
}

void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();

    if (GetIsDM(oShouter))
        SetLocalInt(GetModule(), "dmfi_Admin" + GetPCPublicCDKey(oShouter), 1);

    if (GetIsDMPossessed(oShouter))
        SetLocalObject(GetMaster(oShouter), "dmfi_familiar", oShouter);

    object oTarget = GetLocalObject(oShouter, "dmfi_VoiceTarget");
    object oMaster = OBJECT_INVALID;
    if (GetIsObjectValid(oTarget))
        oMaster = oShouter;

    int iPhrase = GetLocalInt(oShouter, "hls_EditPhrase");

    object oSummon;

    if (nMatch == LISTEN_PATTERN && GetIsObjectValid(oShouter) && GetIsDM(oShouter))
    {
        string sSaid = GetMatchedSubstring(0);

        if (GetTag(OBJECT_SELF) == "dmfi_setting" && GetLocalString(oShouter, "EffectSetting") != "")
        {
            string sPhrase = GetLocalString(oShouter, "EffectSetting");
            SetLocalFloat(oShouter, sPhrase, StringToFloat(sSaid));
            SetDMFIPersistentFloat("dmfi", sPhrase, StringToFloat(sSaid), oShouter);
            DeleteLocalString(oShouter, "EffectSetting");
            DelayCommand(0.5, ActionSpeakString("The setting " + sPhrase + " has been changed to " + FloatToString(GetLocalFloat(oShouter, sPhrase))));
            DelayCommand(1.5, DestroyObject(OBJECT_SELF));
            //maybe add a return here
        }
    }

    if (nMatch == LISTEN_PATTERN && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
    {
        string sSaid = GetMatchedSubstring(0);

        string sBufferKey = ObjectToString(oShouter) + "|" + sSaid;
        if (sBufferKey == GetLocalString(GetModule(), "hls_voicebuffer"))
            return; // the same line heard by a second voice listener
        SetLocalString(GetModule(), "hls_voicebuffer", sBufferKey);
        AssignCommand(GetModule(), DelayCommand(1.0, ClearVoiceBuffer(sBufferKey)));
        // DM spy code right at the top - this basically will send the DM what has been spoken anywhere
        if (GetDMFIPersistentInt("dmfi", "dmfi_DMSpy"))
            {
                object oTempPC = GetFirstPC();
                while(GetIsObjectValid(oTempPC))
                {
                    if (GetIsDM(oTempPC))
                    {
                        if (GetDMFIPersistentInt("dmfi", "dmfi_DMSpy", oTempPC))
                        {
                        if (GetIsPC(GetLocalObject(oTempPC, "dmfi_familiar")))
                            SendMessageToPC(GetLocalObject(oTempPC, "dmfi_familiar"), "(" + GetName(GetArea(oShouter)) + ") " + GetName(oShouter) + ": " + sSaid);
                        else
                            SendMessageToPC(oTempPC, "(" + GetName(GetArea(oShouter)) + ") " + GetName(oShouter) + ": " + sSaid);
                        }
                    }
                oTempPC = GetNextPC();
                }
            }

        PrintString("<Conv>"+GetName(GetArea(oShouter))+ " " + GetName(oShouter) + ": " + sSaid + " </Conv>");
        //if the phrase begins with .MyName, reparse the string as a voice throw
        if (GetStringLeft(sSaid, GetStringLength("." + GetName(OBJECT_SELF))) == "." + GetName(OBJECT_SELF) &&
            (GetLocalInt(GetModule(), "dmfi_Admin" + GetPCPublicCDKey(oShouter)) ||
             GetIsDM(oShouter) || GetIsDMPossessed(oShouter)))

        {
            oTarget = OBJECT_SELF;
            sSaid = GetStringRight(sSaid, GetStringLength(sSaid) - GetStringLength("." + GetName(OBJECT_SELF)));
            if (GetStringLeft(sSaid, 1) == " ") sSaid = GetStringRight(sSaid, GetStringLength(sSaid) - 1);
            sSaid = ":" + sSaid;
            return;
        }

        if (iPhrase)
        {
            SetCustomToken(iPhrase, sSaid);
            SetDMFIPersistentString("dmfi", "hls" + IntToString(iPhrase), sSaid);
            DeleteLocalInt(oShouter, "hls_EditPhrase");
            FloatingTextStringOnCreature("Phrase " + IntToString(iPhrase) + " has been recorded", oShouter, FALSE);

            return;
        }

        if (GetStringLeft(sSaid, 1) == "[")
        {
            TranslateToLanguage(sSaid, oShouter);
            return;
        }

        if (GetStringLeft(sSaid, 1) == "*" && !GetLocalInt(oShouter, "hls_emotemute"))
        {
            ParseEmote(sSaid, oShouter);
            return;
        }

        if (GetStringLeft(sSaid, 1) == ":")
        {
            //This "throws" your voice to an object and properly dumps it into the log
            if (GetIsObjectValid(oTarget))
            {
                sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);

                if (GetStringLeft(sSaid, 1) == "[")
                    {
                    TranslateToLanguage(sSaid, oTarget);
                    return;
                    }

                if (GetStringLeft(sSaid, 1) == "*")
                    {
                    ParseEmote(sSaid, oTarget);
                    return;
                    }

             AssignCommand(oTarget, SpeakString(sSaid));
             //PrintString("<Conv>"+GetName(GetArea(oTarget))+ " " + GetName(oTarget) + ": " + sSaid + " </Conv>");
             return;
            }
        return;
        }

        if (GetStringLeft(sSaid, 1) == ";" && //Voicethrow ";" prioritizes animal companions
        (GetIsObjectValid(GetMaster(oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter))))
        {
            if (GetIsObjectValid(GetMaster(oShouter)))
                oSummon = GetMaster(oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter);

            if (GetIsObjectValid(oSummon))
            {
                sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);

                if (GetStringLeft(sSaid, 1) == "[")
                    {
                    TranslateToLanguage(sSaid, oSummon);
                    return;
                    }

                if (GetStringLeft(sSaid, 1) == "*")
                    {
                    ParseEmote(sSaid, oSummon);
                    return;
                    }

                AssignCommand(oSummon, SpeakString(sSaid));
                PrintString("<Conv>"+GetName(GetArea(oSummon))+ " " + GetName(oSummon) + ": " + sSaid + " </Conv>");
                return;
            }
        return;
        }

        if (GetStringLeft(sSaid, 1) == "," && //Voicethrow "," prioritizes summons
        (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter)) ||
        GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter))))
        {
            if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oShouter);
            else if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter)))
                oSummon = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oShouter);

           if (GetIsObjectValid(oSummon))
            {
                sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);

                if (GetStringLeft(sSaid, 1) == "[")
                    {
                    TranslateToLanguage(sSaid, oSummon);
                    return;
                    }

                if (GetStringLeft(sSaid, 1) == "*")
                    {
                    ParseEmote(sSaid, oSummon);
                    return;
                    }

                AssignCommand(oSummon, SpeakString(sSaid));
                PrintString("<Conv>"+GetName(GetArea(oSummon))+ " " + GetName(oSummon) + ": " + sSaid + " </Conv>");
                return;
            }
        return;
        }

        if (GetIsObjectValid(GetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sSaid, 1))) && GetLocalInt(GetModule(), "dmfi_Admin" + GetPCPublicCDKey(oShouter)))
        {
            object oControl = GetLocalObject(GetModule(), "hls_NPCControl" + GetStringLeft(sSaid, 1));
            sSaid = GetStringRight(sSaid, GetStringLength(sSaid)-1);

            if (GetStringLeft(sSaid, 1) == "[")
            {
                TranslateToLanguage(sSaid, oControl);
                return;
            }
            if (GetStringLeft(sSaid, 1) == "*")
            {
                ParseEmote(sSaid, oControl);
                return;
            }
            if (GetStringLeft(sSaid, 1) == ".")
            {
                ParseCommand(oControl, oShouter, sSaid);
                return;
            }

            //This "throws" your voice to an object and properly dumps it into the log
            AssignCommand(oControl, SpeakString(sSaid));
            PrintString("<Conv>"+GetName(GetArea(oControl))+ " " + GetName(oControl) + ": " + sSaid + " </Conv>");
            return;
        }

        if (GetStringLeft(sSaid, 1) == "." && GetIsObjectValid(oMaster))
        {
            ParseCommand(oTarget, oMaster, sSaid);
            return;
        }



    }
}
