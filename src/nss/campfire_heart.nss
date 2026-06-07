void main()
{
int iConfig = GetLocalInt(OBJECT_SELF,"Config");
int iWear = GetLocalInt(OBJECT_SELF,"Wear");
effect eEffect = GetFirstEffect(OBJECT_SELF);

if(iConfig!=1)
 {
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20),OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"Config",1);
 }
else if(GetTag(OBJECT_SELF)=="campfire")
 {
if(iWear<95)
  {
SetLocalInt(OBJECT_SELF,"Wear",iWear+1);
  }
else
  {
while(GetIsEffectValid(eEffect))
   {
RemoveEffect(OBJECT_SELF,eEffect);
eEffect = GetNextEffect(OBJECT_SELF);
   }
DestroyObject(OBJECT_SELF);
  }
 }
}
