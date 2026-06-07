int StartingConditional()
{
object oEnigm = GetLocalObject(OBJECT_SELF,"oEnigm");
string sEnigms = GetLocalString(oEnigm,"Var");
int iEnigm1 = StringToInt(GetStringLeft(sEnigms,FindSubString(sEnigms,"_")));
int iEnigmRun = GetLocalInt(oEnigm,"EnigmRun");

if((iEnigmRun!=1)&&((iEnigm1==3)||(iEnigm1==4))){return TRUE;}else{return FALSE;}
}
