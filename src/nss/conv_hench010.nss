void main()
{
object oPC = GetPCSpeaker();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
string sObject;int i;

while(i<10)
 {
i++;
sObject = GetLocalString(OBJECT_SELF,"AreaObject"+IntToString(iStep*10+i));
if(sObject!=""){SetCustomToken(10460+i,sObject);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));}else{SetCustomToken(10460+i,"");SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
 }
}
