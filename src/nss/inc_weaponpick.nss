// Weapon/armor picker extracted from tfn-adventurers' inc_rand_equip.nss -
// NOT the tiered-loot-chest equip system (needs NWNX_Item/NWNX_Creature_RunEquip
// and a pre-built chest library this module doesn't have), just the parts that
// map a creature's own proficiency feats to a stock BASE_ITEM_*/resref:
//   RollRandomWeaponTypesForCreature() - proficiency-aware weapon/offhand type
//   GetMundaneWeaponOfType()           - BASE_ITEM_* -> a real stock item resref
//   GetMundaneArmorOfAC()              - AC tier (0-8) -> a real stock cloth-line armor resref
// See area_recall.nss for how these get combined into an actual equip.
#include "inc_array"

struct RandomWeaponResults
{
    int nMainHand;
    int nOffHand;
    int nBackupMeleeWeapon;
};

// Returns a struct containing BASE_ITEM_* constants for suitable main and offhand items of oCreature.
// The members are BASE_TYPE constants
// nMainHand, nOffHand, nBackupMeleeWeapon
struct RandomWeaponResults RollRandomWeaponTypesForCreature(object oCreature);


const string RAND_EQUIP_PREFER_BOW = "rand_equip_prefer_bow";
const string RAND_EQUIP_NO_SHIELD = "rand_equip_no_shield";
const string RAND_EQUIP_FORCE_SHIELD = "rand_equip_force_shield";

const string RAND_EQUIP_TEMP_ARRAY = "rand_equip_temp";
const string RAND_EQUIP_TEMP_WEIGHT_ARRAY = "rand_equip_weight_temp";

struct CreatureProficiencies
{
    int bMartial;
    int bExotic;
    int bDruid;
    int bElf;
    int bMonk;
    int bRogue;
    int bSimple;
    int bWizard;
};

struct CreatureProficiencies GetCreatureWeaponProficiencies(object oCreature);



//////////////////////////////

struct CreatureProficiencies GetCreatureWeaponProficiencies(object oCreature)
{
    struct CreatureProficiencies cpOut;
    cpOut.bMartial = GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oCreature);
    cpOut.bDruid = GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oCreature);
    cpOut.bExotic = GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCreature);
    cpOut.bElf = GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oCreature);
    cpOut.bMonk = GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oCreature);
    cpOut.bRogue = GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oCreature);
    cpOut.bSimple = GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oCreature);
    cpOut.bWizard = GetHasFeat(FEAT_WEAPON_PROFICIENCY_WIZARD, oCreature);
    return cpOut;
}

// 38 total, these are weapon types enumerated to 0-37 inclusive
const int RAND_EQUIP_NUM_WEAPONTYPES = 38;

int _GetWeaponTypeByIndex(int nIndex)
{
    // This is a bit of a hack, and assumes normal baseitems.2da
    if (nIndex <= 13)
    {
        // 14: smallshield is the first nonweapon item
        return nIndex;
    }
    if (nIndex == 14)
    {
        return BASE_ITEM_GREATAXE;
    }
    if (nIndex == 15)
    {
        return BASE_ITEM_DAGGER;
    }
    if (nIndex == 16)
    {
        return BASE_ITEM_CLUB;
    }
    if (nIndex >= 17 && nIndex <= 19)
    {
        // Dart (31) to doubleaxe (33)
        return (nIndex + 14);
    }
    if (nIndex == 20)
    {
        return BASE_ITEM_HEAVYFLAIL;
    }
    if (nIndex == 21)
    {
        return BASE_ITEM_LIGHTHAMMER;
    }
    if (nIndex == 22)
    {
        return BASE_ITEM_HANDAXE;
    }
    if (nIndex >= 23 && nIndex <= 25)
    {
        // Kama (40) to kukri (42)
        return (nIndex + 17);
    }
    if (nIndex == 26)
    {
        return BASE_ITEM_MORNINGSTAR;
    }
    if (nIndex == 27)
    {
        return BASE_ITEM_QUARTERSTAFF;
    }
    if (nIndex == 28)
    {
        return BASE_ITEM_RAPIER;
    }
    if (nIndex == 29)
    {
        return BASE_ITEM_SCIMITAR;
    }
    if (nIndex == 30)
    {
        return BASE_ITEM_SCYTHE;
    }
    if (nIndex >= 31 && nIndex <= 34)
    {
        // Spear (58) to sling (61)
        return (nIndex + 27);
    }
    if (nIndex == 35)
    {
        return BASE_ITEM_TRIDENT;
    }
    if (nIndex == 36)
    {
        return BASE_ITEM_DWARVENWARAXE;
    }
    if (nIndex == 37)
    {
        return BASE_ITEM_WHIP;
    }
    return BASE_ITEM_INVALID;
}

int _GetWeaponSize(int nBaseItem)
{
    return StringToInt(Get2DAString("baseitems", "WeaponSize", nBaseItem));
}


// I don't know how fast 2da lookups are these days, so much of this is hardcoded
// TFN is meant to be mostly vanilla anyways...

