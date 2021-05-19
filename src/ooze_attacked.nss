void main()
{
     if(GetTag(OBJECT_SELF)=="mn_ooze001"){object oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_ooze002",GetLocation(OBJECT_SELF));SetLocalInt(oNew,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));}
else if(GetTag(OBJECT_SELF)=="mn_ooze002"){object oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_ooze003",GetLocation(OBJECT_SELF));SetLocalInt(oNew,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));}
}
