// Single-function extract of GetBaseArmorAC() from tfn-adventurers' inc_general.nss.
// inc_rand_appear.nss needs this one helper; the rest of inc_general.nss (924 lines
// of unrelated death/gibs/player-statistics code, requiring NWNX_Object, NWNX_Effect,
// inc_sql, util_i_color, and a NUI player-stats screen) is not needed here.

int GetBaseArmorAC(object oArmor);
int GetBaseArmorAC(object oArmor)
{
  return
  StringToInt
  (
    Get2DAString
    (
      "parts_chest",
      "ACBONUS",
      GetItemAppearance(oArmor,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_TORSO)
    )
  );
}
