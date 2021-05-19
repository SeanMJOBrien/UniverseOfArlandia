int StartingConditional()
{
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
int iLevel = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));

if((iStructure==6)&&(iLevel>=5)){return TRUE;}else{return FALSE;}
}
