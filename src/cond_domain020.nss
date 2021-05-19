int StartingConditional()
{
string sTag = GetTag(OBJECT_SELF);

if((sTag=="structureflag")&&(GetLocalInt(OBJECT_SELF,"Structure")==11)){return TRUE;}else{return FALSE;}
}
