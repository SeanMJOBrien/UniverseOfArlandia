void main()
{
object oModule = GetModule();
object oPC = GetLastUsedBy();
string sLoc = GetLocalString(OBJECT_SELF,"Var");
string s001 = GetStringLeft(sLoc,FindSubString(sLoc,"_A_"));
string s002 = GetStringRight(GetStringLeft(sLoc,FindSubString(sLoc,"_B_")),GetStringLength(GetStringLeft(sLoc,FindSubString(sLoc,"_B_")))-FindSubString(sLoc,"_A_")-3);
location lLoc = Location(GetArea(OBJECT_SELF),Vector(StringToFloat(s001),StringToFloat(s002),0.0),0.0);
float fPC = GetFacing(oPC);

SetLocalFloat(oPC,"fPC",fPC);
AssignCommand(oPC,ActionJumpToLocation(lLoc));
DelayCommand(1.0,SetFacing(fPC+1.0));

object oArea = GetArea(OBJECT_SELF);
object oObject = GetFirstObjectInArea(oArea);
while(GetIsObjectValid(oObject))
 {
if(GetMaster(oObject)==oPC){AssignCommand(oObject,ActionJumpToLocation(lLoc));}
else if((!GetIsDM(oPC))&&(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oObject)>=90)&&(GetLocalInt(oObject,"InCombat")==1)&&(GetDistanceBetweenLocations(GetLocation(oObject),GetLocation(OBJECT_SELF))<=15.0)){DeleteLocalInt(oObject,"InCombat");AssignCommand(oObject,ClearAllActions());AssignCommand(oObject,ActionJumpToLocation(lLoc));AssignCommand(oObject,ActionAttack(oPC));}
oObject = GetNextObjectInArea(oArea);
 }
}
