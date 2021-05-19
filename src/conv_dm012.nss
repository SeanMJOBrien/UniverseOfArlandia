void main()
{
object oPC = GetPCSpeaker();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
object oObject;int i;

while(i<10)
 {
i++;
oObject = GetLocalObject(OBJECT_SELF,"AreaObject"+IntToString(iStep*10+i));
if(GetIsObjectValid(oObject)){SetCustomToken(20300+i,GetName(oObject));DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));}else{SetCustomToken(20300+i,"");SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
 }
}
