void main()
{
if((GetLocalInt(OBJECT_SELF,"Sleep")==1)&&(GetCurrentAction(OBJECT_SELF)==ACTION_INVALID))
 {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_SLEEP),OBJECT_SELF);
DelayCommand(7.0,ExecuteScript("sleep",OBJECT_SELF));
 }
}