// Internal function, returns how "good" a weapon type is
// The picker is heavily biased towards bigger numbers
// Essentially, setting "high proficiency required" weapons with bigger numbers
// makes them show up most of the time on the few creatures able to use them
int _GetScoreForWeaponType(int nBaseItem, object oCreature)
{
    // For now, this just makes diagonal stripes across a table of proficiencies vs sizes
    // I'm assuming 2h weapons get a -1 to their scores due to being 2h
    // or anything with exotic would be virtually guaranteed to have a diremace/scythe/2bsword etc
    int nScore = 0;
    int nWeaponSize = _GetWeaponSize(nBaseItem);
    int nCreatureSize = GetCreatureSize(oCreature);
    int nSizeDiff = nWeaponSize - nCreatureSize;
    if (nSizeDiff > 1)
    {
        return -1;
    }
    if (nSizeDiff == 1)
    {
        nScore -= 1;
    }
    switch (nBaseItem)
    {
        case BASE_ITEM_DAGGER:
        case BASE_ITEM_DART:
        {
            nScore += 10;
            break;
        }
        case BASE_ITEM_LIGHTCROSSBOW:
        case BASE_ITEM_LIGHTMACE:
        case BASE_ITEM_SICKLE:
        case BASE_ITEM_SLING:
        {
            nScore += 30;
            break;
        }
        case BASE_ITEM_KUKRI:
        case BASE_ITEM_SHURIKEN:
        case BASE_ITEM_HANDAXE:
        case BASE_ITEM_LIGHTHAMMER:
        case BASE_ITEM_SHORTSWORD:
        case BASE_ITEM_THROWINGAXE:
        case BASE_ITEM_CLUB:
        case BASE_ITEM_HEAVYCROSSBOW:
        case BASE_ITEM_MORNINGSTAR:
        {
            nScore += 90;
            break;
        }
        case BASE_ITEM_KAMA:
        case BASE_ITEM_WHIP:
        case BASE_ITEM_BATTLEAXE:
        case BASE_ITEM_LIGHTFLAIL:
        case BASE_ITEM_LONGSWORD:
        case BASE_ITEM_RAPIER:
        case BASE_ITEM_SCIMITAR:
        case BASE_ITEM_SHORTBOW:
        case BASE_ITEM_WARHAMMER:
        case BASE_ITEM_SHORTSPEAR:
        case BASE_ITEM_QUARTERSTAFF:
        {
            nScore += 270;
            break;
        }
        case BASE_ITEM_BASTARDSWORD:
        case BASE_ITEM_DWARVENWARAXE:
        case BASE_ITEM_KATANA:
        case BASE_ITEM_GREATAXE:
        case BASE_ITEM_GREATSWORD:
        case BASE_ITEM_HALBERD:
        case BASE_ITEM_HEAVYFLAIL:
        case BASE_ITEM_LONGBOW:
        case BASE_ITEM_TRIDENT:
        {
            nScore += 800;
            break;
        }
        case BASE_ITEM_DIREMACE:
        case BASE_ITEM_DOUBLEAXE:
        case BASE_ITEM_SCYTHE:
        case BASE_ITEM_TWOBLADEDSWORD:
        {
            nScore += 2400;
            break;
        }
    }
    return nScore;
}

