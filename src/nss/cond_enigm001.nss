int StartingConditional()
{
object oEnigm = GetLocalObject(OBJECT_SELF,"oEnigm");
string sEnigms = GetLocalString(oEnigm,"Var");
int iEnigm1 = StringToInt(GetStringLeft(sEnigms,FindSubString(sEnigms,"_")));
string sSuccess = GetStringRight(sEnigms,8);

if((sSuccess!="&Success")&&((iEnigm1==1)||(iEnigm1==2)||(iEnigm1==5))){return TRUE;}else{return FALSE;}
}
