int StartingConditional()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
object oItems = GetFirstItemInInventory(oPC);
int iPrice;

     if(iChoice1==1) {iPrice = 20;}
else if(iChoice1==2) {iPrice = 30;}
else if(iChoice1==3) {iPrice = 10;}
else if(iChoice1==4) {iPrice = 420;}
else if(iChoice1==5) {iPrice = 10;}
else if(iChoice1==6) {while(GetIsObjectValid(oItems)){if(GetTag(oItems)=="cr_plantcommon"){iPrice++;}oItems = GetNextItemInInventory(oPC);}if(iPrice>=4){iPrice = 0;}else{iPrice = iGold+1;}}
else if(iChoice1==7) {iPrice = 40;}
else if(iChoice1==8) {iPrice = 20;}
else if(iChoice1==9) {iPrice = 3;}
else if(iChoice1==10){iPrice = 6;}
else if(iChoice1==11){iPrice = 10;}
else if(iChoice1==12){iPrice = 10;}
else if(iChoice1==13){iPrice = 10;}
else if(iChoice1==14){iPrice = 10;}
else if(iChoice1==15){iPrice = 20;}
else if(iChoice1==16){iPrice = 15;}
else if(iChoice1==17){iPrice = 55;}
else if(iChoice1==18){iPrice = 60;}
else if(iChoice1==19){iPrice = 30;}
else if(iChoice1==20){iPrice = 20;}

if(iGold>=iPrice){return TRUE;}else{return FALSE;}
}
