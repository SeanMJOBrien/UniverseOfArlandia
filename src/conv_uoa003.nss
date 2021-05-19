#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLeaderTalent = GetLocalInt(oGoldbag,"Leader");
string sHench;string sName;string sStayHench;string sHenchPlanet;string sHenchArea;string s;int i;

     if(iLeaderTalent==1){iLeaderTalent = 2;}
else if(iLeaderTalent==2){iLeaderTalent = 4;}
else if(iLeaderTalent==3){iLeaderTalent = 7;}
else if(iLeaderTalent==4){iLeaderTalent = 12;}
else if(iLeaderTalent==5){iLeaderTalent = 20;}

if(iLeaderTalent>0)
 {
while((i<iMaxHenchs)&&(i<iLeaderTalent))
  {
i++;

sHench = GetLocalString(oGoldbag,IntToString(i)+"Hench");
sName = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&B&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&B&")))-FindSubString(sHench,"&A&")-3);
sStayHench = GetLocalString(oGoldbag,IntToString(i)+"StayHench");
sHenchPlanet = GetStringLeft(sStayHench,FindSubString(sStayHench,"&A&"));
sHenchArea = GetStringRight(GetStringLeft(sStayHench,FindSubString(sStayHench,"&B&")),GetStringLength(GetStringLeft(sStayHench,FindSubString(sStayHench,"&B&")))-FindSubString(sStayHench,"&A&")-3);

if(sHench!=""){if(sStayHench!=""){s = s+sName+" : "+sHenchPlanet+" - "+sHenchArea+"\n";}else{s = s+sName+" : with master"+"\n";}}
  }
FloatingTextStringOnCreature(s,oPC);
 }

else
 {
FloatingTextStringOnCreature("you need to learn the 'Leader' talent to use this option",oPC);
 }
}
