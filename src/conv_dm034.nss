void main()
{
object oPC = GetPCSpeaker();
object oModule = GetModule();
int iMod = GetLocalInt(oModule,"Stop");

if(iMod==1){SendMessageToPC(oPC,"Spawned creatures will now walk");DeleteLocalInt(oModule,"Stop");}else{SendMessageToPC(oPC,"Spawned creatures will now stop");SetLocalInt(oModule,"Stop",1);}
}
