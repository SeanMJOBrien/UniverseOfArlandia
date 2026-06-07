#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oBox = GetLocalObject(oArea,"Mailbox");
int iLevel = GetLocalInt(oBox,"Level");
//
string sTot = GetPersistentString(oModule,sPlanet);
int iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5));
int jTot = StringToInt(GetLocalString(oModule,"Systems"));
//
string sSystem;int iTot;int iXP;int iYP;int iXA;int iYA;int i;int j;int k;
string sDestX;string sDestY;string sPlanetDest;string sAreaDest;string sInterest;string sName;string sVar;string sVisible;string sVar8;string sVar8R;
////////////////////////////////////////////////////////////////////////////////
iYP=0;
while(iYP<jTot)
 {
iYP++;
sSystem = GetLocalString(oModule,"System"+IntToString(iYP));
//
if(sSystem!="")
  {
iTot = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
iXP=0;
//
while(iXP<iTot)
   {
iXP++;
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(iXP));
sPlanetDest = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&003&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&003&")))-FindSubString(sTot,"&002&")-5));

iXA = -(iPlanetSize/2);
while(iXA<=(iPlanetSize/2))
    {
iYA = -(iPlanetSize/2);
while(iYA<=(iPlanetSize/2))
     {
sDestX = IntToString(iXA);if(iXA<0){sDestX = "m"+GetStringRight(IntToString(iXA),GetStringLength(IntToString(iXA))-1);}
sDestY = IntToString(iYA);if(iYA<0){sDestY = "m"+GetStringRight(IntToString(iYA),GetStringLength(IntToString(iYA))-1);}
sAreaDest = sDestX+"_"+sDestY;
sInterest = GetPersistentString(oModule,sPlanetDest+"&"+sAreaDest+"&Interests");
sName = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")))-FindSubString(sInterest,"&1&")-3);
sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
sVar8 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_08_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_08_")))-FindSubString(sVar,"_07_")-4);
sVar8R = GetStringRight(sVar8,GetStringLength(sVar8)-FindSubString(sVar8,"%")-1);
sVisible = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")))-FindSubString(sInterest,"&3&")-3);

if((GetStringLeft(sInterest,1)=="D")&&(StringToInt(sVar8R)>=3)&&(sVisible=="1"))
      {
if(((sPlanetDest==sPlanet)&&(sAreaDest==sArea))||((sPlanetDest!=sPlanet)&&(iLevel<5))){}
else
       {
k++;
SetLocalString(OBJECT_SELF,"MailPlanet"+IntToString(k),sPlanetDest);
SetLocalString(OBJECT_SELF,"MailArea"+IntToString(k),sAreaDest);
SetLocalString(OBJECT_SELF,"MailName"+IntToString(k),sName);
       }
      }
iYA++;
     }
iXA++;
    }
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
