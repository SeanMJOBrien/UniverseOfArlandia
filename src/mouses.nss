void main()
{
object oNew;int i;

while(i<10)
 {
i++;
oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_mouse001",GetLocation(OBJECT_SELF));
SetLocalInt(oNew,"DontSave",1);
 }
}
