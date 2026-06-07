/* -----------------------------------------------------------------------
* tk_dispel
*
* An extension to the magic system that makes item properties dispellable.
*
* Created by The Krit, 01/07.
* -----------------------------------------------------------------------
*/
#include "colors_inc"

/* Prototypes for functions called from outside this file.
* -----------------------------------------------------------------------
*/
// Records an item property in case of later dispelling.
// (Called in IPSafeAddItemProperty().)
void TK_RecordSpellItemProperty(object oItem, itemproperty ipNew, float fDuration);
// Removes all item properties created by the Magic Vestment spell
// cast on oTarget.
// This is an approximation since there is no link between the item
// properties and the spell.
void TK_BreachMagicVestmentIP(object oTarget);
// Wrapper for applying a dispel effect to an object.
// This wrapper also checks for item properties that might need to be stripped
// as a result of the dispel.
void TK_ApplyDispel(effect eDispel, object oTarget, int nCasterLevel);

/* Utility Functions that could be included in a separate file
* -----------------------------------------------------------------------
*/

// Returns a 10-character string containing nNum in decimal form.
// (Not so good for *really* large negative numbers.)
string IntToFixedString(int nNum)
{
return GetStringRight(" " + IntToString(nNum), 10);
}

/* Utility Functions
* -----------------------------------------------------------------------
*/

