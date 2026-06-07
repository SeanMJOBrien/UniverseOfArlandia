void main()
{
string sPos = GetLocalString(OBJECT_SELF,"Word");
string sBP = GetLocalString(OBJECT_SELF,"BP");
object oNew = CreateItemOnObject(sBP,OBJECT_SELF);
int j;

if(FindSubString(sPos,GetName(oNew))!=-1){j = 1;}else if(GetLocalInt(OBJECT_SELF,"Wins")<3){j = -1;}else{j = 0;}
SetLocalInt(OBJECT_SELF,"Wins",GetLocalInt(OBJECT_SELF,"Wins")+1);

SetLocalInt(OBJECT_SELF,"Win",j);
}
