#include "aps_include"

////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");if(GetStringRight(sArea,5)=="_Ship"){sArea = GetStringLeft(sArea,GetStringLength(sArea)-5);}
string sTot = GetPersistentString(oModule,sPlanet);
string sAmbiance = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&006&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&006&")))-FindSubString(sTot,"&005&")-5);
string sTotLeft = GetStringLeft(sTot,FindSubString(sTot,"&010&"));
object oStormSound = GetObjectByTag("snd_thunder_"+GetTag(OBJECT_SELF));
//
string sCalendar = GetPersistentString(oModule,"Calendar");
string sMonth = GetStringRight(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C2/")),GetStringLength(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C2/")))-FindSubString(sCalendar,"/C1/")-4);
//
int iAreaIni = GetLocalInt(OBJECT_SELF,"AreaIni");
int iPlanetTime = GetLocalInt(oModule,sPlanet+"&Time");
int iNewWeather = GetLocalInt(OBJECT_SELF,"NewWeather");
int iSkyBox;int iFogColorDay;int iFogColorMoon;int iFogAmount;int iMusicBattle;int iMusicBackgroundDay;int iMusicBackgroundNight;int iWeather;string sWeatherTot;string s1;string s2;string s3;string s4;string s5;int i1;int i2;int i3;int i4;int i5;
int WEATHER_FOG = 3;int WEATHER_STORM = 4;int WEATHER_RANDOM = 5;int iRandom1;
////////////////////////////////////////////////////////////////////////////////
// Save original ambiance
if(iAreaIni!=1)
 {
SetLocalInt(OBJECT_SELF,"DefaultSkyBox",GetSkyBox(OBJECT_SELF));
SetLocalInt(OBJECT_SELF,"DefaultFogColorDay",GetFogColor(FOG_TYPE_SUN,OBJECT_SELF));
SetLocalInt(OBJECT_SELF,"DefaultFogColorNight",GetFogColor(FOG_TYPE_MOON,OBJECT_SELF));
SetLocalInt(OBJECT_SELF,"DefaultFogAmount",GetFogAmount(FOG_TYPE_ALL,OBJECT_SELF));
SetLocalInt(OBJECT_SELF,"DefaultMusicBattle",MusicBackgroundGetBattleTrack(OBJECT_SELF));
SetLocalInt(OBJECT_SELF,"DefaultMusicDay",MusicBackgroundGetDayTrack(OBJECT_SELF));
SetLocalInt(OBJECT_SELF,"DefaultMusicNight",MusicBackgroundGetNightTrack(OBJECT_SELF));
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
if((sAmbiance!="default")&&(sAmbiance!=""))
 {
////////////////////////////////////////////////////////////////////////////////
/* Skyboxes
30  LOK_Storm
31  TROD_Clear
32  TROD_Coastal
33  TROD_Overcast
34  TROD_Vale
35  CTP_Hells_Fire
36  CTP_Galaxy
37  CTP_Heavens
38  CTP_Purple_Dawn
39  CTP_Bright_Moon
40  CTP_Hazy_Ocean
41  CTP_Cirrus
42  CTP_White_Cloud
43  CTP_Und_Water
44  Skanzo_Daylight
45  Knat_Red_Sky
46  Myth_Drannor
47  Astral_Plane
48  Green_Canopy
49  NS_Underdark
50  NS_Forest
51  NS_Canyon
52  NS_Thunderstorm
53  NS_Ash_Wasteland
54  NS_Volcano_Heart
55  NS_Mountain_Peak
56  NS_Planer_Outlands
57  NS_Ice_Cavern
58  NS_Sea_Floor
59  NS_Hills
60  NS_Jungle_ruins
61  PS_Desert
62  PS_Oceans
63  PS_Mountains
64  PS_Grasslands
65  Doyle_Clear1
66  Doyle_Clear2
67  Doyle_Cloudy
68  Doyle_Stormy
69  Mohss_Clear
70  Mohss_Overcast
71  Mohss_Thunder
72  CCS_Plateau
73  CCS_Deep_Valley
74  CCS_Clear
75  CCS_Plateau_grey
76  CCS_Space
77  Dem_st_dwn_dusk
78  Dem_PC_ms
79  Dem_st_dwn
80  Dem_st_dusk
81  Dem_PC_dwn
82  Dem_PC_dusk
83  Celios_Day_Night
84  pceb_all
*/
////////////////////////////////////////////////////////////////////////////////
if(sAmbiance=="self"){sAmbiance = sPlanet;}
////////////////////////////////////////////////////////////////////////////////
if(sAmbiance=="Arland")
  {
iSkyBox =               74;
iFogColorDay =          0x687E91;
iFogColorMoon =         FOG_COLOR_BLUE_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_RURAL1;
iMusicBackgroundDay =   TRACK_RURALDAY1;
iMusicBackgroundNight = TRACK_RURALNIGHT;
iWeather =              92011; //Clear,Rain,Fog,Storm,Snow
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Astdin")
  {
iSkyBox =               74;
iFogColorDay =          0x687E91;
iFogColorMoon =         FOG_COLOR_BLUE_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_CITY1;
iMusicBackgroundDay =   TRACK_RURALDAY2;
iMusicBackgroundNight = TRACK_RURALNIGHT;
iWeather =              51010; //Clear,Rain,Fog,Storm,Snow
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Brillar")
  {
iSkyBox =               53;
iFogColorDay =          FOG_COLOR_YELLOW_DARK;
iFogColorMoon =         FOG_COLOR_YELLOW_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_ENDBOSS;
iMusicBackgroundDay =   TRACK_HOTU_FIREPLANE;
iMusicBackgroundNight = TRACK_HOTU_HELLFROZEOVER;
iWeather =              WEATHER_CLEAR;
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Delendil")
  {
iSkyBox =               41;
iFogColorDay =          FOG_COLOR_CYAN;
iFogColorMoon =         FOG_COLOR_BLUE_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_FOREST2;
iMusicBackgroundDay =   TRACK_DESERT_DAY;
iMusicBackgroundNight = TRACK_DESERT_NIGHT;
iWeather =              91000; //Clear,Rain,Fog,Storm,Snow
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Galaxia")
  {
iSkyBox =               59;
iFogColorDay =          FOG_COLOR_GREEN_DARK;
iFogColorMoon =         FOG_COLOR_GREEN_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_WINTER;
iMusicBackgroundDay =   TRACK_RURALDAY2;
iMusicBackgroundNight = TRACK_MINES2;
iWeather =              63111; //Clear,Rain,Fog,Storm,Snow
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Hinz")
  {
iSkyBox =               SKYBOX_ICY;
iFogColorDay =          FOG_COLOR_WHITE;
iFogColorMoon =         FOG_COLOR_GREY;
iFogAmount =            20;
iMusicBattle =          TRACK_BATTLE_WINTER;
iMusicBackgroundDay =   TRACK_WINTER_DAY;
iMusicBackgroundNight = TRACK_WINTER_DAY;
iWeather =              WEATHER_SNOW;
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Kartac")
  {
iSkyBox =               74;
iFogColorDay =          0x687E91;
iFogColorMoon =         FOG_COLOR_BLUE_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_FOREST1;
iMusicBackgroundDay =   TRACK_FORESTDAY1;
iMusicBackgroundNight = TRACK_FORESTNIGHT;
iWeather =              62111; //Clear,Rain,Fog,Storm,Snow
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Khanyo")
  {
iSkyBox =               62;
iFogColorDay =          0x687E91;
iFogColorMoon =         FOG_COLOR_BLUE_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_ARIBETH;
iMusicBackgroundDay =   TRACK_WINTER_DAY;
iMusicBackgroundNight = TRACK_WINTER_DAY;
iWeather =              WEATHER_CLEAR;
  }
////////////////////////////////////////////////////////////////////////////////
else if((sAmbiance=="Mo1")||(sAmbiance=="Mo2")||(sAmbiance=="Mo3")||(sAmbiance=="Otun")||(sAmbiance=="Ronde")||(sAmbiance=="Sand"))
  {
iSkyBox =               76;
iFogColorDay =          FOG_COLOR_BLACK;
iFogColorMoon =         FOG_COLOR_BLACK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_RURAL1;
iMusicBackgroundDay =   TRACK_THEME_CHAPTER3;
iMusicBackgroundNight = TRACK_THEME_CHAPTER3;
iWeather =              WEATHER_CLEAR;
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Ozgurbur")
  {
iSkyBox =               SKYBOX_DESERT_CLEAR;
iFogColorDay =          FOG_COLOR_WHITE;
iFogColorMoon =         FOG_COLOR_GREY;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_DESERT;
iMusicBackgroundDay =   TRACK_DESERT_DAY;
iMusicBackgroundNight = TRACK_DESERT_NIGHT;
iWeather =              WEATHER_FOG;
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Tend")
  {
iSkyBox =               74;
iFogColorDay =          FOG_COLOR_BLUE;
iFogColorMoon =         FOG_COLOR_BLUE_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_FOREST1;
iMusicBackgroundDay =   TRACK_CITYWEALTHY;
iMusicBackgroundNight = TRACK_CITYNIGHT;
iWeather =              62011; //Clear,Rain,Fog,Storm,Snow
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Terlation")
  {
iSkyBox =               SKYBOX_DESERT_CLEAR;
iFogColorDay =          0x687E91;
iFogColorMoon =         FOG_COLOR_BLACK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_DESERT;
iMusicBackgroundDay =   TRACK_DESERT_DAY;
iMusicBackgroundNight = TRACK_DESERT_NIGHT;
iWeather =              WEATHER_CLEAR;
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Washisch")
  {
iSkyBox =               SKYBOX_WINTER_CLEAR;
iFogColorDay =          FOG_COLOR_WHITE;
iFogColorMoon =         FOG_COLOR_BLACK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_WINTER;
iMusicBackgroundDay =   TRACK_WINTER_DAY;
iMusicBackgroundNight = TRACK_THEME_NWN;
iWeather =              WEATHER_CLEAR;
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="Wyderl")
  {
iSkyBox =               53;
iFogColorDay =          FOG_COLOR_MAGENTA;
iFogColorMoon =         FOG_COLOR_MAGENTA;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_ENDBOSS;
iMusicBackgroundDay =   TRACK_HOTU_FIREPLANE;
iMusicBackgroundNight = TRACK_HOTU_HELLFROZEOVER;
iWeather =              WEATHER_STORM;
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAmbiance=="amb_demonia")
  {
iSkyBox =               53;
iFogColorDay =          FOG_COLOR_RED;
iFogColorMoon =         FOG_COLOR_RED_DARK;
iFogAmount =            0;
iMusicBattle =          TRACK_BATTLE_ENDBOSS;
iMusicBackgroundDay =   TRACK_HOTU_FIREPLANE;
iMusicBackgroundNight = TRACK_HOTU_HELLFROZEOVER;
iWeather =              WEATHER_CLEAR;
  }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
MusicBattleChange(OBJECT_SELF,iMusicBattle);
MusicBackgroundChangeDay(OBJECT_SELF,iMusicBackgroundDay);
MusicBackgroundChangeNight(OBJECT_SELF,iMusicBackgroundNight);
////////////////////////////////////////////////////////////////////////////////
// DM weather
if(iNewWeather>0)
  {
     if(iNewWeather==1){iWeather = WEATHER_CLEAR;}
else if(iNewWeather==2){iWeather = WEATHER_FOG;}
else if(iNewWeather==3){iWeather = WEATHER_RAIN;}
else if(iNewWeather==4){iWeather = WEATHER_SNOW;}
else if(iNewWeather==5){iWeather = WEATHER_STORM;}

SetLocalInt(oModule,sPlanet+"&Weather",iWeather);
  }

// Areas weather
else
  {
if(((GetIsDay())&&(iPlanetTime!=1))||((GetIsNight())&&(iPlanetTime!=2)))
   {
if(iWeather==WEATHER_RANDOM)
    {
iRandom1 = Random(10)+1;
     if(iRandom1<6) {iWeather = WEATHER_CLEAR;}
else if(iRandom1<8) {iWeather = WEATHER_RAIN;}
else if(iRandom1<9) {iWeather = WEATHER_FOG;}
else if(iRandom1<10){iWeather = WEATHER_STORM;}
else                {iWeather = WEATHER_SNOW;}
    }
else if(iWeather>10)
    {
sWeatherTot = IntToString(iWeather);
s1 = GetStringLeft(sWeatherTot,1);i1 = StringToInt(s1);
s2 = GetStringRight(GetStringLeft(sWeatherTot,2),1);i2 = StringToInt(s2);
s3 = GetStringRight(GetStringLeft(sWeatherTot,3),1);i3 = StringToInt(s3);
s4 = GetStringLeft(GetStringRight(sWeatherTot,2),1);i4 = StringToInt(s4);
s5 = GetStringRight(sWeatherTot,1);i5 = StringToInt(s5);
//
if((i1!=0)&&(StringToInt(sMonth)>=5)&&(StringToInt(sMonth)<=9)){i1 = i1+3;i3 = 0;i5 = 0;}
if((i2!=0)&&(StringToInt(sMonth)>=10)&&(StringToInt(sMonth)<=12)){i2 = i2+3;}
if((i3!=0)&&(StringToInt(sMonth)>=11)&&(StringToInt(sMonth)<=12)){i3 = i3+3;}
if((i4!=0)&&(StringToInt(sMonth)>=7)&&(StringToInt(sMonth)<=8)){i4 = i4+3;}
if((i5!=0)&&(StringToInt(sMonth)>=12)&&(StringToInt(sMonth)<=3)){i5 = i5+3;}
//
iRandom1 = Random(i1+i2+i3+i4+i5);
     if(iRandom1<i1)         {iWeather = WEATHER_CLEAR;}
else if(iRandom1<i1+i2)      {iWeather = WEATHER_RAIN;}
else if(iRandom1<i1+i2+i3)   {iWeather = WEATHER_FOG;}
else if(iRandom1<i1+i2+i3+i4){iWeather = WEATHER_STORM;}
else                         {iWeather = WEATHER_SNOW;}
    }
//
SetLocalInt(oModule,sPlanet+"&Weather",iWeather);
//
if(GetIsDay()){SetLocalInt(oModule,sPlanet+"&Time",1);}else{SetLocalInt(oModule,sPlanet+"&Time",2);}
   }
iWeather = GetLocalInt(oModule,sPlanet+"&Weather");
  }
////////////////////////////////////////////////////////////////////////////////
SetPersistentString(oModule,sPlanet,sTotLeft+"&010&"+IntToString(iWeather)+"&011&");
////////////////////////////////////////////////////////////////////////////////
if(iWeather==WEATHER_RAIN)
  {
SetSkyBox(SKYBOX_NONE,OBJECT_SELF);
SetFogColor(FOG_TYPE_SUN,FOG_COLOR_GREY,OBJECT_SELF);
SetFogColor(FOG_TYPE_MOON,FOG_COLOR_BLACK,OBJECT_SELF);
SetFogAmount(FOG_TYPE_ALL,10,OBJECT_SELF);
DeleteLocalInt(OBJECT_SELF,"Storm");
MusicBackgroundPlay(OBJECT_SELF);
SoundObjectStop(oStormSound);
  }
else if(iWeather==WEATHER_FOG)
  {
SetSkyBox(SKYBOX_NONE,OBJECT_SELF);
SetFogColor(FOG_TYPE_SUN,FOG_COLOR_GREY,OBJECT_SELF);
SetFogColor(FOG_TYPE_MOON,FOG_COLOR_BLACK,OBJECT_SELF);
SetFogAmount(FOG_TYPE_ALL,-1,OBJECT_SELF);
DeleteLocalInt(OBJECT_SELF,"Storm");
MusicBackgroundPlay(OBJECT_SELF);
SoundObjectStop(oStormSound);
  }
else if(iWeather==WEATHER_STORM)
  {
SetSkyBox(52,OBJECT_SELF);
SetFogColor(FOG_TYPE_SUN,FOG_COLOR_GREY,OBJECT_SELF);
SetFogColor(FOG_TYPE_MOON,FOG_COLOR_BLACK,OBJECT_SELF);
SetFogAmount(FOG_TYPE_ALL,10,OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"Storm",1);
MusicBackgroundStop(OBJECT_SELF);
iWeather = WEATHER_RAIN;
SoundObjectPlay(oStormSound);
  }
else if(iWeather==WEATHER_SNOW)
  {
SetSkyBox(SKYBOX_NONE,OBJECT_SELF);
SetFogColor(FOG_TYPE_SUN,FOG_COLOR_GREY,OBJECT_SELF);
SetFogColor(FOG_TYPE_MOON,FOG_COLOR_BLACK,OBJECT_SELF);
SetFogAmount(FOG_TYPE_ALL,20,OBJECT_SELF);
DeleteLocalInt(OBJECT_SELF,"Storm");
MusicBackgroundPlay(OBJECT_SELF);
SoundObjectStop(oStormSound);
  }
else
  {
SetSkyBox(iSkyBox,OBJECT_SELF);
SetFogColor(FOG_TYPE_SUN,iFogColorDay,OBJECT_SELF);
SetFogColor(FOG_TYPE_MOON,iFogColorMoon,OBJECT_SELF);
SetFogAmount(FOG_TYPE_ALL,iFogAmount,OBJECT_SELF);
DeleteLocalInt(OBJECT_SELF,"Storm");
MusicBackgroundPlay(OBJECT_SELF);
SoundObjectStop(oStormSound);
  }
////////////////////////////////////////////////////////////////////////////////
SetWeather(OBJECT_SELF,iWeather);
DeleteLocalInt(OBJECT_SELF,"NewWeather");
////////////////////////////////////////////////////////////////////////////////
 }
//
else{SoundObjectStop(oStormSound);}
////////////////////////////////////////////////////////////////////////////////
}
