#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iRanger = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF);
int iCartographer;
////////////////////////////////////////////////////////////////////////////////
// Same tiering as the ranger "Cartographer" talent (mod_levelup.nss), but read
// off the henchman's own ranger level instead of the PC's goldbag flag.
     if(iRanger>=9){iCartographer = 5;}
else if(iRanger>=7){iCartographer = 4;}
else if(iRanger>=5){iCartographer = 3;}
else if(iRanger>=3){iCartographer = 2;}
else if(iRanger>=1){iCartographer = 1;}
////////////////////////////////////////////////////////////////////////////////
if(GetStringLeft(GetTag(oArea),6)=="clouds")
 {
SendMessageToPC(oPC,"Planet = "+sPlanet);
SendMessageToPC(oPC,"Area = "+sArea);
 }
else if(((iCartographer>=1)&&((GetIsAreaInterior(oArea))||(GetStringLeft(GetTag(oArea),4)=="city")||(GetStringLeft(GetTag(oArea),6)=="forest")||(GetStringLeft(GetTag(oArea),5)=="hills")||(GetStringLeft(GetTag(oArea),5)=="rural")||(GetStringLeft(GetTag(oArea),5)=="plain")||(GetStringLeft(GetTag(oArea),5)=="river")))||
        ((iCartographer>=2)&&((GetStringLeft(GetTag(oArea),9)=="foothills")||(GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),4)=="moon")||(GetStringLeft(GetTag(oArea),6)=="mounts")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")||(GetStringLeft(GetTag(oArea),8)=="tropical")))||
        ((iCartographer>=3)&&((GetStringLeft(GetTag(oArea),6)=="desert")||(GetStringLeft(GetTag(oArea),8)=="mountain")||(GetStringLeft(GetTag(oArea),10)=="ruralswamp")||(GetStringLeft(GetTag(oArea),8)=="seafloor")))||
        ((iCartographer>=4)&&((GetStringLeft(GetTag(oArea),6)=="frozen")||(GetStringLeft(GetTag(oArea),9)=="mountsnow")||(GetStringLeft(GetTag(oArea),5)=="ocean")||(GetStringLeft(GetTag(oArea),4)=="snow")||(GetStringLeft(GetTag(oArea),5)=="swamp")))||
        ((iCartographer>=5)&&(GetStringLeft(GetTag(oArea),3)=="gaz")))
 {
SendMessageToPC(oPC,"Planet = "+sPlanet);
SendMessageToPC(oPC,"Area = "+sArea);
 }
////////////////////////////////////////////////////////////////////////////////
}
