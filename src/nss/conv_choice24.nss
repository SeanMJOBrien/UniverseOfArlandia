int i = 24;

void main()
{
int iStep = GetLocalInt(OBJECT_SELF,"Step")+1;

SetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep),i);
SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);
SetLocalInt(OBJECT_SELF,"Step",iStep);
}
