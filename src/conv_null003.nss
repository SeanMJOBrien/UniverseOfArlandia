void main()
{
object oPC = GetPCSpeaker();
string sPos = GetLocalString(OBJECT_SELF,"Word");
string sTitle = GetLocalString(OBJECT_SELF,"title");

if(sTitle==""){SetLocalString(OBJECT_SELF,"title",sPos);}else{SetLocalString(OBJECT_SELF,"message",sPos);}
}
