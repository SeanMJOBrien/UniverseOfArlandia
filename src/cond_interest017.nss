int StartingConditional()
{
if((GetLocalInt(OBJECT_SELF,"Player")==2)&&(GetLocalInt(OBJECT_SELF,"Round")>0)){return TRUE;}else{return FALSE;}
}
