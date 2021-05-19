#include "_module"
void main()
{
object oModule = GetModule();
object oPC = GetLastUsedBy();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
float fX = 120.0;float fY = 75.0;
string sPlanetPos;string sSystem;string sTot;string sPlanetName;string sPlanetPlace;string sPlanetType;int i;int j;int k;

object oStarship = GetItemPossessedBy(oPC,"starship");if(oStarship==OBJECT_INVALID){i++;FloatingTextStringOnCreature("you need a Starship to leave this planet",oPC);}
object oToolStarship = GetItemPossessedBy(oPC,"tool_starship");if(oToolStarship==OBJECT_INVALID){i++;FloatingTextStringOnCreature("you need a Starship Tool to leave this planet",oPC);}
object oGem = GetItemPossessedBy(oPC,"cr_gem015");if(oGem==OBJECT_INVALID){i++;FloatingTextStringOnCreature("you need more Topaz to leave this planet",oPC);}
object oPass = GetItemPossessedBy(oPC,"starpass");if(oPass==OBJECT_INVALID){i++;FloatingTextStringOnCreature("you need a Star Pass to leave this planet",oPC);}

if(i==0)
 {
j = StringToInt(GetLocalString(oModule,"Systems"));
while(j>0)
  {
sSystem = GetLocalString(oModule,"System"+IntToString(j));
i = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
while(i>0)
   {
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(i));
sPlanetName = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
sPlanetPlace = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5);
sPlanetType = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&004&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&004&")))-FindSubString(sTot,"&003&")-5);

if(sPlanetName==sPlanet){k=1;break;}
i--;
   }
if(k==1){break;}
j--;
  }
if(k==1)
  {
if(GetStringLeft(sPlanetType,1)=="m"){fY = fY+20.0;}
SetLocalString(oPC,"PlanetDest","Space");
SetLocalString(oPC,"AreaDest",sPlanetPlace);
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalFloat(oPC,"fFacing",DIRECTION_SOUTH);

if(GetLocalInt(oGoldbag,"OrigApp")==0){SetLocalInt(oGoldbag,"OrigApp",GetAppearanceType(oPC)+1);}
//SetLocalObject(oPC,"DestroyIt",oGem);

ExecuteScript("transitions",oPC);
  }
 }
}
