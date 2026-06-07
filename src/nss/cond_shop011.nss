int StartingConditional()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
object oItem = GetItemPossessedBy(oPC,sPlanet+"account");
int i;

if(GetIsObjectValid(oItem)){return TRUE;}else{return FALSE;}
}
