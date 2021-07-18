void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
int iResetOff = GetLocalInt(oModule,"ResetOff");

if(iResetOff==0)
 {
SetLocalInt(oModule,"ResetOff",1);FloatingTextStringOnCreature("Reboot unactivated",oPC,FALSE);
 }
else
 {
DeleteLocalInt(oModule,"ResetOff");FloatingTextStringOnCreature("Reboot activated",oPC,FALSE);
 }
}
