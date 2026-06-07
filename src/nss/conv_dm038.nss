void main()
{
object oPC = GetPCSpeaker();
int i = GetLocalInt(oPC,"Prixi");
object oPla;

while(i>0)
 {
oPla = GetLocalObject(oPC,"Road"+IntToString(i));
DeleteLocalObject(oPC,"Road"+IntToString(i));
SetLocalInt(oPla,"Persistent",1);
i--;
 }
DeleteLocalInt(oPC,"Prixi");
}
