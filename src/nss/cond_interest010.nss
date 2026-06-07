int StartingConditional()
{
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iRound = GetLocalInt(OBJECT_SELF,"Round");
int i;

if(iChoice1==14){i = 10;}
else if((iChoice1==15)||(iChoice1==16)){i = 3;}
else if(iChoice1==19){i = 5;}

if(iRound>=i){return TRUE;}else{return FALSE;}
}