int _CanUseWeaponTypeWithProficiencies(struct CreatureProficiencies cpCreature, int nBaseItem)
{
    if (cpCreature.bSimple)
    {
        if (nBaseItem == BASE_ITEM_DAGGER || nBaseItem == BASE_ITEM_DART ||
            nBaseItem == BASE_ITEM_LIGHTCROSSBOW || nBaseItem == BASE_ITEM_LIGHTMACE ||
            nBaseItem == BASE_ITEM_SICKLE || nBaseItem == BASE_ITEM_SLING ||
            nBaseItem == BASE_ITEM_CLUB || nBaseItem == BASE_ITEM_HEAVYCROSSBOW ||
            nBaseItem == BASE_ITEM_MORNINGSTAR || nBaseItem == BASE_ITEM_QUARTERSTAFF ||
            nBaseItem == BASE_ITEM_SHORTSPEAR)
        {
            return 1;
        }
    }
    if (cpCreature.bMartial)
    {
        if (nBaseItem == BASE_ITEM_HANDAXE || nBaseItem == BASE_ITEM_LIGHTHAMMER ||
            nBaseItem == BASE_ITEM_SHORTSWORD || nBaseItem == BASE_ITEM_THROWINGAXE ||
            nBaseItem == BASE_ITEM_LONGSWORD || nBaseItem == BASE_ITEM_RAPIER ||
            nBaseItem == BASE_ITEM_SCIMITAR || nBaseItem == BASE_ITEM_SHORTBOW ||
            nBaseItem == BASE_ITEM_WARHAMMER || nBaseItem == BASE_ITEM_GREATAXE ||
            nBaseItem == BASE_ITEM_GREATSWORD || nBaseItem == BASE_ITEM_HALBERD ||
            nBaseItem == BASE_ITEM_HEAVYFLAIL || nBaseItem == BASE_ITEM_LONGBOW ||
            nBaseItem == BASE_ITEM_TRIDENT)
        {
            return 1;
        }
    }
    if (cpCreature.bExotic)
    {
        if (nBaseItem == BASE_ITEM_KUKRI || nBaseItem == BASE_ITEM_SHURIKEN ||
            nBaseItem == BASE_ITEM_KAMA || nBaseItem == BASE_ITEM_WHIP ||
            nBaseItem == BASE_ITEM_BASTARDSWORD || nBaseItem == BASE_ITEM_DWARVENWARAXE ||
            nBaseItem == BASE_ITEM_KATANA || nBaseItem == BASE_ITEM_DIREMACE ||
            nBaseItem == BASE_ITEM_DOUBLEAXE || nBaseItem == BASE_ITEM_SCYTHE ||
            nBaseItem == BASE_ITEM_TWOBLADEDSWORD)
        {
            return 1;
        }
    }
    if (cpCreature.bDruid)
    {
        if (nBaseItem == BASE_ITEM_CLUB || nBaseItem == BASE_ITEM_DAGGER ||
            nBaseItem == BASE_ITEM_DART || nBaseItem == BASE_ITEM_QUARTERSTAFF ||
            nBaseItem == BASE_ITEM_SCIMITAR || nBaseItem == BASE_ITEM_SICKLE ||
            nBaseItem == BASE_ITEM_SHORTSPEAR || nBaseItem == BASE_ITEM_SLING)
        {
            return 1;
        }
    }
    if (cpCreature.bElf)
    {
        if (nBaseItem == BASE_ITEM_LONGSWORD || nBaseItem == BASE_ITEM_RAPIER ||
            nBaseItem == BASE_ITEM_LONGBOW || nBaseItem == BASE_ITEM_SHORTBOW)
        {
            return 1;
        }
    }
    if (cpCreature.bMonk)
    {
        if (nBaseItem == BASE_ITEM_CLUB || nBaseItem == BASE_ITEM_DAGGER ||
            nBaseItem == BASE_ITEM_HANDAXE || nBaseItem == BASE_ITEM_QUARTERSTAFF ||
            nBaseItem == BASE_ITEM_LIGHTCROSSBOW || nBaseItem == BASE_ITEM_HEAVYCROSSBOW ||
            nBaseItem == BASE_ITEM_SHURIKEN || nBaseItem == BASE_ITEM_SLING ||
            nBaseItem == BASE_ITEM_KAMA)
        {
            return 1;
        }
    }
    if (cpCreature.bRogue)
    {
        if (nBaseItem == BASE_ITEM_DAGGER || nBaseItem == BASE_ITEM_DART ||
            nBaseItem == BASE_ITEM_LIGHTCROSSBOW || nBaseItem == BASE_ITEM_LIGHTMACE ||
            nBaseItem == BASE_ITEM_HANDAXE || nBaseItem == BASE_ITEM_SLING ||
            nBaseItem == BASE_ITEM_CLUB || nBaseItem == BASE_ITEM_HEAVYCROSSBOW ||
            nBaseItem == BASE_ITEM_MORNINGSTAR || nBaseItem == BASE_ITEM_QUARTERSTAFF ||
            nBaseItem == BASE_ITEM_RAPIER || nBaseItem == BASE_ITEM_SHORTSWORD ||
            nBaseItem == BASE_ITEM_SHORTBOW)
        {
            return 1;
        }
    }
    if (cpCreature.bWizard)
    {
        if (nBaseItem == BASE_ITEM_CLUB || nBaseItem == BASE_ITEM_DAGGER ||
            nBaseItem == BASE_ITEM_QUARTERSTAFF ||
            nBaseItem == BASE_ITEM_LIGHTCROSSBOW || nBaseItem == BASE_ITEM_HEAVYCROSSBOW)
        {
            return 1;
        }
    }
    return 0;
}


int _GetRandomEquipWeaponTypeWeight(object oCreature, int nBaseItem)
{
    // Saving (weight - 1) is deliberate
    // We add 1 when retrieving these, because an unset var in GetLocalInt returns 0 -> becomes 1, normal weighting
    return (1 + GetLocalInt(oCreature, "rand_equip_weapon_weight_" + IntToString(nBaseItem)));
}

int _IsWeaponTypeFinessable(int nBaseItem)
{
    if (nBaseItem == BASE_ITEM_DAGGER || nBaseItem == BASE_ITEM_HANDAXE ||
        nBaseItem == BASE_ITEM_KAMA || nBaseItem == BASE_ITEM_KUKRI ||
        nBaseItem == BASE_ITEM_LIGHTHAMMER || nBaseItem == BASE_ITEM_LIGHTMACE ||
        nBaseItem == BASE_ITEM_RAPIER || nBaseItem == BASE_ITEM_SHORTSWORD ||
        nBaseItem == BASE_ITEM_SICKLE || nBaseItem == BASE_ITEM_WHIP ||
        nBaseItem == BASE_ITEM_CPIERCWEAPON || nBaseItem == BASE_ITEM_CSLASHWEAPON ||
        nBaseItem == BASE_ITEM_CBLUDGWEAPON || nBaseItem == BASE_ITEM_CSLSHPRCWEAP)
    {
        // Also: unarmed strike
        return 1;
    }
    return 0;
}