// Functions that return the names of variables to be used for record keeping.
string TK_DISPEL_NextIndex(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_INDEX"; }
string TK_DISPEL_IndexList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_INDICES"; }
string TK_DISPEL_ObjectList(int nSpell, int nIndex) { return "TK_DISPEL_" + IntToString(nSpell) + "_OBJECT_" + IntToHexString(nIndex); }
string TK_DISPEL_ObjectListByHexString(int nSpell, string sIndex) { return "TK_DISPEL_" + IntToString(nSpell) + "_OBJECT_" + sIndex; }
// This list is for visual properties. (i.e. type == ITEM_PROPERTY_VISUALEFFECT)
string TK_DISPEL_VSubTypeList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_V_SUBTYPES"; }
// These lists are for enhancement properties (i.e. type == ITEM_PROPERTY_ENHANCEMENT_BONUS)
string TK_DISPEL_ECostTableList(int nSpell){ return "TK_DISPEL_" + IntToString(nSpell) + "_E_COSTTABLES"; }
string TK_DISPEL_ECTValueList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_E_CTVALUES"; }
// These lists are for whatever other property a spell might give.
string TK_DISPEL_TypeList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_TYPES"; }
string TK_DISPEL_SubTypeList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_SUBTYPES"; }
string TK_DISPEL_CostTableList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_COSTTABLES"; }
string TK_DISPEL_CTValueList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_CTVALUES"; }
string TK_DISPEL_ParamList(int nSpell) { return "TK_DISPEL_" + IntToString(nSpell) + "_PARAMS"; }
string TK_DISPEL_ParamValueList(int nSpell){ return "TK_DISPEL_" + IntToString(nSpell) + "_PARAMVALUES"; }

/* Auxiliary Functions
* -----------------------------------------------------------------------
*/

// Removes the records for a spell (nSpell) that has just worn off oOwner.
// nIndex identifies the records.
void TK_UnrecordSpellItemProperty(object oOwner, int nSpell, int nIndex)
{
// Get the list of active indices.
string sList = GetLocalString(oOwner, TK_DISPEL_IndexList(nSpell));
int nListLength = GetStringLength(sList);
// Find nIndex.
int nPosition = FindSubString(sList, IntToHexString(nIndex));
// If nIndex is no longer active. (Possibly, it was dispelled.)
if ( nPosition < 0 )
// Abort.
return;
// Delete "header" records associated with nIndex.
SetLocalString(oOwner, TK_DISPEL_IndexList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
DeleteLocalObject(oOwner, TK_DISPEL_ObjectList(nSpell, nIndex));
// Check for visual property records.
sList = GetLocalString(oOwner, TK_DISPEL_VSubTypeList(nSpell));
if ( sList != "" )
// Delete visual subtype.
SetLocalString(oOwner, TK_DISPEL_VSubTypeList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
// Check for enhancement property records.
sList = GetLocalString(oOwner, TK_DISPEL_ECostTableList(nSpell));
if ( sList != "" )
{
// Delete enhancement cost table.
SetLocalString(oOwner, TK_DISPEL_ECostTableList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
// Delete enhancement cost table value.
sList = GetLocalString(oOwner, TK_DISPEL_ECTValueList(nSpell));
SetLocalString(oOwner, TK_DISPEL_ECTValueList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
}
// Check for other property records.
sList = GetLocalString(oOwner, TK_DISPEL_TypeList(nSpell));
if ( sList != "" )
{
// Delete type.
SetLocalString(oOwner, TK_DISPEL_TypeList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
// Delete subtype.
sList = GetLocalString(oOwner, TK_DISPEL_SubTypeList(nSpell));
SetLocalString(oOwner, TK_DISPEL_SubTypeList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
// Delete cost table.
sList = GetLocalString(oOwner, TK_DISPEL_CostTableList(nSpell));
SetLocalString(oOwner, TK_DISPEL_CostTableList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
// Delete cost table value.
sList = GetLocalString(oOwner, TK_DISPEL_CTValueList(nSpell));
SetLocalString(oOwner, TK_DISPEL_CTValueList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
// Delete param1.
sList = GetLocalString(oOwner, TK_DISPEL_ParamList(nSpell));
SetLocalString(oOwner, TK_DISPEL_ParamList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
// Delete param1 value.
sList = GetLocalString(oOwner, TK_DISPEL_ParamValueList(nSpell));
SetLocalString(oOwner, TK_DISPEL_ParamValueList(nSpell),
GetStringLeft(sList, nPosition) + GetStringRight(sList, nListLength - nPosition - 10));
}
}

// Looks for a temporary item property on oItem that matches the given
// subtype and is a visual effect. If one is found, it is removed.
void RemoveVisualItemProperty(object oItem, int nSubType)
{
int bDone = FALSE;
// Loop through this item's properties.
itemproperty ipCheck = GetFirstItemProperty(oItem);
while ( GetIsItemPropertyValid(ipCheck) && !bDone )
{
// See if ipCheck is a match.
if ( GetItemPropertyDurationType(ipCheck) == DURATION_TYPE_TEMPORARY &&
GetItemPropertyType(ipCheck) == ITEM_PROPERTY_VISUALEFFECT &&
GetItemPropertySubType(ipCheck) == nSubType )
{
// Remove the property.
RemoveItemProperty(oItem, ipCheck);
// We're done.
bDone = TRUE;
}
// Get the next property.
ipCheck = GetNextItemProperty(oItem);
}
}

// Looks for a temporary item property on oItem that matches the given
// criteria and is an enhancement bonus. If one is found, it is removed.
void RemoveEnhancementItemProperty(object oItem, int nCostTable, int nCTValue)
{
int bDone = FALSE;
// Loop through this item's properties.
itemproperty ipCheck = GetFirstItemProperty(oItem);
while ( GetIsItemPropertyValid(ipCheck) && !bDone )
{
// See if ipCheck is a match.
if ( GetItemPropertyDurationType(ipCheck) == DURATION_TYPE_TEMPORARY &&
GetItemPropertyType(ipCheck) == ITEM_PROPERTY_ENHANCEMENT_BONUS &&
GetItemPropertyCostTable(ipCheck) == nCostTable &&
GetItemPropertyCostTableValue(ipCheck) == nCTValue )
{
// Remove the property.
RemoveItemProperty(oItem, ipCheck);
// We're done.
bDone = TRUE;
}
// Get the next property.
ipCheck = GetNextItemProperty(oItem);
}
}

// Looks for a temporary item property on oItem that matches the given
// criteria. If one is found, it is removed.
void RemoveOtherItemProperty(object oItem, int nType, int nSubType, int nCostTable, int nCTValue, int nParam, int nParamValue)
{
int bDone = FALSE;
// Loop through this item's properties.
itemproperty ipCheck = GetFirstItemProperty(oItem);
while ( GetIsItemPropertyValid(ipCheck) && !bDone )
{
// See if ipCheck is a match.
if ( GetItemPropertyDurationType(ipCheck) == DURATION_TYPE_TEMPORARY &&
GetItemPropertyType(ipCheck) == nType &&
GetItemPropertySubType(ipCheck) == nSubType &&
GetItemPropertyCostTable(ipCheck) == nCostTable &&
GetItemPropertyCostTableValue(ipCheck) == nCTValue &&
GetItemPropertyParam1(ipCheck) == nParam &&
GetItemPropertyParam1Value(ipCheck) == nParamValue )
{
// Remove the property.
RemoveItemProperty(oItem, ipCheck);
// We're done.
bDone = TRUE;
}
// Get the next property.
ipCheck = GetNextItemProperty(oItem);
}
}

// Removes the item properties created by the most recent nCount castings of
// nSpell on oTarget.
// If nCount is negative, all instances will be removed.
// This is an approximation since there is no direct link between item
// properties and the spell.
void TK_StripItemProperties(object oTarget, int nSpell, int nCount = -1)
{
// "header" records.
string sIndexList = GetLocalString(oTarget, TK_DISPEL_IndexList(nSpell));
string sIndex;
object oItem;
int nListLength = GetStringLength(sIndexList);
// Visual property records.
string sVSubTypeList = GetLocalString(oTarget, TK_DISPEL_VSubTypeList(nSpell));
// Enhancement property records.
string sECostTableList = GetLocalString(oTarget, TK_DISPEL_ECostTableList(nSpell));
string sECTValueList = GetLocalString(oTarget, TK_DISPEL_ECTValueList(nSpell));
// Other property records.
string sTypeList = GetLocalString(oTarget, TK_DISPEL_TypeList(nSpell));
string sSubTypeList = GetLocalString(oTarget, TK_DISPEL_SubTypeList(nSpell));
string sCostTableList = GetLocalString(oTarget, TK_DISPEL_CostTableList(nSpell));
string sCTValueList = GetLocalString(oTarget, TK_DISPEL_CTValueList(nSpell));
string sParamList = GetLocalString(oTarget, TK_DISPEL_ParamList(nSpell));
string sParamValueList = GetLocalString(oTarget, TK_DISPEL_ParamValueList(nSpell));
// Item property characteristics.
int nType;
int nSubType;
int nCostTable;
int nCTValue;
int nParam;
int nParamValue;

// Loop through the castings to be removed.
while ( nCount-- != 0 && sIndexList != "" )
{
// Lists will be decreased by 10 characters
nListLength -= 10;
// Update the index and index list.
sIndex = GetStringRight(sIndexList, 10);
sIndexList = GetStringLeft(sIndexList, nListLength);
// Get the item with the item properties, and delete the record.
oItem = GetLocalObject(oTarget, TK_DISPEL_ObjectListByHexString(nSpell, sIndex));
DeleteLocalObject(oTarget, TK_DISPEL_ObjectListByHexString(nSpell, sIndex));
// Check for visual property records.
if ( sVSubTypeList != "" )
{
// Update the visual subtype.
nSubType = StringToInt(GetStringRight(sVSubTypeList, 10));
sVSubTypeList = GetStringLeft(sVSubTypeList, nListLength);
// Remove an appropriate item property.
RemoveVisualItemProperty(oItem, nSubType);
}
// Check for enhancement property records.
if ( sECostTableList != "" )
{
// Update the enhancement cost table.
nCostTable = StringToInt(GetStringRight(sECostTableList, 10));
sECostTableList = GetStringLeft(sECostTableList, nListLength);
// Update the enhancement cost table value.
nCTValue = StringToInt(GetStringRight(sECTValueList, 10));
sECTValueList = GetStringLeft(sECTValueList, nListLength);
// Remove an appropriate enhancement item property.
RemoveEnhancementItemProperty(oItem, nCostTable, nCTValue);
}
// Check for other property records.
if ( sTypeList != "" )
{
// Update the type.
nType = StringToInt(GetStringRight(sTypeList, 10));
sTypeList = GetStringLeft(sTypeList, nListLength);
// Update the subtype.
nSubType = StringToInt(GetStringRight(sSubTypeList, 10));
sSubTypeList = GetStringLeft(sSubTypeList, nListLength);
// Update the cost table.
nCostTable = StringToInt(GetStringRight(sCostTableList, 10));
sCostTableList = GetStringLeft(sCostTableList, nListLength);
// Update the cost table value.
nCTValue = StringToInt(GetStringRight(sCTValueList, 10));
sCTValueList = GetStringLeft(sCTValueList, nListLength);
// Update param1.
nParam = StringToInt(GetStringRight(sParamList, 10));
sParamList = GetStringLeft(sParamList, nListLength);
// Update the cost table value.
nParamValue = StringToInt(GetStringRight(sParamValueList, 10));
sParamValueList = GetStringLeft(sParamValueList, nListLength);
// Remove an appropriate item property.
RemoveOtherItemProperty(oItem, nType, nSubType, nCostTable, nCTValue, nParam, nParamValue);
}
}
// Store the updated lists.
SetLocalString(oTarget, TK_DISPEL_IndexList(nSpell), sIndexList);
SetLocalString(oTarget, TK_DISPEL_VSubTypeList(nSpell), sVSubTypeList);
SetLocalString(oTarget, TK_DISPEL_ECostTableList(nSpell), sECostTableList);
SetLocalString(oTarget, TK_DISPEL_ECTValueList(nSpell), sECTValueList);
SetLocalString(oTarget, TK_DISPEL_TypeList(nSpell), sTypeList);
SetLocalString(oTarget, TK_DISPEL_SubTypeList(nSpell), sSubTypeList);
SetLocalString(oTarget, TK_DISPEL_CostTableList(nSpell), sCostTableList);
SetLocalString(oTarget, TK_DISPEL_CTValueList(nSpell), sCTValueList);
SetLocalString(oTarget, TK_DISPEL_ParamList(nSpell), sParamList);
SetLocalString(oTarget, TK_DISPEL_ParamValueList(nSpell), sParamValueList);
}

// Second half of TK_PostDispelItemProperties().
// oTarget is the creature just dispelled.
// Before the dispel, nCount effects associated with nSpell were found.
void TK_PostDispelItemProperties(object oTarget, int nSpell, int nCount)
{
// Loop through the effects on oTarget.
effect eSpell = GetFirstEffect(oTarget);
while ( GetIsEffectValid(eSpell) )
{
// If this effect is from the desired spell.
if ( GetEffectSpellId(eSpell) == nSpell )
// Uncount it.
nCount--;
// Next effect.
eSpell = GetNextEffect(oTarget);
}
// Were any effects of nSpell dispelled?
if ( nCount > 0 )
// Strip the associated item properties.
TK_StripItemProperties(oTarget, nSpell, nCount);
}

// oTarget is the creature in the midst of being dispelled.
// This will check how many effects attributed to nSpell were dispelled,
// then adjust item properties appropriately.
// (Somewhat approximate because there is no direct link to item properties.)
void TK_DispelItemProperties(object oTarget, int nSpell)
{
int nCount = 0;
// Loop through the effects on oTarget.
effect eSpell = GetFirstEffect(oTarget);
while ( GetIsEffectValid(eSpell) )
{
// If this effect is from the desired spell.
if ( GetEffectSpellId(eSpell) == nSpell )
// Count it.
nCount++;
// Next effect.
eSpell = GetNextEffect(oTarget);
}
// Were any effects of nSpell found?
if ( nCount > 0 )
// Re-check after the dispel has a chance to take effect.
DelayCommand(0.1, TK_PostDispelItemProperties(oTarget, nSpell, nCount));
}

// Attempts to dispel Continual Flame from all equipped items.
void TK_DispelContinualFlame(object oTarget, int nCasterLevel)
{
object oItem;
int nOpposedLevel;
// Loop through all inventory slots.
int nSlot = NUM_INVENTORY_SLOTS;
while ( nSlot-- > 0 )
{
// See if the item in this slot has had Continual Flame cast on it.
oItem = GetItemInSlot(nSlot, oTarget);
nOpposedLevel = GetLocalInt(oItem, TK_DISPEL_SubTypeList(SPELL_CONTINUAL_FLAME));
if ( nOpposedLevel > 0 )
// Make a dispel check.
if ( d20() + nCasterLevel > 10 + nOpposedLevel )
{ // Success! All permanent light properties will be dispelled.
// Loop through this item's properties.
itemproperty ipCheck = GetFirstItemProperty(oItem);
while ( GetIsItemPropertyValid(ipCheck) )
{
// See if ipCheck is a match.
if ( GetItemPropertyDurationType(ipCheck) == DURATION_TYPE_PERMANENT &&
GetItemPropertyType(ipCheck) == ITEM_PROPERTY_LIGHT )
// Remove the property.
RemoveItemProperty(oItem, ipCheck);
// Get the next property.
ipCheck = GetNextItemProperty(oItem);
}
// Unflag this as a Continual Flame target.
DeleteLocalInt(oItem, TK_DISPEL_SubTypeList(SPELL_CONTINUAL_FLAME));
// Provide feedback (to caster and target).
string sFeedback1 = ColorTokenPurple() + "Dispel Magic: " + ColorTokenEnd();
string sFeedback2 = ": " + ColorTokenPurple() + "Continual Flame" + ColorTokenEnd();
SendMessageToPC(oTarget, sFeedback1 + GetNamePCColor(oItem) + sFeedback2);
if ( oTarget != OBJECT_SELF )
SendMessageToPC(OBJECT_SELF, sFeedback1 + GetNameNPCColor(oTarget) + sFeedback2);
}
}//while (nSlot)
}

/* Functions called from outside this file.
* -----------------------------------------------------------------------
*/

// Records an item property in case of later dispelling.
// (Called in(IPSafeAddItemProperty).)
// Current assumption is that no spell adds more than one non-visual,
// non-enhancement item property.
void TK_RecordSpellItemProperty(object oItem, itemproperty ipNew, float fDuration)
{
// Make sure we are in a spell script.
int nSpell = GetSpellId();
if ( nSpell == -1 )
// Abort.
return;
// Check the duration.
if ( fDuration == 0.0f )
{ // Presumably, this is Continual Flame.
// Record the caster level in the "subtype" list.
SetLocalInt(oItem, TK_DISPEL_SubTypeList(nSpell), GetCasterLevel(OBJECT_SELF));
// Done.
return;
}
// Processing temporary item properties requires a possessor.
object oOwner = GetItemPossessor(oItem);
if ( !GetIsObjectValid(oOwner) )
// Abort.
return;

// Retrieve "header" info.
int nNextIndex = GetLocalInt(oOwner, TK_DISPEL_NextIndex(nSpell));
string sIndexList = GetLocalString(oOwner, TK_DISPEL_IndexList(nSpell));
// Some variables to be used inside the "switch" below.
string sTypeList;
string sSubTypeList;
string sCostTableList;
string sCTValueList;
string sParamList;
string sParamValueList;
// Choose processing based on type.
int nType = GetItemPropertyType(ipNew);
switch ( nType )
{
case ITEM_PROPERTY_VISUALEFFECT:
// Visual effect properties only have a subtype.
sSubTypeList = GetLocalString(oOwner, TK_DISPEL_VSubTypeList(nSpell));
// See if this is a new casting of the spell.
if ( GetStringLength(sSubTypeList) == GetStringLength(sIndexList) )
{
// Add "header" info for this spell.
SetLocalObject(oOwner, TK_DISPEL_ObjectList(nSpell, nNextIndex), oItem);
SetLocalString(oOwner, TK_DISPEL_IndexList(nSpell), sIndexList + IntToHexString(nNextIndex));
SetLocalInt(oOwner, TK_DISPEL_NextIndex(nSpell), nNextIndex + 1);
// Set a timer to delete this spell's entries.
DelayCommand(fDuration, TK_UnrecordSpellItemProperty(oOwner, nSpell, nNextIndex));
}
// Store the property info.
SetLocalString(oOwner, TK_DISPEL_VSubTypeList(nSpell), sSubTypeList + IntToFixedString(GetItemPropertySubType(ipNew)));
break;
case ITEM_PROPERTY_ENHANCEMENT_BONUS:
// Enhancement properties only have a cost table and value.
sCostTableList = GetLocalString(oOwner, TK_DISPEL_ECostTableList(nSpell));
sCTValueList = GetLocalString(oOwner, TK_DISPEL_ECTValueList(nSpell));
// See if this is a new casting of the spell.
if ( GetStringLength(sCostTableList) == GetStringLength(sIndexList) )
{
// Add "header" info for this spell.
SetLocalObject(oOwner, TK_DISPEL_ObjectList(nSpell, nNextIndex), oItem);
SetLocalString(oOwner, TK_DISPEL_IndexList(nSpell), sIndexList + IntToHexString(nNextIndex));
SetLocalInt(oOwner, TK_DISPEL_NextIndex(nSpell), nNextIndex + 1);
// Set a timer to delete this spell's entries.
DelayCommand(fDuration, TK_UnrecordSpellItemProperty(oOwner, nSpell, nNextIndex));
}
// Store the property info.
SetLocalString(oOwner, TK_DISPEL_ECostTableList(nSpell), sCostTableList + IntToFixedString(GetItemPropertyCostTable(ipNew)));
SetLocalString(oOwner, TK_DISPEL_ECTValueList(nSpell), sCTValueList + IntToFixedString(GetItemPropertyCostTableValue(ipNew)));
break;
default:
// "Other" properties will store all six aspects.
sTypeList = GetLocalString(oOwner, TK_DISPEL_TypeList(nSpell));
sSubTypeList = GetLocalString(oOwner, TK_DISPEL_SubTypeList(nSpell));
sCostTableList = GetLocalString(oOwner, TK_DISPEL_CostTableList(nSpell));
sCTValueList = GetLocalString(oOwner, TK_DISPEL_CTValueList(nSpell));
sParamList = GetLocalString(oOwner, TK_DISPEL_ParamList(nSpell));
sParamValueList = GetLocalString(oOwner, TK_DISPEL_ParamValueList(nSpell));
// See if this is a new casting of the spell.
if ( GetStringLength(sTypeList) == GetStringLength(sIndexList) )
{
// Add "header" info for this spell.
SetLocalObject(oOwner, TK_DISPEL_ObjectList(nSpell, nNextIndex), oItem);
SetLocalString(oOwner, TK_DISPEL_IndexList(nSpell), sIndexList + IntToHexString(nNextIndex));
SetLocalInt(oOwner, TK_DISPEL_NextIndex(nSpell), nNextIndex + 1);
// Set a timer to delete this spell's entries.
DelayCommand(fDuration, TK_UnrecordSpellItemProperty(oOwner, nSpell, nNextIndex));
}
// Store the property info.
SetLocalString(oOwner, TK_DISPEL_TypeList(nSpell), sTypeList + IntToFixedString(nType));
SetLocalString(oOwner, TK_DISPEL_SubTypeList(nSpell), sSubTypeList + IntToFixedString(GetItemPropertySubType(ipNew)));
SetLocalString(oOwner, TK_DISPEL_CostTableList(nSpell), sCostTableList + IntToFixedString(GetItemPropertyCostTable(ipNew)));
SetLocalString(oOwner, TK_DISPEL_CTValueList(nSpell), sCTValueList + IntToFixedString(GetItemPropertyCostTableValue(ipNew)));
SetLocalString(oOwner, TK_DISPEL_ParamList(nSpell), sParamList + IntToFixedString(GetItemPropertyParam1(ipNew)));
SetLocalString(oOwner, TK_DISPEL_ParamValueList(nSpell), sParamValueList + IntToFixedString(GetItemPropertyParam1Value(ipNew)));
}//switch ()
}

// Breaches the item properties of Magic Vestment.
void TK_BreachMagicVestmentIP(object oTarget)
{
TK_StripItemProperties(oTarget, SPELL_MAGIC_VESTMENT);
}

// Wrapper for applying a dispel effect to an object.
// This wrapper also checks for item properties that might need to be stripped
// as a result of the dispel.
// NOTE: For each "normal" bless spell removed, up to 3 blessed bolt properties
// may be removed. Given the limitations of the scripting language,
// them's the breaks of trying so hard to be blessed.
// Besides, there may still a way for players to abuse the system, which
// can more than offset this.
void TK_ApplyDispel(effect eDispel, object oTarget, int nCasterLevel)
{
// Run checks for dispelled spells with item properties.
// (Hardcoded list because it's so small relative to the number of spells.)
TK_DispelItemProperties(oTarget, SPELL_BLACKSTAFF);
TK_DispelItemProperties(oTarget, SPELL_BLADE_THIRST);
TK_DispelItemProperties(oTarget, SPELL_BLESS);
TK_DispelItemProperties(oTarget, SPELL_BLESS_WEAPON);
TK_DispelItemProperties(oTarget, SPELL_DARKFIRE);
TK_DispelItemProperties(oTarget, SPELL_FLAME_WEAPON);
TK_DispelItemProperties(oTarget, SPELL_GREATER_MAGIC_WEAPON);
TK_DispelItemProperties(oTarget, SPELL_HOLY_SWORD);
TK_DispelItemProperties(oTarget, SPELL_KEEN_EDGE);
TK_DispelItemProperties(oTarget, SPELL_MAGIC_VESTMENT);
TK_DispelItemProperties(oTarget, SPELL_MAGIC_WEAPON);
// Do the dispel.
ApplyEffectToObject(DURATION_TYPE_INSTANT, eDispel, oTarget);
// Also attempt dispel on Continual Flame on equipped items.
TK_DispelContinualFlame(oTarget, nCasterLevel);
}
