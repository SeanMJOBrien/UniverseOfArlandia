#include "dmfi_dmw_inc"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep));
string sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iChoice));
int MissionType1 = GetLocalInt(oModule,"MissionType1");
int MissionType2 = GetLocalInt(oModule,"MissionType2");
int MissionType3 = GetLocalInt(oModule,"MissionType3");
int MissionType4 = GetLocalInt(oModule,"MissionType4");
int MissionType5 = GetLocalInt(oModule,"MissionType5");
////////////////////////////////////////////////////////////////////////////////
int iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
string sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
string sProvArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&003&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&003&")))-FindSubString(sMission,"&002&")-5);
string sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
string sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);
string sTag = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&006&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&006&")))-FindSubString(sMission,"&005&")-5);
int iNumber = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&007&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&007&")))-FindSubString(sMission,"&006&")-5));
int iXP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&008&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&008&")))-FindSubString(sMission,"&007&")-5));
int iGP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&009&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&009&")))-FindSubString(sMission,"&008&")-5));
int iDist = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&010&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&010&")))-FindSubString(sMission,"&009&")-5));
string sTitle = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&011&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&011&")))-FindSubString(sMission,"&010&")-5);
string sDes = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&012&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&012&")))-FindSubString(sMission,"&011&")-5);
//
if((iType>=MissionType1+1)&&(iType<=MissionType2)){sMissArea = sProvArea;}
//
string sState;object oItems;int i=0;int j=0;
////////////////////////////////////////////////////////////////////////////////
// Take back items
if((iType>=1)&&(iType<=MissionType1))
   {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
    {
if(GetLocalString(oItems,"Var")==sMission){i=1;break;}
oItems = GetNextItemInInventory(oPC);
    }
   }
////////////////////////////////////////////////////////////////////////////////
// Find resources
else if((iType>=MissionType1+1)&&(iType<=MissionType2))
   {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
    {
if(GetResRef(oItems)==sBP){j++;}
oItems = GetNextItemInInventory(oPC);
    }
if(j>=iNumber){i=1;}
   }
////////////////////////////////////////////////////////////////////////////////
// Bring note
else if((iType>=MissionType2+1)&&(iType<=MissionType3))
   {
if(sMissArea==sArea){i=1;}
   }
////////////////////////////////////////////////////////////////////////////////
// Take back creature
else if((iType>=MissionType3+1)&&(iType<=MissionType4))
   {
if(GetLocalInt(oGoldbag,"MissionSuccess"+IntToString(iChoice))==2)
    {
i=2;
    }
else
    {
while(j<GetMaxHenchmen())
     {
j++;
oItems = GetHenchman(oPC,j);
if((GetResRef(oItems)==sBP)&&(GetLocalInt(oItems,"Mission")==iChoice)){i=1;break;}
     }
    }
   }
////////////////////////////////////////////////////////////////////////////////
// Kill monster
else if((iType>=MissionType4+1)&&(iType<=MissionType5))
   {
oItems = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItems))
    {
if(GetLocalString(oItems,"Var")==sMission){i=1;break;}
oItems = GetNextItemInInventory(oPC);
    }
   }
////////////////////////////////////////////////////////////////////////////////
if(i==2){sState = ColorText("Failed\n","r");}else if(i==1){sState = ColorText("Completed\n","g");}else{sState = ColorText("Pending\n","y");}
////////////////////////////////////////////////////////////////////////////////
SetCustomToken(10161,ColorText(sMissPlanet,"c"));
SetCustomToken(10162,ColorText(sProvArea,"c"));
SetCustomToken(10163,ColorText(sMissArea,"c"));
SetCustomToken(10164,ColorText(IntToString(iNumber),"c"));
SetCustomToken(10165,ColorText(IntToString(iXP),"c"));
SetCustomToken(10166,ColorText(IntToString(iGP),"c"));
SetCustomToken(10167,ColorText(IntToString(iDist),"c"));
SetCustomToken(10168,ColorText(sTitle,"c"));
SetCustomToken(10169,ColorText(sDes,"c"));
SetCustomToken(10170,sState);
////////////////////////////////////////////////////////////////////////////////
}