int _IsWeaponTypeRanged(int nBaseItem)
{
    if (nBaseItem == BASE_ITEM_LIGHTCROSSBOW || nBaseItem == BASE_ITEM_HEAVYCROSSBOW ||
        nBaseItem == BASE_ITEM_SHORTBOW || nBaseItem == BASE_ITEM_LONGBOW ||
        nBaseItem == BASE_ITEM_SLING || nBaseItem == BASE_ITEM_DART ||
        nBaseItem == BASE_ITEM_THROWINGAXE || nBaseItem == BASE_ITEM_SHURIKEN)
        {
            return 1;
        }
    return 0;
}

int _IsWeaponTypeDoubleSided(int nBaseItem)
{
    if (nBaseItem == BASE_ITEM_DIREMACE || nBaseItem == BASE_ITEM_DOUBLEAXE ||
        nBaseItem == BASE_ITEM_TWOBLADEDSWORD)
    {
        return 1;
    }
    return 0;
}

int _SelectFromRandEquipTempArray(int nWeightSum, object oCreature)
{
    int nTargetWeight = Random(nWeightSum);
    int nLength = Array_Size(RAND_EQUIP_TEMP_ARRAY, GetModule());
    int i;
    for (i=0; i<nLength; i++)
    {
        int nThisWeight = Array_At_Int(RAND_EQUIP_TEMP_WEIGHT_ARRAY, i, GetModule());
        nTargetWeight -= nThisWeight;
        if (nTargetWeight < 0)
        {
            return Array_At_Int(RAND_EQUIP_TEMP_ARRAY, i, GetModule());
        }
    }
    if (nLength == 0)
    {
        return BASE_ITEM_INVALID;
    }
    return Array_At_Int(RAND_EQUIP_TEMP_ARRAY, 0, GetModule());
}


int SelectLightMeleeWeaponType(object oCreature)
{
    if (!GetIsObjectValid(oCreature))
    {
        return BASE_ITEM_INVALID;
    }
    int nCreatureSize = GetCreatureSize(oCreature);
    struct CreatureProficiencies cpProfs = GetCreatureWeaponProficiencies(oCreature);
    int bFinesse = 0;
    if (GetHasFeat(FEAT_WEAPON_FINESSE, oCreature) &&
        GetAbilityModifier(ABILITY_DEXTERITY, oCreature) > GetAbilityModifier(ABILITY_STRENGTH, oCreature))
    {
        bFinesse = 1;
    }
    Array_Clear(RAND_EQUIP_TEMP_ARRAY, GetModule());
    Array_Clear(RAND_EQUIP_TEMP_WEIGHT_ARRAY, GetModule());
    int nIndex = 0;
    int nWeightSum = 0;
    int nBaseItem;
    for (nIndex = 0; nIndex < RAND_EQUIP_NUM_WEAPONTYPES; nIndex++)
    {
        nBaseItem = _GetWeaponTypeByIndex(nIndex);
        if (_CanUseWeaponTypeWithProficiencies(cpProfs, nBaseItem) && !_IsWeaponTypeRanged(nBaseItem))
        {
            if (!bFinesse || _IsWeaponTypeFinessable(nBaseItem))
            {
                int nWeaponSize = _GetWeaponSize(nBaseItem);
                // Light: wpn size is 1+ smaller than creature
                if (nCreatureSize - nWeaponSize > 0)
                {
                    // Whips, morningstars, light flails cannot be offhand weapons
                    if (nBaseItem != BASE_ITEM_WHIP && nBaseItem != BASE_ITEM_MORNINGSTAR && nBaseItem != BASE_ITEM_LIGHTFLAIL)
                    {
                        int nThisScore = _GetScoreForWeaponType(nBaseItem, oCreature);
                        int nWeight = _GetRandomEquipWeaponTypeWeight(oCreature, nBaseItem) * nThisScore * 30;
                        Array_PushBack_Int(RAND_EQUIP_TEMP_ARRAY, nBaseItem, GetModule());
                        Array_PushBack_Int(RAND_EQUIP_TEMP_WEIGHT_ARRAY, nWeight, GetModule());
                        nWeightSum += nWeight;
                    }
                }
            }
        }
    }
    return _SelectFromRandEquipTempArray(nWeightSum, oCreature);
}

