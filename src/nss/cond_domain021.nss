int StartingConditional()
{
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
string sBP = GetLocalString(OBJECT_SELF,"ItemBP"+IntToString(iChoice3));

if((GetStringLeft(sBP,1)!="a")&&(GetStringLeft(sBP,1)!="b")&&(GetStringLeft(sBP,1)!="c")&&(GetStringLeft(sBP,1)!="d")&&(GetStringLeft(sBP,1)!="e")&&(GetStringLeft(sBP,1)!="f")&&(GetStringLeft(sBP,1)!="g")&&(GetStringLeft(sBP,1)!="h")&&(GetStringLeft(sBP,1)!="i")&&(GetStringLeft(sBP,1)!="j")&&(GetStringLeft(sBP,1)!="k")&&(GetStringLeft(sBP,1)!="l")&&(GetStringLeft(sBP,1)!="m")&&(GetStringLeft(sBP,1)!="n")&&(GetStringLeft(sBP,1)!="o")&&(GetStringLeft(sBP,1)!="p")&&(GetStringLeft(sBP,1)!="q")&&(GetStringLeft(sBP,1)!="r")&&(GetStringLeft(sBP,1)!="s")&&(GetStringLeft(sBP,1)!="t")&&(GetStringLeft(sBP,1)!="u")&&(GetStringLeft(sBP,1)!="v")&&(GetStringLeft(sBP,1)!="w")&&(GetStringLeft(sBP,1)!="x")&&(GetStringLeft(sBP,1)!="y")&&(GetStringLeft(sBP,1)!="z")){return TRUE;}else{return FALSE;}
}
