void main()
{
object oDamager = GetLastDamager();
int iDamage = GetTotalDamageDealt();

if(oDamager==OBJECT_SELF){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(iDamage),OBJECT_SELF);}
}