int SelectMainHandMeleeWeaponType(object oCreature)
{
    if (!GetIsObjectValid(oCreature))
    {
        return BASE_ITEM_INVALID;
    }
    int nCreatureSize = GetCreatureSize(oCreature);
    struct CreatureProficiencies cpProfs = GetCreatureWeaponProficiencies(oCreature);
    int bFinesse = 0;
    if (GetHasFeat(FEAT_WEAPON_FINESSE, oCreature) &&
        GetAbilityModifier(ABILITY_DEXTERITY, oCreature) > GetAbilityModifier(ABILITY_STRENGTH, oCreature))
    {
        bFinesse = 1;
    }
    Array_Clear(RAND_EQUIP_TEMP_ARRAY, GetModule());
    Array_Clear(RAND_EQUIP_TEMP_WEIGHT_ARRAY, GetModule());
    int nIndex = 0;
    int nWeightSum = 0;
    int nBaseItem;
    for (nIndex = 0; nIndex < RAND_EQUIP_NUM_WEAPONTYPES; nIndex++)
    {
        nBaseItem = _GetWeaponTypeByIndex(nIndex);
        if (_CanUseWeaponTypeWithProficiencies(cpProfs, nBaseItem) && !_IsWeaponTypeRanged(nBaseItem))
        {
            if (!bFinesse || _IsWeaponTypeFinessable(nBaseItem))
            {
                int nWeaponSize = _GetWeaponSize(nBaseItem);
                // Onehanded: weapon can't be bigger than creature
                if (nCreatureSize - nWeaponSize >= 0)
                {
                    int nThisScore = _GetScoreForWeaponType(nBaseItem, oCreature);
                    int nWeight = _GetRandomEquipWeaponTypeWeight(oCreature, nBaseItem) * nThisScore * 30;
                    Array_PushBack_Int(RAND_EQUIP_TEMP_ARRAY, nBaseItem, GetModule());
                    Array_PushBack_Int(RAND_EQUIP_TEMP_WEIGHT_ARRAY, nWeight, GetModule());
                    nWeightSum += nWeight;
                }
            }
        }
    }
    return _SelectFromRandEquipTempArray(nWeightSum, oCreature);
}

int SelectTwoHandedMeleeWeaponType(object oCreature, int bDoubleSided=0)
{
    if (!GetIsObjectValid(oCreature))
    {
        return BASE_ITEM_INVALID;
    }
    int nCreatureSize = GetCreatureSize(oCreature);
    struct CreatureProficiencies cpProfs = GetCreatureWeaponProficiencies(oCreature);
    Array_Clear(RAND_EQUIP_TEMP_ARRAY, GetModule());
    Array_Clear(RAND_EQUIP_TEMP_WEIGHT_ARRAY, GetModule());
    int nIndex = 0;
    int nWeightSum = 0;
    int nBaseItem;
    int bFinesse = 0;
    if (GetHasFeat(FEAT_WEAPON_FINESSE, oCreature) &&
        GetAbilityModifier(ABILITY_DEXTERITY, oCreature) > GetAbilityModifier(ABILITY_STRENGTH, oCreature))
    {
        bFinesse = 1;
    }
    for (nIndex = 0; nIndex < RAND_EQUIP_NUM_WEAPONTYPES; nIndex++)
    {
        nBaseItem = _GetWeaponTypeByIndex(nIndex);
        if (_CanUseWeaponTypeWithProficiencies(cpProfs, nBaseItem) && !_IsWeaponTypeRanged(nBaseItem))
        {
            if (!bDoubleSided ^ _IsWeaponTypeDoubleSided(nBaseItem))
            {
                if (!bFinesse || _IsWeaponTypeFinessable(nBaseItem))
                {
                    int nWeaponSize = _GetWeaponSize(nBaseItem);
                    // Twohanded: weapon must be exactly 1 bigger than creature
                    if (nCreatureSize - nWeaponSize == -1)
                    {
                        int nThisScore = _GetScoreForWeaponType(nBaseItem, oCreature);
                        int nWeight = _GetRandomEquipWeaponTypeWeight(oCreature, nBaseItem) * nThisScore * 30;
                        Array_PushBack_Int(RAND_EQUIP_TEMP_ARRAY, nBaseItem, GetModule());
                        Array_PushBack_Int(RAND_EQUIP_TEMP_WEIGHT_ARRAY, nWeight, GetModule());
                        nWeightSum += nWeight;
                    }
                }
            }
        }
    }
    return _SelectFromRandEquipTempArray(nWeightSum, oCreature);
}

