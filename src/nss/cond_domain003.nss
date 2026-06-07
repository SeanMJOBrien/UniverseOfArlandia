////////////////////////////////////////////////////////////////////////////////
int StartingConditional(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oItem = GetFirstItemInInventory(oPC);
////////////////////////////////////////////////////////////////////////////////
string sDomainRes = GetLocalString(oArea,"Domain_Res");
//
string sRes1 = GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_001_"));
string sRes2 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_002_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_002_")))-FindSubString(sDomainRes,"_001_")-5);
string sRes3 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_003_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_003_")))-FindSubString(sDomainRes,"_002_")-5);
string sRes4 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_004_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_004_")))-FindSubString(sDomainRes,"_003_")-5);
string sRes5 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_005_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_005_")))-FindSubString(sDomainRes,"_004_")-5);
string sRes6 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_006_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_006_")))-FindSubString(sDomainRes,"_005_")-5);
string sRes7 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_007_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_007_")))-FindSubString(sDomainRes,"_006_")-5);
string sRes8 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_008_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_008_")))-FindSubString(sDomainRes,"_007_")-5);
string sRes9 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_009_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_009_")))-FindSubString(sDomainRes,"_008_")-5);
string sRes10 = GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_010_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_010_")))-FindSubString(sDomainRes,"_009_")-5);
//
int iRes1 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_011_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_011_")))-FindSubString(sDomainRes,"_010_")-5));
int iRes2 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_012_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_012_")))-FindSubString(sDomainRes,"_011_")-5));
int iRes3 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_013_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_013_")))-FindSubString(sDomainRes,"_012_")-5));
int iRes4 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_014_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_014_")))-FindSubString(sDomainRes,"_013_")-5));
int iRes5 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_015_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_015_")))-FindSubString(sDomainRes,"_014_")-5));
int iRes6 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_016_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_016_")))-FindSubString(sDomainRes,"_015_")-5));
int iRes7 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_017_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_017_")))-FindSubString(sDomainRes,"_016_")-5));
int iRes8 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_018_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_018_")))-FindSubString(sDomainRes,"_017_")-5));
int iRes9 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_019_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_019_")))-FindSubString(sDomainRes,"_018_")-5));
int iRes10 = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_020_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_020_")))-FindSubString(sDomainRes,"_019_")-5));
//
int iGold = StringToInt(GetStringRight(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_021_")),GetStringLength(GetStringLeft(sDomainRes,FindSubString(sDomainRes,"_021_")))-FindSubString(sDomainRes,"_020_")-5));
////////////////////////////////////////////////////////////////////////////////
while(GetIsObjectValid(oItem))
 {
     if(GetTag(oItem)==sRes1){iRes1--;}
else if(GetTag(oItem)==sRes2){iRes2--;}
else if(GetTag(oItem)==sRes3){iRes3--;}
else if(GetTag(oItem)==sRes4){iRes4--;}
else if(GetTag(oItem)==sRes5){iRes5--;}
else if(GetTag(oItem)==sRes6){iRes6--;}
else if(GetTag(oItem)==sRes7){iRes7--;}
else if(GetTag(oItem)==sRes8){iRes8--;}
else if(GetTag(oItem)==sRes9){iRes9--;}
else if(GetTag(oItem)==sRes10){iRes10--;}
oItem = GetNextItemInInventory(oPC);
 }
////////////////////////////////////////////////////////////////////////////////
if(((iRes1<=0)&&(iRes2<=0)&&(iRes3<=0)&&(iRes4<=0)&&(iRes5<=0)&&(iRes6<=0)&&(iRes7<=0)&&(iRes8<=0)&&(iRes9<=0)&&(iRes10<=0)&&(GetGold(oPC)>=iGold))||(GetIsDM(oPC))){return TRUE;}else{return FALSE;}
////////////////////////////////////////////////////////////////////////////////
}
