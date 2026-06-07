void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");

object oObject = GetFirstPC();
int iAreaObjects = GetLocalInt(OBJECT_SELF,"AreaObjects");
int i;
//
while(i<iAreaObjects)
 {
i++;
DeleteLocalInt(OBJECT_SELF,"Choice"+IntToString(i));
DeleteLocalString(OBJECT_SELF,"AreaObject"+IntToString(i));
 }
DeleteLocalInt(OBJECT_SELF,"Step");
//
i = 0;
while(GetIsObjectValid(oObject))
 {
if((oObject!=oPC)&&(!GetIsDM(oObject))&&(!GetIsDMPossessed(oObject))&&(GetLocalString(GetArea(oObject),"Planet")==sPlanet)){i++;SetLocalString(OBJECT_SELF,"AreaObject"+IntToString(i),GetName(oObject));}
oObject = GetNextPC();
 }
SetLocalInt(OBJECT_SELF,"AreaObjects",i);
SetLocalInt(OBJECT_SELF,"Friend",1);
}
