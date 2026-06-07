#include "dmfi_dmw_inc"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
//
string sCR1;string sCR2;string sTag1;string sTag2;string sTag1b;string sName;string sName1;string sName2;string sResult;string sDC;string sXP;string sCraft;string sBP;int i1;int i;int j;int k;string sMiddle;string sEnd;string sCraftType;string sClassBonus;
int iResultPerPage = 20;
////////////////////////////////////////////////////////////////////////////////
while(i<iResultPerPage){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);SetCustomToken(10170+i,"");SetCustomToken(10180+i,"");}i=0;
////////////////////////////////////////////////////////////////////////////////
// Resources
if(iChoice1==1)
 {
while(i<iResultPerPage)
  {
i++;
sCR1 = GetLocalString(oModule,"CR_"+IntToString(i+((iStep-1)*iResultPerPage)));
sTag1 = GetStringLeft(sCR1,FindSubString(sCR1,"&1&"));
sName1 = GetStringRight(sCR1,GetStringLength(sCR1)-FindSubString(sCR1,"&1&")-3);

if(sName1!="")
   {
SetCustomToken(10310+i,sName1);
k=0;sResult = "";

while(k<4)
    {
k++;
sTag1 = GetStringLeft(sCR1,FindSubString(sCR1,"&1&"));
sName1 = GetStringRight(sCR1,GetStringLength(sCR1)-FindSubString(sCR1,"&1&")-3);
if(k>1){sTag1 = IntToString(k)+sTag1;}
if(GetStringLeft(sTag1,1)=="2"){sName1 = "Improved "+sName1;}else if(GetStringLeft(sTag1,1)=="3"){sName1 = "Quality "+sName1;}else if(GetStringLeft(sTag1,1)=="4"){sName1 = "Precious "+sName1;}
i1 = GetLocalInt(oModule,"CR_"+sTag1);
j=0;

while(j<i1)
     {
j++;
sMiddle = "";sEnd = "";
sCR2 = GetLocalString(oModule,sTag1+"CR_"+IntToString(j));
sTag2 = GetStringLeft(sCR2,FindSubString(sCR2,"&A&"));
sName2 = GetStringRight(sCR2,GetStringLength(sCR2)-FindSubString(sCR2,"&A&")-3);
if(GetStringLeft(sTag2,1)=="2"){sName2 = "Improved "+sName2;}else if(GetStringLeft(sTag2,1)=="3"){sName2 = "Quality "+sName2;}else if(GetStringLeft(sTag2,1)=="4"){sName2 = "Precious "+sName2;}
sCR2 = GetLocalString(oModule,sTag1+"&CR&"+sTag2);
sBP = GetStringLeft(sCR2,FindSubString(sCR2,"&A&"));
sName = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&B&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&B&")))-FindSubString(sCR2,"&A&")-3);
sDC = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&E&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&E&")))-FindSubString(sCR2,"&D&")-3);
sCraftType = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&G&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&G&")))-FindSubString(sCR2,"&F&")-3);
sClassBonus = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&H&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&H&")))-FindSubString(sCR2,"&G&")-3);
sCraft = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&I&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&I&")))-FindSubString(sCR2,"&H&")-3);
if(sCraftType=="1"){sCraftType = "Armor";}else if(sCraftType=="2"){sCraftType = "Trap";}else if(sCraftType=="3"){sCraftType = "Weapon";}else if(sCraftType=="4"){sCraftType = "All";}if(sClassBonus=="1"){sClassBonus = "Barbarian";}else if(sClassBonus=="2"){sClassBonus = "Bard";}else if(sClassBonus=="3"){sClassBonus = "Cleric";}else if(sClassBonus=="4"){sClassBonus = "Druid";}else if(sClassBonus=="5"){sClassBonus = "Fighter";}else if(sClassBonus=="6"){sClassBonus = "Monk";}else if(sClassBonus=="7"){sClassBonus = "Paladin";}else if(sClassBonus=="8"){sClassBonus = "Ranger";}else if(sClassBonus=="9"){sClassBonus = "Rogue";}else if(sClassBonus=="10"){sClassBonus = "Sorceror";}else if(sClassBonus=="11"){sClassBonus = "Wizard";}else{sClassBonus = "None";}

if(sTag2!=""){sMiddle = " + "+ColorText(sName2,"y");}
if((GetStringLeft(sBP,1)!="a")&&(GetStringLeft(sBP,1)!="b")&&(GetStringLeft(sBP,1)!="c")&&(GetStringLeft(sBP,1)!="d")&&(GetStringLeft(sBP,1)!="e")&&(GetStringLeft(sBP,1)!="f")&&(GetStringLeft(sBP,1)!="g")&&(GetStringLeft(sBP,1)!="h")&&(GetStringLeft(sBP,1)!="i")&&(GetStringLeft(sBP,1)!="j")&&(GetStringLeft(sBP,1)!="k")&&(GetStringLeft(sBP,1)!="l")&&(GetStringLeft(sBP,1)!="m")&&(GetStringLeft(sBP,1)!="n")&&(GetStringLeft(sBP,1)!="o")&&(GetStringLeft(sBP,1)!="p")&&(GetStringLeft(sBP,1)!="q")&&(GetStringLeft(sBP,1)!="r")&&(GetStringLeft(sBP,1)!="s")&&(GetStringLeft(sBP,1)!="t")&&(GetStringLeft(sBP,1)!="u")&&(GetStringLeft(sBP,1)!="v")&&(GetStringLeft(sBP,1)!="w")&&(GetStringLeft(sBP,1)!="x")&&(GetStringLeft(sBP,1)!="y")&&(GetStringLeft(sBP,1)!="z")){sEnd = ColorText(sBP,"g");}else{sEnd = ColorText(sName,"g");}
sEnd = sEnd+"\n"+ColorText("(DC = "+sDC+" / Type = "+sCraftType+" / Class = "+sClassBonus+" / Feat = "+sCraft+")","c");

sResult = sResult+ColorText(sName1,"y")+sMiddle+" = "+sEnd+"\n";
     }
    }
if(sResult==""){sResult = "no combination";}SetCustomToken(10330+i,sResult);
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Results
else if(iChoice1==2)
 {
while(i<iResultPerPage)
  {
i++;
sName = GetLocalString(oModule,"CRI"+IntToString(i+((iStep-1)*iResultPerPage)));

if(sName!="")
   {
SetCustomToken(10310+i,sName);
i1 = GetLocalInt(oModule,"CRI_"+sName);
j=0;sResult = "";

while(j<i1)
    {
j++;
sMiddle = "";sEnd = "";
sCR2 = GetLocalString(oModule,sName+"CRI"+IntToString(j));
sName1 = GetStringLeft(sCR2,FindSubString(sCR2,"&A&"));
sName2 = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&B&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&B&")))-FindSubString(sCR2,"&A&")-3);
sDC = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&E&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&E&")))-FindSubString(sCR2,"&D&")-3);
sCraftType = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&G&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&G&")))-FindSubString(sCR2,"&F&")-3);
sClassBonus = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&H&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&H&")))-FindSubString(sCR2,"&G&")-3);
sCraft = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&I&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&I&")))-FindSubString(sCR2,"&H&")-3);
sBP = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&J&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&J&")))-FindSubString(sCR2,"&I&")-3);
sTag1 = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&K&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&K&")))-FindSubString(sCR2,"&J&")-3);
sTag2 = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&L&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&L&")))-FindSubString(sCR2,"&K&")-3);
if(GetStringLeft(sTag1,1)=="2"){sName1 = "Improved "+sName1;}else if(GetStringLeft(sTag1,1)=="3"){sName1 = "Quality "+sName1;}else if(GetStringLeft(sTag1,1)=="4"){sName1 = "Precious "+sName1;}
if(GetStringLeft(sTag2,1)=="2"){sName2 = "Improved "+sName2;}else if(GetStringLeft(sTag2,1)=="3"){sName2 = "Quality "+sName2;}else if(GetStringLeft(sTag2,1)=="4"){sName2 = "Precious "+sName2;}
if(sCraftType=="1"){sCraftType = "Armor";}else if(sCraftType=="2"){sCraftType = "Trap";}else if(sCraftType=="3"){sCraftType = "Weapon";}else if(sCraftType=="4"){sCraftType = "All";}if(sClassBonus=="1"){sClassBonus = "Barbarian";}else if(sClassBonus=="2"){sClassBonus = "Bard";}else if(sClassBonus=="3"){sClassBonus = "Cleric";}else if(sClassBonus=="4"){sClassBonus = "Druid";}else if(sClassBonus=="5"){sClassBonus = "Fighter";}else if(sClassBonus=="6"){sClassBonus = "Monk";}else if(sClassBonus=="7"){sClassBonus = "Paladin";}else if(sClassBonus=="8"){sClassBonus = "Ranger";}else if(sClassBonus=="9"){sClassBonus = "Rogue";}else if(sClassBonus=="10"){sClassBonus = "Sorceror";}else if(sClassBonus=="11"){sClassBonus = "Wizard";}else{sClassBonus = "None";}

if(sName2!=""){sMiddle = " + "+ColorText(sName2,"y");}
if((GetStringLeft(sBP,1)!="a")&&(GetStringLeft(sBP,1)!="b")&&(GetStringLeft(sBP,1)!="c")&&(GetStringLeft(sBP,1)!="d")&&(GetStringLeft(sBP,1)!="e")&&(GetStringLeft(sBP,1)!="f")&&(GetStringLeft(sBP,1)!="g")&&(GetStringLeft(sBP,1)!="h")&&(GetStringLeft(sBP,1)!="i")&&(GetStringLeft(sBP,1)!="j")&&(GetStringLeft(sBP,1)!="k")&&(GetStringLeft(sBP,1)!="l")&&(GetStringLeft(sBP,1)!="m")&&(GetStringLeft(sBP,1)!="n")&&(GetStringLeft(sBP,1)!="o")&&(GetStringLeft(sBP,1)!="p")&&(GetStringLeft(sBP,1)!="q")&&(GetStringLeft(sBP,1)!="r")&&(GetStringLeft(sBP,1)!="s")&&(GetStringLeft(sBP,1)!="t")&&(GetStringLeft(sBP,1)!="u")&&(GetStringLeft(sBP,1)!="v")&&(GetStringLeft(sBP,1)!="w")&&(GetStringLeft(sBP,1)!="x")&&(GetStringLeft(sBP,1)!="y")&&(GetStringLeft(sBP,1)!="z")){sEnd = ColorText(sBP,"g");}else{sEnd = ColorText(sName,"g");}
sMiddle = sMiddle+"\n"+ColorText("(DC = "+sDC+" / Type = "+sCraftType+" / Class = "+sClassBonus+" / Feat = "+sCraft+")","c");
sResult = sResult+sEnd+" = "+ColorText(sName1,"y")+sMiddle+"\n";
    }
if(sResult==""){sResult = "no combination";}SetCustomToken(10330+i,sResult);
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
