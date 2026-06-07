void main()
{
object oPC = GetPCSpeaker();
int i = GetLocalInt(oPC,"Prixi");
object oPla;

while(i>0)
 {
oPla = GetLocalObject(oPC,"Road"+IntToString(i));
DeleteLocalObject(oPC,"Road"+IntToString(i));
DestroyObject(oPla);
i--;
 }
DeleteLocalInt(oPC,"Prixi");
}
