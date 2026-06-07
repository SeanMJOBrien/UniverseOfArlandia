#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLifePoints = GetLocalInt(oGoldbag,"LifePoints");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iRace = GetLocalInt(oGoldbag,"Race");
int iXPs = GetXP(oPC);

     if(iChoice1==1){SetLocalInt(oGoldbag,"LifePoints",iLifePoints-1);}
else if(iChoice1==2){if(iXPs<(3000+iXPlost)){SetXP(oPC,3000);}else{SetXP(oPC,iXPs-iXPlost);}}

     if(iChoice2==2){SetLocalString(oGoldbag,"Area",GetLocalString(oGoldbag,"LastCiv"));}
else if(iChoice2==3){SetLocalString(oGoldbag,"Area","0_0");}

if(iChoice2!=1)
 {
SetLocalFloat(oGoldbag,"fX",120.0);
SetLocalFloat(oGoldbag,"fY",100.0);
SetLocalFloat(oGoldbag,"fFacing",DIRECTION_NORTH);
 }
SetLocalInt(oGoldbag,"HitPoints",GetMaxHitPoints(oPC));
AssignCommand(oPC,ActionJumpToLocation(GetStartingLocation()));
DeleteLocalInt(oGoldbag,"Dead");
}
