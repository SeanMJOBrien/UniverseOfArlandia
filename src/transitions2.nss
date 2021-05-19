#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetClickingObject();if(oPC==OBJECT_INVALID){oPC = GetPlaceableLastClickedBy();}if(oPC==OBJECT_INVALID){oPC = GetPCSpeaker();}if(oPC==OBJECT_INVALID){oPC = GetLocalObject(OBJECT_SELF,"PC");}
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);
string sAreaTag = GetTag(oArea);
string sX = IntToString(FloatToInt(GetPosition(OBJECT_SELF).x));
string sY = IntToString(FloatToInt(GetPosition(OBJECT_SELF).y));
object oHang = GetNearestObject(OBJECT_TYPE_PLACEABLE);
string sHang = GetName(oHang);
string sMaster = GetLocalString(OBJECT_SELF,"Master");
//
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterest = GetStringLeft(sInterests,FindSubString(sInterests,"&1&"));
string sDungeonType = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_B_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_B_")))-FindSubString(sInterest,"_A_")-3);
string sDungeonNumber = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"_C_")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"_C_")))-FindSubString(sInterest,"_B_")-3);
string sVar = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")))-FindSubString(sInterests,"&2&")-3);
if((GetStringLeft(sInterest,1)=="3")&&(GetLocalInt(OBJECT_SELF,"Door")!=3)){sX = "Under";sY = "";}
//
string sAreaExit = GetLocalString(oArea,"AreaExit");
string sAreaChosen = GetLocalString(oModule,sPlanet+"_"+sArea+"&"+sX+sY);
float fX = GetLocalFloat(oModule,sPlanet+"_"+sArea+"_IntX");
float fY = GetLocalFloat(oModule,sPlanet+"_"+sArea+"_IntY");
//
string sTot = GetPersistentString(oModule,sPlanet);
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));if(iLevel<1){iLevel = 1;}
object oDoor1 = GetLocalObject(oArea,"Door1");
object oDoor2 = GetLocalObject(oArea,"Door2");
object oDoor3 = GetLocalObject(oArea,"Door3");
int iLevel2 = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
string sSpaceDung;if(GetStringLeft(GetTag(oHang),13)=="pla_spacedung"){sSpaceDung = GetStringRight(GetTag(oHang),1);}
//
object oTargetArea;string sTargetArea;string sAreaNumber;string sNewArea;int iCheck;int i;float fF = DIRECTION_NORTH;
string sCheckStore;string sCheckChest;string sCheckDungeon;string sCheckDomain;string sCheckSpace;object oStore;object oChest;string sLeft;string sRight;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Enter
if((sTag=="entry")||(sTag=="door_entry")||(sTag=="structureflag")||(sSpaceDung!=""))
 {
//
if(sAreaChosen!=""){iCheck = 1;sTargetArea = sAreaChosen;oTargetArea = GetObjectByTag(sTargetArea);}else
  {
////////////////////////////////////////////////////////////////////////////////
// Placeable entry
if((sTag=="entry")||(sTag=="structureflag")||(sSpaceDung!=""))
   {
// Town hall
if(GetStringLeft(sInterest,1)=="1")
    {
sNewArea = "townhall";   fX = 55.0;fY = 15.0;    sCheckStore = sVar;
    }
// Dungeon
else if((GetStringLeft(sInterest,1)=="2")||((GetStringLeft(sInterest,1)=="D")&&(GetLocalInt(OBJECT_SELF,"Structure")==4)))
    {
if(GetStringLeft(sInterest,1)=="D"){if(GetPersistentString(oModule,sPlanet+"&"+sArea+IntToString(iSlot))==""){FloatingTextStringOnCreature("*no way*",oPC);return;}else{sDungeonType = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));sDungeonNumber = "1";sCheckDungeon = IntToString(iLevel2);}}
     if(sDungeonType=="1"){sNewArea = "d_temple"+sDungeonNumber+"_";fX = 255.0;fY = 5.0;}
else if(sDungeonType=="2"){sNewArea = "d_cave"+sDungeonNumber+"_";fX = 305.0;fY = 5.0;}
else if(sDungeonType=="3"){sNewArea = "d_pyramid"+sDungeonNumber+"_";fX = 215.0;fY = 5.0;}
else if(sDungeonType=="4"){sNewArea = "d_oldcastle"+sDungeonNumber+"_";fX = 165.0;fY = 5.0;}
else if(sDungeonType=="5"){sNewArea = "d_crypt"+sDungeonNumber+"_";fX = 245.0;fY = 5.0;}
else if(sDungeonType=="6"){sNewArea = "d_towerw"+sDungeonNumber+"_";fX = 255.0;fY = 5.0;}
else if(sDungeonType=="7"){sNewArea = "d_towerb"+sDungeonNumber+"_";fX = 255.0;fY = 5.0;}
else if(sDungeonType=="8"){sNewArea = "d_dung"+sDungeonNumber+"_";fX = 55.0;fY = 5.0;}
    }
// Castle
else if(GetStringLeft(sInterest,1)=="3")
    {
if(GetLocalInt(OBJECT_SELF,"Door")==3){sNewArea = "h_castle1_";}else{sNewArea = "d_castle1_";}
    }
// Ruins
else if((GetStringLeft(sInterest,1)=="4")||(GetStringLeft(sAreaTag,8)=="h_ruins_"))
    {
if(GetStringLeft(GetResRef(OBJECT_SELF),4)=="trap"){if(GetIsAreaInterior(oArea)){AssignCommand(oPC,ActionJumpToObject(GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF)));return;}else{sNewArea = "h_ruins1_";fX = 8.0;fY = 5.0;}}else{sNewArea = "h_ruins_";fX = 45.0;fY = 5.0;}
    }
