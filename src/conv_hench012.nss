void main()
{
string sMaster = GetLocalString(OBJECT_SELF,"Master");

SetLocalString(OBJECT_SELF,"Dest",sMaster);
ExecuteScript("falcon",OBJECT_SELF);
}
