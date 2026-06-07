void main()
{
object oPC = GetPCSpeaker();

if((GetResRef(OBJECT_SELF)=="hench000")&&(GetLocalInt(OBJECT_SELF,"HenchNum")==0)){SetLocalInt(oPC,"HenchAction",1);}else{SetLocalInt(oPC,"HenchAction",4);}
SetLocalObject(oPC,"Hench",OBJECT_SELF);
ExecuteScript("henchs",oPC);
}