// Resources mountain
else if(GetStringLeft(sInterest,1)=="6")
    {
if(GetLocalInt(oPC,"ResMountain")>0){sNewArea = "h_mountain_";fX = 65.0;fY = 5.0;}else{return;}
    }
// Amusement place
else if(GetStringLeft(sInterest,1)=="7")
    {
if(GetLocalInt(OBJECT_SELF,"Well")==1){if(GetName(oPC)==GetLocalString(GetNearestObjectByTag("player"),"PC")){sNewArea = "h_well_";fX = 3.0;fY = 36.0;fF = DIRECTION_EAST;}}else{sNewArea = "h_amusement_";fX = 45.0;fY = 8.0;}
    }
// Domain
else if(GetStringLeft(sInterest,1)=="D")
    {
     if(GetLocalInt(OBJECT_SELF,"Structure")==9){sNewArea = "h_guild_";fX = 35.0;fY = 5.0;}
else if(GetLocalInt(OBJECT_SELF,"Structure")==10){sNewArea = "h_hall_";fX = 65.0;fY = 5.0;}
else if(GetLocalInt(OBJECT_SELF,"Structure")==11){sNewArea = "h_house_";fX = 13.0;fY = 3.0;sMaster = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));}
else if(GetLocalInt(OBJECT_SELF,"Structure")==12){sNewArea = "inn";fX = 25.0;fY = 5.0;}
else if(GetLocalInt(OBJECT_SELF,"Structure")==13){sNewArea = "h_office_";fX = 5.0;fY = 7.0;}
else if(GetLocalInt(OBJECT_SELF,"Structure")==14){if(iLevel2>=5){sNewArea = "h_home3_";fX = 45.0;fY = 7.0;}else if(iLevel2>=3){sNewArea = "h_home2_";fX = 15.0;fY = 7.0;}else{sNewArea = "h_home1_";fX = 13.0;fY = 3.0;}}
else if(GetLocalInt(OBJECT_SELF,"Structure")==15){sNewArea = "h_school_";fX = 45.0;fY = 5.0;}
else if(GetLocalInt(OBJECT_SELF,"Structure")==16){sNewArea = "shop";fX = 5.0;fY = 5.0;sCheckStore = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));}
else if(GetLocalInt(OBJECT_SELF,"Structure")==18){sNewArea = "tavern";fX = 25.0;fY = 5.0;}
else if(GetLocalInt(OBJECT_SELF,"Structure")==19){sNewArea = "temple";fX = 15.0;fY = 5.0;}
else if(GetLocalInt(OBJECT_SELF,"Structure")==20){sNewArea = "h_tower_";fX = 84.0;fY = 7.0;}
sCheckDomain = "1";
    }
// Camp tent
else if(GetLocalInt(OBJECT_SELF,"Camp")==1)
    {
sNewArea = "monstertent";   fX = 10.0;fY = 3.0;sCheckChest = "chest00"+IntToString(iLevel);
    }