int SelectRangedWeaponType(object oCreature)
{
    if (!GetIsObjectValid(oCreature))
    {
        return BASE_ITEM_INVALID;
    }
    int bRapidShot = GetHasFeat(FEAT_RAPID_SHOT, oCreature);
    int bRapidReload = GetHasFeat(FEAT_RAPID_RELOAD, oCreature);
    int nCreatureSize = GetCreatureSize(oCreature);
    struct CreatureProficiencies cpProfs = GetCreatureWeaponProficiencies(oCreature);
    Array_Clear(RAND_EQUIP_TEMP_ARRAY, GetModule());
    Array_Clear(RAND_EQUIP_TEMP_WEIGHT_ARRAY, GetModule());
    int nIndex = 0;
    int nWeightSum = 0;
    int nBaseItem;

    // Arcane Archer only works with bows
    int bForceBows = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oCreature);

    // if we set a preference for bows, 2 out of 3 times we will force them to use bows
    // however, the chance to use bows may actually still be greater because they may be randomly selected anyways
    if (GetLocalInt(oCreature, RAND_EQUIP_PREFER_BOW) == 1 && d3() != 1) bForceBows = TRUE;

    for (nIndex = 0; nIndex < RAND_EQUIP_NUM_WEAPONTYPES; nIndex++)
    {
        nBaseItem = _GetWeaponTypeByIndex(nIndex);
        if (_CanUseWeaponTypeWithProficiencies(cpProfs, nBaseItem) && _IsWeaponTypeRanged(nBaseItem))
        {
            int nWeaponSize = _GetWeaponSize(nBaseItem);
            // Size restriction, no giving longbows to halflings
            if (nCreatureSize - nWeaponSize >= -1)
            {
                if (bForceBows)
                {
                    if (nBaseItem != BASE_ITEM_LONGBOW && nBaseItem != BASE_ITEM_SHORTBOW)
                    {
                        continue;
                    }
                }
                // Rapid shot/reload: if you have exactly one of these two feats, only try to get that kind of weapon
                else if (bRapidShot ^ bRapidReload)
                {
                    if (bRapidShot && (nBaseItem == BASE_ITEM_LIGHTCROSSBOW || nBaseItem == BASE_ITEM_HEAVYCROSSBOW))
                    {
                        continue;
                    }
                    if (bRapidReload && !(nBaseItem == BASE_ITEM_LIGHTCROSSBOW || nBaseItem == BASE_ITEM_HEAVYCROSSBOW))
                    {
                        continue;
                    }
                }
                int nThisScore = _GetScoreForWeaponType(nBaseItem, oCreature);
                int nWeight = _GetRandomEquipWeaponTypeWeight(oCreature, nBaseItem) * nThisScore * 30;
                Array_PushBack_Int(RAND_EQUIP_TEMP_ARRAY, nBaseItem, GetModule());
                Array_PushBack_Int(RAND_EQUIP_TEMP_WEIGHT_ARRAY, nWeight, GetModule());
                nWeightSum += nWeight;
            }
        }
    }
    return _SelectFromRandEquipTempArray(nWeightSum, oCreature);
}

//struct RandomWeaponResults
//{
//    int nMainHand;
//    int nOffHand;
//    int nBackupMeleeWeapon;
//};

int _IsArmorCheckPenaltyAConcern(object oCreature)
{
    // hide, move silently, parry, pick pocket, set trap, and tumble
    if (!GetLocalInt(oCreature, "no_stealth") && GetSkillRank(SKILL_HIDE, oCreature, TRUE) > 0)
    {
        return 1;
    }
    return 0;
}

// Returns a struct containing BASE_ITEM_* constants for suitable main and offhand items of oCreature.
struct RandomWeaponResults RollRandomWeaponTypesForCreature(object oCreature)
{
    struct RandomWeaponResults rwrOut;
    rwrOut.nMainHand = BASE_ITEM_INVALID;
    rwrOut.nOffHand = BASE_ITEM_INVALID;
    rwrOut.nBackupMeleeWeapon = BASE_ITEM_INVALID;
    // Do we even WANT weapons?

    // Give ranged and a random one handed backup melee weapon if something signalled to
    int bGiveRanged = GetLocalInt(oCreature, RAND_EQUIP_GIVE_RANGED);

