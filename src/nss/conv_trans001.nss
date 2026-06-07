#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oFlag = GetLocalObject(OBJECT_SELF,"StructureFlag");
int iLevel = StringToInt(GetStringRight(GetName(oFlag),1));
int iHour = GetTimeHour();
int iAirShip;int iStarShip;int iStarshipD = -1;
////////////////////////////////////////////////////////////////////////////////
// Domains
if(GetIsObjectValid(oFlag))
   {
if(GetStringLeft(GetName(oFlag),7)=="Airship"){if(iLevel==1){iAirship2 = -1;iAirship3 = -1;}else if(iLevel<=3){iAirship2 = -1;}}
else if(GetStringLeft(GetName(oFlag),8)=="Starship"){if(iLevel>=2){iStarshipD = 20;}}
   }
////////////////////////////////////////////////////////////////////////////////
     if(iHour<iAirship1){iAirShip = iAirship1-iHour;}
else if(iHour<iAirship2){iAirShip = iAirship2-iHour;}
else if(iHour<iAirship3){iAirShip = iAirship3-iHour;}
else                    {iAirShip = 24-iHour+iAirship1;}

     if(iHour<iStarship){iStarShip = iStarship-iHour;}
else if(iHour<iStarshipD){iStarShip = iStarshipD-iHour;}
else                    {iStarShip = 24-iHour+iStarship;}
////////////////////////////////////////////////////////////////////////////////
SetCustomToken(10421,IntToString(iAirShip));
SetCustomToken(10422,IntToString(iStarShip));
////////////////////////////////////////////////////////////////////////////////
}
