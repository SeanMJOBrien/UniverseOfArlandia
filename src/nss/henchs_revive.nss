// henchs_revive - a henchman revives their dead master once combat ends.
// ---
// Modeled on The-Frozen-North's on_mod_heartb.nss DoRevive(), adapted to
// UOA's own henchman model. TFN's henchmen stay linked to their master via
// GetMaster() even while dead, so DoRevive() can just walk that link. UOA's
// don't: the moment a PC dies, mod_death.nss dismisses every henchman they
// have via henchs.nss's HenchAction=3 ("Stay Here") - that breaks the
// GetAssociate()/GetMaster() link and drops the henchman to Merchant
// faction, but does NOT destroy or move it, so it's left standing exactly
// where the PC died. The only remaining link back to a specific dead PC is
// the GetLocalObject(oPC,"HenchObject"+i) slots that same dismissal wrote -
// so those, not GetMaster(), are what this reads.
#include "_module"

void main()
{
    object oPC = OBJECT_SELF;
    if (!GetIsDead(oPC)) return;
    // "Once combat ends" - mirrors TFN's own top-level gate in DoRevive().
    if (GetIsInCombat(oPC)) return;

    int i;
    while (i < iMaxHenchs)
    {
        i++;
        object oHench = GetLocalObject(oPC,"HenchObject"+IntToString(i));
        if (!GetIsObjectValid(oHench)) continue;
        if (GetCurrentHitPoints(oHench) <= 0) continue;
        if (GetArea(oHench) != GetArea(oPC)) continue;
        if (GetDistanceBetween(oHench,oPC) > 15.0) continue;
        if (GetIsInCombat(oHench)) continue;

        // Same resurrect+heal pairing mod_death.nss/mod_respawn.nss already
        // use elsewhere in UOA for a full recovery.
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(100000),oPC);
        AssignCommand(oHench,ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,2.0));
        FloatingTextStringOnCreature(GetName(oHench)+" revives you.",oPC,FALSE);
        WriteTimestampedLogEntry("[hench-revive] "+GetName(oPC)+" revived by "+GetName(oHench));
        return;
    }
}
