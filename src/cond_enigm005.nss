int StartingConditional()
{
object oPC = GetPCSpeaker();
object oEnigm = GetLocalObject(OBJECT_SELF,"oEnigm");
string sResult = GetLocalString(oEnigm,"Result");
int i22 = GetLocalInt(oEnigm,"Buttons");

int iLight1 = GetLocalInt(oEnigm,"Light1");
int iLight2 = GetLocalInt(oEnigm,"Light2");
int iLight3 = GetLocalInt(oEnigm,"Light3");
int iLight4 = GetLocalInt(oEnigm,"Light4");
int iLight5 = GetLocalInt(oEnigm,"Light5");
int iLight6 = GetLocalInt(oEnigm,"Light6");
int iLight7 = GetLocalInt(oEnigm,"Light7");
int iLights = iLight1+iLight2+iLight3+iLight4+iLight5+iLight6+iLight7;

if((GetStringLeft(sResult,7)=="Buttons")&&(iLights<i22)){return TRUE;}else{return FALSE;}
}
