int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
string sTag = GetTag(OBJECT_SELF);

object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iTrained = GetLocalInt(oModule,sPlanet+"_"+sArea+"_"+GetName(oPC));

if((sTag=="trainer")&&(iTrained!=1)){return TRUE;}else{return FALSE;}
}
