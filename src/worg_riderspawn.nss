//::///////////////////////////////////////////////
//:: Default:On Death
//:: NW_C2_DEFAULT7
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Shouts to allies that they have been killed
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        object oKiller = GetLastKiller();
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5, FALSE);
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
 ////////////////////////////////
// Goblin Worg Rider stuff
/////////////////////////////////



// Get position and facing of Worg and set spawn point for the Goblin
 vector vWorg = GetPosition(OBJECT_SELF);
    float fAngle = GetFacing(OBJECT_SELF);
    location lGoblin;
    vector vChange;
    object oArea = GetArea(OBJECT_SELF);
    vChange.x = cos(fAngle) * 1.0;
    lGoblin = Location(oArea, vWorg+vChange, fAngle);


// Spawn the goblin because the worg has died
if(GetLocalInt(OBJECT_SELF,"Dead")!=1)
 {
    effect eKnockdwn = ExtraordinaryEffect(EffectKnockdown());
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE,"mn_goblin003",lGoblin,FALSE);
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdwn, oSpawn, 2.0));
 }
ExecuteScript("creatures_death",OBJECT_SELF);
}
