int StartingConditional()
{
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iNum = GetLocalInt(OBJECT_SELF,"Num"+IntToString(iChoice1));

if(iNum>0){return TRUE;}else{return FALSE;}
}
