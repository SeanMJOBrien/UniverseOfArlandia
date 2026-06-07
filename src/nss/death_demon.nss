void main()
{
ExecuteScript("nw_c2_default7", OBJECT_SELF);
location oLoc = GetLocation(OBJECT_SELF);
effect e1 = EffectVisualEffect(VFX_IMP_DESTRUCTION,FALSE);
effect e2 = EffectVisualEffect(VFX_FNF_FIREBALL,FALSE);
effect e3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE,FALSE);
effect e4 = EffectVisualEffect(VFX_FNF_IMPLOSION,FALSE);
effect e5 = EffectVisualEffect(VFX_FNF_SUMMON_GATE,FALSE);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e1,oLoc);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e2,oLoc);
DelayCommand(0.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e2,oLoc));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e5,oLoc);

DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e3,oLoc));
DelayCommand(1.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e3,oLoc));
DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e3,oLoc));
DelayCommand(4.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e3,oLoc));
DelayCommand(6.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e3,oLoc));
DelayCommand(7.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e3,oLoc));
DelayCommand(9.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e3,oLoc));

DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,e4,oLoc));
SetIsDestroyable(TRUE,FALSE,FALSE);
DelayCommand(3.0,DestroyObject(OBJECT_SELF));
}
