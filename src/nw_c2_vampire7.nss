//::///////////////////////////////////////////////
//:: NW_C2_VAMPIRE7.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Vampire turns into a vampire shadow
    that looks for the nearest coffin
    with the same tag as the shadow.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void main()
{
// UOA henchs
if(GetLocalInt(OBJECT_SELF,"Hench")>0){ExecuteScript("nw_ch_ac7",OBJECT_SELF);}else
 {
// UOA henchs

    object oPC = GetLastKiller();
    object oGas = CreateObject(OBJECT_TYPE_CREATURE, GetTag(OBJECT_SELF) + "_SHAD",GetLocation(OBJECT_SELF));
    SetLocalString(oGas, "NW_L_MYCREATOR", GetTag(OBJECT_SELF));
    DestroyObject(OBJECT_SELF, 0.5);

if(GetIsPC(oPC)){SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);if(GetStandardFactionReputation(STANDARD_FACTION_MERCHANT,OBJECT_SELF)>=90){ClearPersonalReputation(oPC);}}
 }
ExecuteScript("creatures_death",OBJECT_SELF);
}
