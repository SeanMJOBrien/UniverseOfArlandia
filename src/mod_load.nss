#include "aps_include"
#include "nwnx_sql"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
object oModule = GetModule();
int iPlayers = GetPersistentInt(oModule,"Players");
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Set up NWNX database
if(GetPersistentInt(oModule,"Tables")!=1)
{
    SQLExecDirect("CREATE TABLE pwdata (" + "player varchar(64) NOT NULL default '~'," + "tag varchar(64) NOT NULL default '~'," + "name varchar(64) NOT NULL default '~'," + "val text," + "expire int(11) default NULL," + "last timestamp NOT NULL default CURRENT_TIMESTAMP," + "PRIMARY KEY (player,tag,name)" + ")");
    SQLExecDirect("CREATE TABLE pwobjdata (" + "player varchar(64) NOT NULL default '~'," + "tag varchar(64) NOT NULL default '~'," + "name varchar(64) NOT NULL default '~'," + "val blob," + "expire int(11) default NULL," + "last timestamp NOT NULL default CURRENT_TIMESTAMP," + "PRIMARY KEY (player,tag,name)" + ")");
    SetPersistentInt(oModule,"Tables",1);
}
////////////////////////////////////////////////////////////////////////////////
// NEW try from Arvirago using new nwnx_sql
/*if(GetPersistentInt(oModule,“Tables”)!=1)
{
    if (NWNX_SQL_PrepareQuery(“CREATE TABLE pwdata (player varchar(64) NOT NULL default ‘~’, tag varchar(64) NOT NULL default ‘~’, name varchar(64) NOT NULL default ‘~’, val text, expire int(11) default NULL, last timestamp NOT NULL default CURRENT_TIMESTAMP, PRIMARY KEY (player,tag,name))”)){
NWNX_SQL_ExecutePreparedQuery();
}
    if (NWNX_SQL_PrepareQuery(“CREATE TABLE pwobjdata (player varchar(64) NOT NULL default ‘~’, tag varchar(64) NOT NULL default ‘~’, name varchar(64) NOT NULL default ‘~’, val blob, expire int(11) default NULL, last timestamp NOT NULL default CURRENT_TIMESTAMP, PRIMARY KEY (player,tag,name))”)) {
NWNX_SQL_ExecutePreparedQuery();
}
    SetPersistentInt(oModule,“Tables”,1);
}  */


////////////////////////////////////////////////////////////////////////////////
// Calendar & Reboot
string sCalendar = GetPersistentString(oModule,"Calendar");
string s1 = GetStringLeft(sCalendar,FindSubString(sCalendar,"/C1/"));
string s2 = GetStringRight(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C2/")),GetStringLength(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C2/")))-FindSubString(sCalendar,"/C1/")-4);
string s3 = GetStringRight(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C3/")),GetStringLength(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C3/")))-FindSubString(sCalendar,"/C2/")-4);
string s4 = GetStringRight(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C4/")),GetStringLength(GetStringLeft(sCalendar,FindSubString(sCalendar,"/C4/")))-FindSubString(sCalendar,"/C3/")-4);
SetCalendar(StringToInt(s1),StringToInt(s2),StringToInt(s3));SetTime(StringToInt(s4),0,0,0);SetLocalInt(oModule,"Hour",StringToInt(s4));
//
SetPersistentString(oModule,"Reboot","0&&&"+IntToString((iReboot*720)/12));
////////////////////////////////////////////////////////////////////////////////
// Crafting
SetLocalInt(oModule,"CraftIni",1);ExecuteScript("crafting",oModule);
////////////////////////////////////////////////////////////////////////////////
// Max henchmen
SetMaxHenchmen(iMaxHenchs);
////////////////////////////////////////////////////////////////////////////////
// Sounds
ExecuteScript("sound_ini",oModule);
////////////////////////////////////////////////////////////////////////////////
// Website
while(iPlayers>0){DeletePersistentVariable(oModule,"Player"+IntToString(iPlayers));iPlayers--;}DeletePersistentVariable(oModule,"Players");
////////////////////////////////////////////////////////////////////////////////
// Universe
ExecuteScript("_galaxy",oModule);
////////////////////////////////////////////////////////////////////////////////
}
