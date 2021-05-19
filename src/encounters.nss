////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetEnteringObject();
int iLevel = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
//
object oArea = GetArea(OBJECT_SELF);
string sAreaTag = GetTag(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
float fX = GetPosition(OBJECT_SELF).x;
float fY = GetPosition(OBJECT_SELF).y;
int iAreaX = GetAreaSize(AREA_WIDTH,oArea)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,oArea)*10;
int iEnc = GetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Enc");
object oWP = GetNearestObject(OBJECT_TYPE_WAYPOINT,OBJECT_SELF);
object oDoor1 = GetNearestObject(OBJECT_TYPE_DOOR,oWP,1);
object oDoor2 = GetNearestObject(OBJECT_TYPE_DOOR,oWP,2);
object oWP1 = GetNearestObjectByTag(GetStringLeft(GetTag(oWP),GetStringLength(GetTag(oWP))-5),oWP,1);
object oWP2 = GetNearestObjectByTag(GetStringLeft(GetTag(oWP),GetStringLength(GetTag(oWP))-5),oWP,2);
//
object oNew;string sSpawn;int iRandom;int i;
////////////////////////////////////////////////////////////////////////////////
if((GetIsPC(oPC))&&(iEnc!=1))
 {
////////////////////////////////////////////////////////////////////////////////
// Castle Interior
if(GetStringLeft(sAreaTag,9)=="h_castle1")
  {
////////////////////////////////////////////////////////////////////////////////
if(iLevel<6)
   {
iRandom = Random(5)+1;
     if(iRandom==1){sSpawn = "nw_minotaur";}
else if(iRandom==2){sSpawn = "nw_minchief";}
else if(iRandom==3){sSpawn = "mn_giant001";}
else if(iRandom==4){sSpawn = "mn_vampire004";}
else if(iRandom==5){sSpawn = "mn_vampire001";}
   }
else if(iLevel<10)
   {
iRandom = Random(5)+1;
     if(iRandom==1){sSpawn = "nw_minwiz";}
else if(iRandom==2){sSpawn = "mn_giant002";}
else if(iRandom==3){sSpawn = "mn_giant004";}
else if(iRandom==4){sSpawn = "mn_vampire005";}
else if(iRandom==5){sSpawn = "mn_vampire002";}
   }
else
   {
iRandom = Random(5)+1;
     if(iRandom==1){sSpawn = "nw_minotaurboss";}
else if(iRandom==2){sSpawn = "mn_giant005";}
else if(iRandom==3){sSpawn = "mn_vampire003";}
else if(iRandom==4){sSpawn = "mn_troll003";}
else if(iRandom==5){sSpawn = "mn_squel011";}
   }
SetLocked(oDoor1,FALSE);AssignCommand(oDoor1,ActionOpenDoor(oDoor1));SetLocalInt(oDoor1,"Locked",1);
oNew = CreateObject(OBJECT_TYPE_CREATURE,sSpawn,GetLocation(oWP1));AssignCommand(oNew,ActionAttack(oPC));
// If all doors open, open the field door
if((GetIsOpen(GetNearestObjectByTag("Portcullis",oWP,2)))&&(GetIsOpen(GetNearestObjectByTag("Portcullis",oWP,3)))&&(GetIsOpen(GetNearestObjectByTag("Portcullis",oWP,4)))&&(GetIsOpen(GetNearestObjectByTag("Portcullis",oWP,5)))&&(GetIsOpen(GetNearestObjectByTag("Portcullis",oWP,6)))&&(GetIsOpen(GetNearestObjectByTag("Portcullis",oWP,7)))&&(GetIsOpen(GetNearestObjectByTag("Portcullis",oWP,8))))
   {
oDoor2 = GetNearestObjectByTag("x3_door_oth003",oWP);
SetLocked(oDoor2,FALSE);AssignCommand(oDoor2,ActionOpenDoor(oDoor2));SetLocalInt(oDoor2,"Locked",1);
   }
  }
////////////////////////////////////////////////////////////////////////////////
// Castle Underground
else if(GetStringLeft(sAreaTag,9)=="d_castle1")
  {
if(iLevel<6)
   {
iRandom = Random(3)+1;
     if(iRandom==1){sSpawn = "mn_animated012";}
else if(iRandom==2){sSpawn = "mn_animated010";}
else if(iRandom==3){sSpawn = "mn_animated009";}
   }
else if(iLevel<10)
   {
iRandom = Random(3)+1;
     if(iRandom==1){sSpawn = "mn_animated011";}
else if(iRandom==2){sSpawn = "mn_animated013";}
else if(iRandom==3){sSpawn = "mn_statueanim001";}
   }
else
   {
sSpawn = "mn_statueanim002";
   }
SetLocked(oDoor1,FALSE);AssignCommand(oDoor1,ActionOpenDoor(oDoor1));SetLocalInt(oDoor1,"Locked",1);
SetLocked(oDoor2,FALSE);AssignCommand(oDoor2,ActionOpenDoor(oDoor2));SetLocalInt(oDoor2,"Locked",1);
oNew = CreateObject(OBJECT_TYPE_CREATURE,sSpawn,GetLocation(oWP1));AssignCommand(oNew,ActionAttack(oPC));
oNew = CreateObject(OBJECT_TYPE_CREATURE,sSpawn,GetLocation(oWP2));AssignCommand(oNew,ActionAttack(oPC));
  }
////////////////////////////////////////////////////////////////////////////////
else if((GetStringLeft(sAreaTag,7)=="h_well_")&&(GetLocalInt(oArea,"NoCamp")!=1))
  {
oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_anilizard003",Location(oArea,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0));SetLocalInt(oNew,"DontSave",1);
object oItem = CreateItemOnObject("cr_head",oNew,1,"lizardhead");SetPlotFlag(oItem,TRUE);SetDroppableFlag(oItem,TRUE);
SetLocalInt(oArea,"NoCamp",1);i = 1;
  }
////////////////////////////////////////////////////////////////////////////////
if(i==0){SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Enc",1);}
 }
////////////////////////////////////////////////////////////////////////////////
}
