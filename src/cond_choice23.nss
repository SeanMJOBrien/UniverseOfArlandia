int i = 23;

int StartingConditional()
{
int iChoice = GetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));

if(iChoice==0){return TRUE;}else{return FALSE;}
}
