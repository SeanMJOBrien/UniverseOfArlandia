void main()
{
object oPC = GetPCSpeaker();
int iDontChangeChoices = GetLocalInt(oPC,"DontChangeChoices");
int i;

if(iDontChangeChoices==1)
 {
DeleteLocalInt(oPC,"DontChangeChoices");
 }
else
 {
while(i<20)
  {
i++;
DeleteLocalInt(OBJECT_SELF,"Choice"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"Var"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"Rand"+IntToString(i));
SetCustomToken(10000+i,"");
SetCustomToken(10020+i,"");
SetCustomToken(10040+i,"");
SetCustomToken(10060+i,"");
SetCustomToken(10080+i,"");
SetCustomToken(10100+i,"");
SetCustomToken(10120+i,"");
SetCustomToken(10140+i,"");
SetCustomToken(10160+i,"");
SetCustomToken(10180+i,"");
SetCustomToken(10200+i,"");
  }
SetCustomToken(10000,"");
DeleteLocalInt(OBJECT_SELF,"Page");
DeleteLocalInt(OBJECT_SELF,"Step");
DeleteLocalInt(OBJECT_SELF,"Recall");
DeleteLocalInt(OBJECT_SELF,"Upgrade");
DeleteLocalString(OBJECT_SELF,"Result");
 }
}
