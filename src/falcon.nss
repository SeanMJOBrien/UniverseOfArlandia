////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oMaster;object oDest;
object oArea = GetArea(OBJECT_SELF);
string sTag = GetTag(oArea);
string sDest = GetLocalString(OBJECT_SELF,"Dest");
string sMaster = GetLocalString(OBJECT_SELF,"Master");
object oItem = GetLocalObject(OBJECT_SELF,"Item");
object oPC = GetFirstPC();
int iWait = GetLocalInt(OBJECT_SELF,"Wait");
int iNum = GetLocalInt(OBJECT_SELF,"Num");
int i;int iDist;location lLoc;location lPC;int iLoc = Random(4);
int iAreaWidth = GetAreaSize(AREA_WIDTH,oArea)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,oArea)*10;
////////////////////////////////////////////////////////////////////////////////
while(GetIsObjectValid(oPC)){if(GetName(oPC)==sMaster){oMaster = oPC;}if(GetName(oPC)==sDest){oDest = oPC;i++;}oPC = GetNextPC();}if(i==0){oDest = oMaster;}
////////////////////////////////////////////////////////////////////////////////
// Waiting for recipient to be in a valid area
if(iWait==1){
if((GetTag(GetArea(oDest))!="")&&(GetStringLeft(GetName(GetArea(oDest)),5)!="Under")&&(!GetIsAreaInterior(GetArea(oDest))))
 {
SetLocalInt(OBJECT_SELF,"Wait",2);
DelayCommand(1.0,ExecuteScript("falcon",OBJECT_SELF));
SendMessageToAllDMs(sMaster+"'s falcon goes to the recipient area");
 }
else
 {
DelayCommand(10.0,ExecuteScript("falcon",OBJECT_SELF));
SendMessageToAllDMs(sMaster+"'s falcon waits for a valid recipient area");
 }
////////////////////////////////////////////////////////////////////////////////
// Teleport into recipient area
}else if(iWait==2){
//
if(GetTag(GetArea(oDest))!=sTag)
 {
     if(iLoc==0){lLoc = Location(GetArea(oDest),Vector(IntToFloat(GetAreaSize(AREA_WIDTH,GetArea(oDest))*10)-1.0,IntToFloat(GetAreaSize(AREA_HEIGHT,GetArea(oDest))*10)-1.0,0.0),0.0);}
else if(iLoc==1){lLoc = Location(GetArea(oDest),Vector(0.0,IntToFloat(GetAreaSize(AREA_HEIGHT,GetArea(oDest))*10)-1.0,0.0),0.0);}
else if(iLoc==2){lLoc = Location(GetArea(oDest),Vector(IntToFloat(GetAreaSize(AREA_WIDTH,GetArea(oDest))*10)-1.0,0.0,0.0),0.0);}
else            {lLoc = Location(GetArea(oDest),Vector(0.0,0.0,0.0),0.0);}
ClearAllActions();
JumpToLocation(lLoc);
ActionMoveToObject(oDest,TRUE);
DelayCommand(3.0,ExecuteScript("falcon",OBJECT_SELF));
 }
else
 {
ActionMoveToObject(oDest,TRUE);
if(GetDistanceToObject(oDest)<3.0){SetLocalObject(OBJECT_SELF,"PC",oDest);ExecuteScript("falcon2",OBJECT_SELF);}
if(GetDistanceToObject(oDest)>3.0){SendMessageToPC(oDest,"Falcon approaching : "+IntToString(FloatToInt(GetDistanceToObject(oDest)))+" feets");DelayCommand(6.0,ExecuteScript("falcon",OBJECT_SELF));}
 }
////////////////////////////////////////////////////////////////////////////////
// Recipient in server
}else if(i>0){
//
SetLocalInt(GetMaster(OBJECT_SELF),"FalconAway"+IntToString(iNum),1);
RemoveHenchman(GetMaster(OBJECT_SELF),OBJECT_SELF);
//
if(GetArea(oDest)==oArea)
 {
SetLocalInt(OBJECT_SELF,"Wait",2);
ActionMoveToObject(oDest,TRUE);
if(GetDistanceToObject(oDest)>3.0){SendMessageToPC(oDest,"Falcon approaching : "+IntToString(FloatToInt(GetDistanceToObject(oDest)))+" feets");DelayCommand(6.0,ExecuteScript("falcon",OBJECT_SELF));}
if(GetDistanceToObject(oDest)<3.0){SetLocalObject(OBJECT_SELF,"PC",oDest);ExecuteScript("falcon2",OBJECT_SELF);}
 }
else
 {
     if(iLoc==0){lLoc = Location(oArea,Vector(IntToFloat(iAreaWidth)-1.0,IntToFloat(iAreaHeight)-1.0,0.0),0.0);}
else if(iLoc==1){lLoc = Location(oArea,Vector(0.0,IntToFloat(iAreaHeight)-1.0,0.0),0.0);}
else if(iLoc==2){lLoc = Location(oArea,Vector(IntToFloat(iAreaWidth)-1.0,0.0,0.0),0.0);}
else            {lLoc = Location(oArea,Vector(0.0,0.0,0.0),0.0);}
ActionForceMoveToLocation(lLoc,TRUE,10.0);
DelayCommand(10.0,SetLocalInt(OBJECT_SELF,"Wait",1));
DelayCommand(10.0,ActionJumpToLocation(GetLocation(GetWaypointByTag("WP_source"))));
DelayCommand(10.0,SendMessageToAllDMs(sMaster+"'s falcon waits for 60 seconds"));
DelayCommand(20.0,SendMessageToAllDMs(sMaster+"'s falcon waits for 50 seconds"));
DelayCommand(30.0,SendMessageToAllDMs(sMaster+"'s falcon waits for 40 seconds"));
DelayCommand(40.0,SendMessageToAllDMs(sMaster+"'s falcon waits for 30 seconds"));
DelayCommand(50.0,SendMessageToAllDMs(sMaster+"'s falcon waits for 20 seconds"));
DelayCommand(60.0,SendMessageToAllDMs(sMaster+"'s falcon waits for 10 seconds"));
DelayCommand(70.0,ExecuteScript("falcon",OBJECT_SELF));
 }
////////////////////////////////////////////////////////////////////////////////
// Recipient no more in server
}else{SpeakString(sDest+" not found");CopyItem(oItem,oMaster,TRUE);DestroyObject(oItem);}
////////////////////////////////////////////////////////////////////////////////
}
