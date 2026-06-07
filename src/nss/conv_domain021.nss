void main()
{
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");

SetCustomToken(10521,IntToString(GetLocalInt(OBJECT_SELF,"Price"+IntToString(iChoice1))));
}