    // Melee: figure out what we want (one handed + shield, two weapons, two handers)
    int bShieldProficiency = GetHasFeat(FEAT_SHIELD_PROFICIENCY, oCreature);
    int bDualWield = 0;
    int bTwoHanded = 0;
    int bShield = 0;
    // Dual wielding decision making:
    // 374 = ranger dual-wield feat (seemingly missing constant)
    // At low HD, you might not necessarily have ambidexterity if not ranger
    // and going from 1APR to 2APR at -2/-6 MIGHT be worth it... sometimes
    if (GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_FIGHTING, oCreature) ||
        GetHasFeat(374, oCreature) ||
        (GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature) &&
        (GetHitDice(oCreature) <= 4 || GetHasFeat(FEAT_AMBIDEXTERITY, oCreature))))
    {
        bDualWield = 1;
    }
    
    int bFinesse = 0;
    if (GetHasFeat(FEAT_WEAPON_FINESSE, oCreature) &&
        GetAbilityModifier(ABILITY_DEXTERITY, oCreature) > GetAbilityModifier(ABILITY_STRENGTH, oCreature))
    {
        bFinesse = 1;
    }

    if (GetLevelByClass(CLASS_TYPE_MONK, oCreature) > 0)
    {
        if (bDualWield && !bGiveRanged)
        {
            rwrOut.nMainHand = BASE_ITEM_KAMA;
            rwrOut.nOffHand = BASE_ITEM_KAMA;
            return rwrOut;
        }
        int bNoFists = 1;
        if (GetHitDice(oCreature) * 3 >= GetLevelByClass(CLASS_TYPE_MONK, oCreature) * 2)
        {
            bNoFists = 0;
        }
        if (!bGiveRanged && !GetHasFeat(FEAT_CIRCLE_KICK, oCreature))
        {
            if (bGiveRanged || Random(100) < 66 || bNoFists)
            {
                if (bGiveRanged)
                {
                    rwrOut.nMainHand = BASE_ITEM_SHURIKEN;
                    rwrOut.nBackupMeleeWeapon = d2() == 1 ? BASE_ITEM_QUARTERSTAFF : BASE_ITEM_KAMA;
                    if (bFinesse) { rwrOut.nBackupMeleeWeapon = BASE_ITEM_KAMA; }
                }
                else
                {
                    rwrOut.nMainHand = d2() == 1 ? BASE_ITEM_QUARTERSTAFF : BASE_ITEM_KAMA;
                    if (bFinesse) { rwrOut.nMainHand = BASE_ITEM_KAMA; }
                }

                return rwrOut;
            }
        }
        // Otherwise, punchy punchy time
        return rwrOut;
    }

    // If the creature has creatureweapons, don't give it normal stuff
    // (unless it has something in its main hand already)
    int nSlot;
    if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature)))
    {
        for (nSlot = INVENTORY_SLOT_CWEAPON_L; nSlot <= INVENTORY_SLOT_CWEAPON_B; nSlot++)
        {
            if (GetIsObjectValid(GetItemInSlot(nSlot, oCreature)))
            {
                return rwrOut;
            }
        }
    }

    if (bGiveRanged)
    {
        rwrOut.nMainHand = SelectRangedWeaponType(oCreature);
        rwrOut.nBackupMeleeWeapon = SelectMainHandMeleeWeaponType(oCreature);
        return rwrOut;
    }


    if (!(bDualWield) && !(bShieldProficiency))
    {
        // It seems silly to go with offhand empty.
        // I'm not sure there's anything in vanilla that gives you benefit for doing so
        bTwoHanded = 1;
    }
    else if (!bDualWield)
    {
        if ((bShieldProficiency && Random(100) < 50 && !GetLocalInt(oCreature, RAND_EQUIP_NO_SHIELD)) || GetLocalInt(oCreature, RAND_EQUIP_FORCE_SHIELD))
        {
            bShield = 1;
        }
        else
        {
            bTwoHanded = 1;
        }
    }

    if (bTwoHanded)
    {
        rwrOut.nMainHand = SelectTwoHandedMeleeWeaponType(oCreature);
        if (rwrOut.nMainHand == BASE_ITEM_INVALID)
        {
            bTwoHanded = 0;
            bShield = 1;
        }
        else
        {
            return rwrOut;
        }
    }

    if (bDualWield)
    {
        // Attempt a double sided weapon, most of the time this will fail
        if (Random(100) < 50)
        {
            rwrOut.nMainHand = SelectTwoHandedMeleeWeaponType(oCreature, 1);
            if (rwrOut.nMainHand != BASE_ITEM_INVALID)
            {
                return rwrOut;
            }
        }
        rwrOut.nMainHand = SelectMainHandMeleeWeaponType(oCreature);
        rwrOut.nOffHand = SelectLightMeleeWeaponType(oCreature);
        return rwrOut;
    }

    if (bShield)
    {
        rwrOut.nMainHand = SelectMainHandMeleeWeaponType(oCreature);
        if (!_IsArmorCheckPenaltyAConcern(oCreature) && bShieldProficiency)
        {
            if (GetAbilityScore(oCreature, ABILITY_STRENGTH) > 14 && GetCreatureSize(oCreature) > CREATURE_SIZE_SMALL)
            {
                rwrOut.nOffHand = BASE_ITEM_TOWERSHIELD;
                if (Random(100) < 50)
                {
                    rwrOut.nOffHand = BASE_ITEM_LARGESHIELD;
                }
            }
            else
            {
                rwrOut.nOffHand = BASE_ITEM_LARGESHIELD;
                if (Random(100) < 50)
                {
                    rwrOut.nOffHand = BASE_ITEM_SMALLSHIELD;
                }
            }
        }
    }
    return rwrOut;
}
string GetMundaneWeaponOfType(int nBaseItem)
{
    string sOut = "";

    switch (nBaseItem)
    {
       case BASE_ITEM_SMALLSHIELD: { sOut = "nw_ashsw001"; break; }
       case BASE_ITEM_HELMET: { sOut = "nw_arhe006"; break; }
       case BASE_ITEM_LARGESHIELD: { sOut = "nw_ashlw001"; break; }
       case BASE_ITEM_TOWERSHIELD: { sOut = "nw_ashto001"; break; }
       case BASE_ITEM_BASTARDSWORD: { sOut = "nw_wswbs001"; break; }
       case BASE_ITEM_BATTLEAXE: { sOut = "nw_waxbt001"; break; }
       case BASE_ITEM_CLUB: { sOut = "nw_wblcl001"; break; }
       case BASE_ITEM_DAGGER: { sOut = "nw_wswdg001"; break; }
       case BASE_ITEM_LONGSWORD: { sOut = "nw_wswls001"; break; }
       case BASE_ITEM_SHORTSWORD: { sOut = "nw_wswss001"; break; }
       case BASE_ITEM_WARHAMMER: { sOut = "nw_wblhw001"; break; }
       case BASE_ITEM_LIGHTMACE: { sOut = "nw_wblml001"; break; }
       case BASE_ITEM_HANDAXE: { sOut = "nw_waxhn001"; break; }
       case BASE_ITEM_QUARTERSTAFF: { sOut = "nw_wdbqs001"; break; }
       case BASE_ITEM_LONGBOW: { sOut = "nw_wbwln001"; break; }
       case BASE_ITEM_SHORTBOW: { sOut = "nw_wbwsh001"; break; }
       case BASE_ITEM_LIGHTFLAIL: { sOut = "nw_wblfl001"; break; }
       case BASE_ITEM_LIGHTHAMMER: { sOut = "nw_wblhl001"; break; }
       case BASE_ITEM_HALBERD: { sOut = "nw_wplhb001"; break; }
       case BASE_ITEM_SHORTSPEAR: { sOut = "nw_wplss001"; break; }
       case BASE_ITEM_GREATSWORD: { sOut = "nw_wswgs001"; break; }
       case BASE_ITEM_GREATAXE: { sOut = "nw_waxgr001"; break; }
       case BASE_ITEM_HEAVYFLAIL: { sOut = "nw_wblfh001"; break; }
       case BASE_ITEM_DWARVENWARAXE: { sOut = "x2_wdwraxe00"; break; }
       case BASE_ITEM_MORNINGSTAR: { sOut = "nw_wblms001"; break; }
       case BASE_ITEM_HEAVYCROSSBOW: { sOut = "nw_wbwxh001"; break; }
       case BASE_ITEM_LIGHTCROSSBOW: { sOut = "nw_wbwxl001"; break; }
       case BASE_ITEM_DIREMACE: { sOut = "nw_wdbma001"; break; }
       case BASE_ITEM_DOUBLEAXE: { sOut = "nw_wdbax001"; break; }
       case BASE_ITEM_RAPIER: { sOut = "nw_wswrp001"; break; }
       case BASE_ITEM_SCIMITAR: { sOut = "nw_wswsc001"; break; }
       case BASE_ITEM_KATANA: { sOut = "nw_wswka001"; break; }
       case BASE_ITEM_KAMA: { sOut = "nw_wspka001"; break; }
       case BASE_ITEM_SCYTHE: { sOut = "nw_wplsc001"; break; }
       case BASE_ITEM_TWOBLADEDSWORD: { sOut = "nw_wdbsw001"; break; }
       case BASE_ITEM_WHIP: { sOut = "x2_it_wpwhip"; break; }
       case BASE_ITEM_TRIDENT: { sOut = "nw_wpltr001"; break; }
       case BASE_ITEM_KUKRI: { sOut = "nw_wspku001"; break; }
       case BASE_ITEM_SICKLE: { sOut = "nw_wspsc001"; break; }
       case BASE_ITEM_SLING: { sOut = "nw_wbwsl001"; break; }
    }
    return sOut;
}

