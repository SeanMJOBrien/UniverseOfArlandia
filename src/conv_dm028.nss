void main()
{
object oPC = GetPCSpeaker();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
string sName;int i;

while(i<10)
 {
i++;
sName = GetLocalString(oPC,"NameTarget"+IntToString(i+(10*iStep)));

if(sName!="")
  {
SetCustomToken(20000+i,sName);
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
  }
else
  {
SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);
  }
 }
}
