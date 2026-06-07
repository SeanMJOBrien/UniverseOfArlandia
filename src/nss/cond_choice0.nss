int i = 0;

int StartingConditional()
{
int iStep = GetLocalInt(OBJECT_SELF,"Step");

if(iStep>1){return TRUE;}else{return FALSE;}
}
