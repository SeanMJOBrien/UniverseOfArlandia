void main()
{
object oThisCreature=GetFirstObjectInShape(SHAPE_SPHERE,4.0,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_CREATURE);

while (oThisCreature!=OBJECT_INVALID)
 {
effect efDamage=EffectDamage((Random(30)+31),DAMAGE_TYPE_FIRE);
effect epDamage=EffectDamage((Random(30)+31),DAMAGE_TYPE_BLUDGEONING);
ApplyEffectToObject(DURATION_TYPE_INSTANT,efDamage,oThisCreature);
ApplyEffectToObject(DURATION_TYPE_INSTANT,epDamage,oThisCreature);
oThisCreature=GetNextObjectInShape(SHAPE_SPHERE,6.0,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_CREATURE);
 }

object oThisPlacable=GetFirstObjectInShape(SHAPE_SPHERE,6.0,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_PLACEABLE);
while (oThisPlacable!=OBJECT_INVALID)
 {
if(GetStringLeft(GetTag(oThisPlacable),5)=="chest"){SetPlotFlag(oThisPlacable,FALSE);}
effect eDamage=EffectDamage(500,DAMAGE_TYPE_FIRE);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oThisPlacable);
oThisPlacable=GetNextObjectInShape(SHAPE_SPHERE,6.0,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_PLACEABLE);
 }

object oThisDoor=GetFirstObjectInShape(SHAPE_SPHERE,6.0,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_DOOR);
while (oThisDoor!=OBJECT_INVALID)
 {
effect eDamage=EffectDamage(500,DAMAGE_TYPE_FIRE);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oThisDoor);
oThisDoor=GetNextObjectInShape(SHAPE_SPHERE,6.0,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_DOOR);
 }
effect eVFXExplostion=EffectVisualEffect(VFX_FNF_FIREBALL);
ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFXExplostion,OBJECT_SELF);

//Don't use fire dammage, or this script will be called again
effect eDamage=EffectDamage(500,DAMAGE_TYPE_BLUDGEONING);
ApplyEffectToObject(VFX_FNF_FIREBALL,eDamage,OBJECT_SELF);
}
