void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iAppOrig = GetLocalInt(oGoldbag,"AppOrig");
int iRace = GetLocalInt(oGoldbag,"Race");
int iStep = 10*(GetLocalInt(OBJECT_SELF,"Step")-1);if(iStep<0){iStep = 0;}
string s;int i;

if((iRace==14)||(iRace==15)){SetCreatureAppearanceType(oPC,iAppOrig-1);}

while(i<10)
 {
i++;
s = GetLocalString(oModule,"System"+IntToString(i+iStep));
if(s==""){SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
SetCustomToken(10100+i,s);}
 }
}
