int StartingConditional()
{
if((GetLocalInt(OBJECT_SELF,"Player")==1)&&(GetLocalInt(OBJECT_SELF,"Success")==0)&&(GetLocalInt(OBJECT_SELF,"Round")==2)){return TRUE;}else{return FALSE;}
}
