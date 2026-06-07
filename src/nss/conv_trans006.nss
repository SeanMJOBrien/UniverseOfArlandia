////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
string sTag = GetTag(OBJECT_SELF);
//
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");
int iType = GetLocalInt(OBJECT_SELF,"Type"+IntToString(iChoice));
string sPlanetProv = GetLocalString(OBJECT_SELF,"PlanetProv"+IntToString(iChoice));
string sPlanetDest = GetLocalString(OBJECT_SELF,"PlanetDest"+IntToString(iChoice));
string sAreaProv = GetLocalString(OBJECT_SELF,"AreaProv"+IntToString(iChoice));
string sAreaDest = GetLocalString(OBJECT_SELF,"AreaDest"+IntToString(iChoice));
int iDist = GetLocalInt(OBJECT_SELF,"Dist"+IntToString(iChoice));
object oTicket = GetLocalObject(OBJECT_SELF,"Ticket"+IntToString(iChoice));
//
string sAreaChosen = GetLocalString(oModule,"Trans"+IntToString(iType)+sPlanetDest+sAreaDest);
string sNewArea;if(iType==1){sNewArea = "airship";}else if(iType==2){sNewArea = "starship";}
string sAreaNumber;string sTargetArea;object oTargetArea;int iCheck;int i;
////////////////////////////////////////////////////////////////////////////////
if(sAreaChosen!=""){iCheck = 1;sTargetArea = sAreaChosen;oTargetArea = GetObjectByTag(sTargetArea);}else
  {
////////////////////////////////////////////////////////////////////////////////
while(i<10)
   {
i++;if(i<10){sAreaNumber = "00"+IntToString(i);}else{sAreaNumber = "0"+IntToString(i);}
sTargetArea = sNewArea+sAreaNumber;oTargetArea = GetObjectByTag(sTargetArea);

if((GetIsObjectValid(oTargetArea))&&(GetLocalInt(oTargetArea,"Used")<1))
    {
SetLocalInt(oTargetArea,"Used",1);
SetLocalString(oTargetArea,"Planet","Transports");
SetLocalString(oTargetArea,"Area","Trans"+IntToString(iType)+sAreaDest);
SetLocalString(oModule,"Trans"+IntToString(iType)+sPlanetDest+sAreaDest,sTargetArea);

SetLocalInt(oTargetArea,"TransType",iType);
SetLocalString(oTargetArea,"PlanetProv",sPlanetProv);
SetLocalString(oTargetArea,"PlanetDest",sPlanetDest);
SetLocalString(oTargetArea,"AreaProv",sAreaProv);
SetLocalString(oTargetArea,"AreaDest",sAreaDest);
SetLocalInt(oTargetArea,"TransDist",iDist);

iCheck = 1;
break;
    }
   }
  }
////////////////////////////////////////////////////////////////////////////////
if(iCheck==1)
 {
// Mark ticket
SetLocalObject(oPC,"DestroyIt",oTicket);
// Lock target area
SetLocalString(oPC,"PlayerAreaTo",GetTag(oTargetArea));
// Jump player
AssignCommand(oPC,ActionJumpToLocation(GetLocation(GetWaypointByTag("WP_"+sTargetArea))));
 }
else
 {
FloatingTextStringOnCreature("*no area available*",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
}