string GetMundaneArmorOfAC(int nAC)
{
    string sOut = "";
    int nRoll;
    switch (nAC)
    {
        case 0:
        {
            nRoll = Random(3);
            if (nRoll == 0) { sOut = "nw_cloth022"; }
            else if (nRoll == 1) { sOut = "nw_cloth006"; }
            else if (nRoll == 2) { sOut = "nw_cloth001"; }
            break;
        }
        case 1: { sOut = "nw_aarcl009"; break; }
        case 2: { sOut = "nw_aarcl001"; break; }
        case 3:
        {
            nRoll = Random(2);
            if (nRoll == 0) { sOut = "nw_aarcl002"; }
            else { sOut = "nw_aarcl008"; }
            break;
        }
        case 4:
        {
            nRoll = Random(2);
            if (nRoll == 0) { sOut = "nw_aarcl012"; }
            else { sOut = "nw_aarcl003"; }
            break;
        }
        case 5:
        {
            nRoll = Random(2);
            if (nRoll == 0) { sOut = "nw_aarcl010"; }
            else { sOut = "nw_aarcl004"; }
            break;
        }
        case 6:
        {
            nRoll = Random(2);
            if (nRoll == 0) { sOut = "nw_aarcl011"; }
            else { sOut = "nw_aarcl005"; }
            break;
        }
        case 7: { sOut = "nw_aarcl006"; break; }
        case 8: { sOut = "nw_aarcl007"; break; }
    }
    //WriteTimestampedLogEntry("Mundane base AC " + IntToString(nAC) + " = " + sOut);
    return sOut;
}

