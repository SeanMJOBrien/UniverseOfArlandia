#include "_module"
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
while(i<iUOAreferences){i++;DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));}
 }
}