// Space Towers
else if(GetName(oArea)=="Space")
    {
     if(sSpaceDung=="1"){sNewArea = "d_towerb1_";fX = 255.0;fY = 5.0;sCheckSpace = sSpaceDung;}
else if(sSpaceDung=="2"){sNewArea = "d_spaceship1_";fX = 25.0;fY = 45.0;fF = DIRECTION_SOUTH;sCheckSpace = sSpaceDung;}
    }
   }
////////////////////////////////////////////////////////////////////////////////
// Door entry
else if(sTag=="door_entry")
   {
////////////////////////////////////////////////////////////////////////////////
// City shops
// Shops
if((GetStringLeft(sAreaTag,4)=="base")||(GetStringLeft(sAreaTag,4)=="city"))
    {
     if(sHang=="Inn")           {sNewArea = "inn";      fX = 25.0;fY = 5.0;}
else if(sHang=="Tavern")        {sNewArea = "tavern";   fX = 25.0;fY = 5.0;}
else if(sHang=="Bank")          {sNewArea = "shop";     fX = 5.0; fY = 5.0; sCheckStore = "010";}
else if(sHang=="General Shop")  {sNewArea = "shop";     fX = 5.0; fY = 5.0; sCheckStore = "001";}
else if(sHang=="Temple")        {sNewArea = "temple";   fX = 15.0;fY = 5.0;}
else if(sVar=="011")            {sNewArea = "animal";   fX = 15.0;fY = 5.0;}
else if(sVar=="009")            {sNewArea = "library";  fX = 15.0;fY = 5.0;}
else if(sVar=="004")            {sNewArea = "arcana";   fX = 15.0;fY = 5.0;}
else if(sVar=="015")            {sNewArea = "temple";   fX = 15.0;fY = 5.0;}
else                            {sNewArea = "shop";     fX = 5.0; fY = 5.0; sCheckStore = sVar;}
    }
////////////////////////////////////////////////////////////////////////////////
   }
////////////////////////////////////////////////////////////////////////////////
// Choose area
while(i<10)
   {
i++;if(i<10){sAreaNumber = "00"+IntToString(i);}else{sAreaNumber = "0"+IntToString(i);}
sTargetArea = sNewArea+sAreaNumber;oTargetArea = GetObjectByTag(sTargetArea);

if((GetIsObjectValid(oTargetArea))&&(GetLocalInt(oTargetArea,"Used")<1))
    {
SetLocalInt(oTargetArea,"Used",1);
SetLocalString(oModule,sPlanet+"_"+sArea+"&"+sX+sY,sTargetArea);
SetLocalFloat(oModule,sPlanet+"_"+sArea+"_IntX",fX);
SetLocalFloat(oModule,sPlanet+"_"+sArea+"_IntY",fY);
SetLocalString(oTargetArea,"Var",sPlanet+"_"+sArea+"&"+sX+sY);
SetLocalString(oTargetArea,"Planet",sPlanet);
SetLocalString(oTargetArea,"Area",sArea+"&"+sX+sY);
SetLocalString(oTargetArea,"AreaExit",sArea);
SetLocalFloat(oTargetArea,"fXExit",GetPosition(oPC).x);
SetLocalFloat(oTargetArea,"fYExit",(GetPosition(oPC).y)-1.0);
iCheck = 1;

if(sCheckStore!="")
     {
SetLocalString(oTargetArea,"Master",sMaster);sCheckStore = "store"+sCheckStore;oStore = CreateObject(OBJECT_TYPE_STORE,sCheckStore,GetLocation(GetWaypointByTag("wp_"+sTargetArea)));SetLocalInt(oStore,"DontSave",1);
     }
if(sCheckChest!="")
     {
// Chest
if(GetLocalInt(oModule,sPlanet+sArea+"CampTent")!=1){oChest = CreateObject(OBJECT_TYPE_PLACEABLE,sCheckChest,Location(oTargetArea,Vector(10.0,15.0,0.0),90.0));SetLocalInt(oChest,"Camp",1);SetName(oChest,"Chest");if(Random(2)==0){SetLocked(oChest,TRUE);}if(Random(3)==0){CreateTrapOnObject(TRAP_BASE_TYPE_AVERAGE_SONIC,oChest,STANDARD_FACTION_HOSTILE,"unlock_disarm");}
// Creatures
SetLocalInt(oTargetArea,"DungeonFamily",StringToInt(GetStringLeft(GetLocalString(OBJECT_SELF,"Var"),FindSubString(GetLocalString(OBJECT_SELF,"Var"),"&"))));SetLocalInt(oTargetArea,"DungeonLevel",StringToInt(GetStringRight(GetLocalString(OBJECT_SELF,"Var"),1)));SetLocalInt(oTargetArea,"DungeonRespawn",5);ExecuteScript("dungeons",oTargetArea);}
// Lock
SetLocalInt(oModule,sPlanet+sArea+"CampTent",1);
     }
if(sCheckDungeon!="")
     {
SetLocalInt(oTargetArea,"DDLevel",StringToInt(sCheckDungeon));
     }
if(sCheckDomain!="")
     {
SetLocalString(oTargetArea,"Master",sMaster);SetLocalInt(oTargetArea,"Slot",iSlot);SetLocalInt(oTargetArea,"Structure",iStructure);SetLocalInt(oTargetArea,"Level",iLevel2);
     }
if(sCheckSpace!="")
     {
SetLocalString(oTargetArea,"Master",sCheckSpace);
     }
// Castle
if(GetStringLeft(sInterest,1)=="3")
     {
if(GetLocalInt(OBJECT_SELF,"Door")==1){fX = 275.0;fY = 145.0;}else if(GetLocalInt(OBJECT_SELF,"Door")==2){fX = 35.0;fY = 45.0;fF = DIRECTION_SOUTH;}else{fX = 5.0;fY = 255.0;fF = DIRECTION_EAST;}
SetLocalFloat(oTargetArea,"fXExit1",GetPosition(oDoor1).x);SetLocalFloat(oTargetArea,"fYExit1",(GetPosition(oDoor1).y)-1.0);
SetLocalFloat(oTargetArea,"fXExit2",GetPosition(oDoor2).x);SetLocalFloat(oTargetArea,"fYExit2",(GetPosition(oDoor2).y)+1.0);
SetLocalFloat(oTargetArea,"fXExit3",(GetPosition(oDoor3).x)-1.0);SetLocalFloat(oTargetArea,"fYExit3",GetPosition(oDoor3).y);
     }
break;
    }
   }
