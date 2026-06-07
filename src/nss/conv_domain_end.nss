void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oPla;int iNB;

while(iNB<5)
 {
iNB++;
oPla = GetLocalObject(oPC,"DomainPla"+IntToString(iNB));
DestroyObject(oPla);
DeleteLocalObject(oPC,"DomainPla"+IntToString(iNB));
 }
DeleteLocalString(oArea,"Domain_Build");
DeleteLocalString(oArea,"Domain_Res");
DeleteLocalInt(oArea,"Domain_Upgrade");
DeleteLocalInt(oArea,"Domain_Ini");
DeleteLocalObject(oArea,"PC");

ExecuteScript("conv_dm_varempty",OBJECT_SELF);
ExecuteScript("conv_dm_varempty",oPC);
}
