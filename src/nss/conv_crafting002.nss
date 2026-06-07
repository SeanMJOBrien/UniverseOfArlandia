void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
string sWand;int i;int j;string sName;

while(i<20){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);SetCustomToken(10200+i,"");}i=0;

while(i<20)
 {
i++;
sWand = GetLocalString(oModule,"Scroll_Wand_"+IntToString(i+(20*(iStep-1))));
sName = GetStringRight(GetStringLeft(sWand,FindSubString(sWand,"&2&")),GetStringLength(GetStringLeft(sWand,FindSubString(sWand,"&2&")))-FindSubString(sWand,"&1&")-3);

if(sName!="")
  {
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetCustomToken(10200+i,sName);
  }
 }
}