SetLocalFloat(oTargetArea,"fX",fX);
SetLocalFloat(oTargetArea,"fY",fY);
SetLocalFloat(oTargetArea,"fF",fF);
  }
////////////////////////////////////////////////////////////////////////////////
if(iCheck==1)
  {
// Lock target area
SetLocalString(oPC,"PlayerAreaTo",GetTag(oTargetArea));
// Jump player
AssignCommand(oPC,ActionJumpToLocation(Location(oTargetArea,Vector(GetLocalFloat(oTargetArea,"fX"),GetLocalFloat(oTargetArea,"fY"),0.0),GetLocalFloat(oTargetArea,"fF"))));
  }
else
  {
FloatingTextStringOnCreature("*no area available*",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Exit
////////////////////////////////////////////////////////////////////////////////
else if((sTag=="exit")||(sTag=="door_exit"))
 {
fX = GetLocalFloat(oArea,"fXExit");
fY = GetLocalFloat(oArea,"fYExit");
fF = DIRECTION_SOUTH;
// Not south exits
if(GetStringRight(GetStringLeft(sAreaTag,9),7)=="castle1"){if(GetLocalInt(OBJECT_SELF,"Door")==1){fX = GetLocalFloat(oArea,"fXExit1");fY = GetLocalFloat(oArea,"fYExit1");}else if(GetLocalInt(OBJECT_SELF,"Door")==2){fX = GetLocalFloat(oArea,"fXExit2");fY = GetLocalFloat(oArea,"fYExit2");fF = DIRECTION_NORTH;}else{fX = GetLocalFloat(oArea,"fXExit3");fY = GetLocalFloat(oArea,"fYExit3");fF = DIRECTION_WEST;}}
else if(GetStringLeft(sAreaTag,8)=="townhall"){fF = DIRECTION_EAST;}
else if(GetStringLeft(sAreaTag,7)=="h_well_"){fF = DIRECTION_WEST;}
//
SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sAreaExit);
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",fF);
//
ExecuteScript("transitions",oPC);
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Dungeon doors
else if(GetStringLeft(sTag,12)=="door_dungeon")
 {
int iHench = 1;object oHenchs = GetHenchman(oPC,iHench);
if(GetStringRight(sTag,2)=="up")
  {
AssignCommand(oPC,JumpToObject(GetNearestObjectByTag("door_dungeon_dn")));
while(GetIsObjectValid(oHenchs)){AssignCommand(oHenchs,JumpToObject(GetNearestObjectByTag("door_dungeon_dn")));iHench++;oHenchs = GetHenchman(oPC,iHench);}
  }
else
  {
AssignCommand(oPC,JumpToObject(GetNearestObjectByTag("door_dungeon_up")));
while(GetIsObjectValid(oHenchs)){AssignCommand(oHenchs,JumpToObject(GetNearestObjectByTag("door_dungeon_up")));iHench++;oHenchs = GetHenchman(oPC,iHench);}
  }
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Sewers entry
else if(GetStringLeft(sTag,4)=="city")
 {
sLeft = GetStringLeft(sTag,8);
sRight = GetStringRight(sTag,1);
sAreaChosen = GetLocalString(oModule,sPlanet+"_"+sArea+"_Sewer");

if(sAreaChosen!=""){iCheck = 1;sTargetArea = sAreaChosen;oTargetArea = GetObjectByTag(sTargetArea);}else
  {
if((GetStringLeft(sTag,5)=="citya")||(GetStringLeft(sTag,5)=="cityb")){sNewArea = "sewera";}else{sNewArea = "sewerb";}

while(i<10)
   {
i++;if(i<10){sAreaNumber = "00"+IntToString(i);}else{sAreaNumber = "0"+IntToString(i);}
sTargetArea = sNewArea+sAreaNumber;oTargetArea = GetObjectByTag(sTargetArea);

if((GetIsObjectValid(oTargetArea))&&(GetLocalInt(oTargetArea,"Used")<1))
    {
SetLocalInt(oTargetArea,"Used",1);
SetLocalString(oModule,sPlanet+"_"+sArea+"_Sewer",sTargetArea);
SetLocalString(oTargetArea,"Planet",sPlanet);
SetLocalString(oTargetArea,"Area",sArea+"_Sewer");
SetLocalString(oTargetArea,"AreaExit",GetStringLeft(sAreaTag,GetStringLength(sAreaTag)-3));
iCheck = 1;
break;
    }
   }
  }
////////////////////////////////////////////////////////////////////////////////
if(iCheck==1)
  {
// Lock target area
SetLocalString(oPC,"PlayerAreaTo",GetTag(oTargetArea));
// Jump player
AssignCommand(oPC,ActionJumpToObject(GetObjectByTag(sTargetArea+"_"+sRight)));
  }
else
  {
FloatingTextStringOnCreature("*no area available*",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Sewers exit
else if(GetStringLeft(sTag,5)=="sewer")
 {
sArea = GetStringLeft(sArea,GetStringLength(sArea)-6);
sRight = GetStringRight(sTag,1);
sAreaChosen = GetLocalString(oModule,sPlanet+"_"+sArea);

if(sAreaChosen!=""){iCheck = 1;sTargetArea = sAreaChosen;oTargetArea = GetObjectByTag(sTargetArea);}else
  {
sNewArea = GetLocalString(oArea,"AreaExit");

while(i<10)
   {
i++;if(i<10){sAreaNumber = "00"+IntToString(i);}else{sAreaNumber = "0"+IntToString(i);}
sTargetArea = sNewArea+sAreaNumber;oTargetArea = GetObjectByTag(sTargetArea);

if((GetIsObjectValid(oTargetArea))&&(GetLocalInt(oTargetArea,"Used")<1))
    {
SetLocalInt(oTargetArea,"Used",1);
SetLocalString(oModule,sPlanet+"_"+sArea,sTargetArea);
SetLocalString(oTargetArea,"Planet",sPlanet);
SetLocalString(oTargetArea,"Area",sArea);
iCheck = 1;
break;
    }
   }
  }
////////////////////////////////////////////////////////////////////////////////
if(iCheck==1)
  {
// Lock target area
SetLocalString(oPC,"PlayerAreaTo",GetTag(oTargetArea));
// Jump player
AssignCommand(oPC,ActionJumpToObject(GetObjectByTag(sTargetArea+"_"+sRight)));
  }
else
  {
FloatingTextStringOnCreature("*no area available*",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Ruins
else if(sTag=="Ruins_Int")
 {
AssignCommand(oPC,ActionJumpToObject(GetNearestObject(OBJECT_TYPE_WAYPOINT,oPC)));
 }
////////////////////////////////////////////////////////////////////////////////
}
