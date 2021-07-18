//::///////////////////////////////////////////////
//:: Default: On Rested
//:: NW_C2_DEFAULTA
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    after having just rested.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
void main()
{
object oMaster = GetMaster(OBJECT_SELF);
// UOA henchs
if(GetLocalInt(OBJECT_SELF,"Hench")>0){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_SLEEP),OBJECT_SELF,9.0);DelayCommand(9.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_SLEEP),OBJECT_SELF,9.0));DestroyObject(GetLocalObject(OBJECT_SELF,"Food"));DeleteLocalObject(OBJECT_SELF,"Food");}else{
// UOA henchs

    // enter desired behaviour here

    return;

}}
