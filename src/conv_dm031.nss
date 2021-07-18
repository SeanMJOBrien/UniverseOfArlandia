void main()
{
object oPC = GetPCSpeaker();
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");
object oObject;int iType;

     if(iChoice==1){iType = OBJECT_TYPE_CREATURE;oObject = GetNearestObject(iType,oPC);while((GetIsObjectValid(oObject))&&(GetLocalInt(oObject,"Permanent")==1)){oObject = GetNearestObject(iType,oPC);}}
else if(iChoice==2){iType = OBJECT_TYPE_DOOR;oObject = GetNearestObject(iType,oPC);while((GetIsObjectValid(oObject))&&(GetLocalInt(oObject,"Permanent")==1)){oObject = GetNearestObject(iType,oPC);}}
else if(iChoice==3){iType = OBJECT_TYPE_ITEM;oObject = GetNearestObject(iType,oPC);while((GetIsObjectValid(oObject))&&(GetLocalInt(oObject,"Permanent")==1)){oObject = GetNearestObject(iType,oPC);}}
else if(iChoice==4){iType = OBJECT_TYPE_ALL;oObject = GetNearestObject(iType,oPC);while((GetIsObjectValid(oObject))&&(GetLocalInt(oObject,"Permanent")==1)){oObject = GetNearestObject(iType,oPC);}}
else if(iChoice==5){iType = OBJECT_TYPE_PLACEABLE;oObject = GetNearestObject(iType,oPC);while((GetIsObjectValid(oObject))&&(GetLocalInt(oObject,"Permanent")==1)){oObject = GetNearestObject(iType,oPC);}}
else if(iChoice==6){iType = OBJECT_TYPE_STORE;oObject = GetNearestObject(iType,oPC);while((GetIsObjectValid(oObject))&&(GetLocalInt(oObject,"Permanent")==1)){oObject = GetNearestObject(iType,oPC);}}
else if(iChoice==7){iType = OBJECT_TYPE_WAYPOINT;oObject = GetNearestObject(iType,oPC);while((GetIsObjectValid(oObject))&&(GetLocalInt(oObject,"Permanent")==1)){oObject = GetNearestObject(iType,oPC);}}

DestroyObject(oObject);
SendMessageToPC(oPC,GetName(oObject)+" destroyed.");
}
