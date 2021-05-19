void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");

SetLocalInt(oArea,"NewWeather",iChoice);
ExecuteScript("area_ambiances",oArea);
}
