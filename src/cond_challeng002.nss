int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sTag = GetTag(OBJECT_SELF);
int iChallenge = GetLocalInt(oModule,sPlanet+sArea+GetName(oPC)+"MC");

if((sTag=="altar_challenges")&&(iChallenge==0)){return TRUE;}else{return FALSE;}
}
