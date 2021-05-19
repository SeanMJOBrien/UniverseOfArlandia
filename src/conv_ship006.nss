void main()
{
object oPC = GetPCSpeaker();
object oAsteroid = GetNearestObjectByTag("pla_asteroid",oPC);

AssignCommand(oPC,ActionCastSpellAtObject(SPELL_RAY_OF_FROST,oAsteroid,METAMAGIC_ANY,TRUE,1,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oAsteroid)),oAsteroid));
}
