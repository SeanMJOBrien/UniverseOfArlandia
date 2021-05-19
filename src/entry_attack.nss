void main()
{
object oModule = GetModule();
object oPC = GetLastAttacker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sX = IntToString(FloatToInt(GetPosition(OBJECT_SELF).x));
string sY = IntToString(FloatToInt(GetPosition(OBJECT_SELF).y));
int iCamp = GetLocalInt(OBJECT_SELF,"Camp");
object oObjects = GetFirstObjectInArea(oArea);

if((iCamp==1)&&(GetIsDM(oPC)))
 {
while(GetIsObjectValid(oObjects))
  {
if(GetLocalInt(oObjects,"Camp")==1)
   {
SetImmortal(oObjects,FALSE);SetPlotFlag(oObjects,FALSE);AssignCommand(oObjects,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObjects);
   }
oObjects = GetNextObjectInArea(oArea);
  }
 }
DeleteLocalInt(oModule,sPlanet+sArea+"CampTent");
DeleteLocalInt(oModule,sPlanet+"&"+sArea+"&"+sX+sY+"&ObjectsTot");
}
