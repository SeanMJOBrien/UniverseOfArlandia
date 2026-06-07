void main()
{
object oPC = GetLastUsedBy();
object oChair = OBJECT_SELF;

if(GetIsObjectValid(oPC))
 {
AssignCommand(oPC,ActionSit(oChair));
if(GetTag(OBJECT_SELF)=="playerchair"){DelayCommand(1.0,SetLocalFloat(oPC,"SitX",GetPosition(oPC).x));DelayCommand(1.0,SetLocalFloat(oPC,"SitY",GetPosition(oPC).y));}
 }
}
