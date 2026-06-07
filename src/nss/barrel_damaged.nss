void main()
{
if(GetDamageDealtByType(DAMAGE_TYPE_FIRE)>0){DelayCommand(0.1,ExecuteScript("barrel_detonate",OBJECT_SELF));}
}
