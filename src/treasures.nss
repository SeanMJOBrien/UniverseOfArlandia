#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sTag = GetTag(OBJECT_SELF);
//
float fX = GetPosition(OBJECT_SELF).x;string sX = FloatToString(fX);
float fY = GetPosition(OBJECT_SELF).y;string sY = FloatToString(fY);
int iNumItems = GetLocalInt(oModule,sPlanet+sArea+sX+sY+"Chest");
//
string sTot = GetPersistentString(oModule,sPlanet);
int iLevel = StringToInt(GetStringRight(GetTag(OBJECT_SELF),1));
//
object oItem;int iRand1;int iRand2;int iRand3;int iRand4;int iRand5;string s;int i;
string s1;string s2;string s3;int i4;int i5;int i6;int i7;string s8;string s9;int iM;
int iConfig = GetLocalInt(OBJECT_SELF,"Config");
object oCreature = GetFirstObjectInArea(oArea);
////////////////////////////////////////////////////////////////////////////////
if(iConfig==0)
 {
while(GetIsObjectValid(oCreature))
  {
if((GetCurrentHitPoints(oCreature)>0)&&(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oCreature)>=90)){iM++;}
oCreature = GetNextObjectInArea(oArea);
  }
if(iM<iChestFull)
  {
SetLocalInt(OBJECT_SELF,"Config",1);
if(iNumItems>0)
   {
while(iNumItems>0)
    {
s1 = GetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"BP");
s2 = GetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"Tag");
s3 = GetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"Name");
i4 = GetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"Stack");
i5 = GetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"Wear");
i6 = GetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"ID");
i7 = GetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"Charges");
s8 = GetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"Bonus");
s9 = GetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(iNumItems)+"Var");

oItem = CreateItemOnObject(s1,OBJECT_SELF,i4,s2);
if(GetName(oItem)!=s3){SetName(oItem,s3);}if(FindSubString(s3,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oItem);}
SetLocalInt(oItem,"Wear",i5);
if(i7>0){SetItemCharges(oItem,i7);}
if(i6==TRUE){SetIdentified(oItem,TRUE);}
SetLocalString(oItem,"Bonus",s8);if(s8!=""){ExecuteScript("bonus",oItem);}
SetLocalString(oItem,"Var",s9);
iNumItems--;
    }
   }
////////////////////////////////////////////////////////////////////////////////
else{
////////////////////////////////////////////////////////////////////////////////
// Treasures famillies
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Level 1
////////////////////////////////////////////////////////////////////////////////
if(iLevel==1){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+9; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(71)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=2)){s = "nw_cloth024";i = 1;}
else if((iRand2>=3)&&(iRand2<=4)){s = "nw_cloth001";i = 1;}
else if((iRand2>=5)&&(iRand2<=5)){s = "cr_bottleempty";i = 1;}
else if((iRand2>=6)&&(iRand2<=9)){s = "nw_wamar001";i = 50;}
else if((iRand2>=10)&&(iRand2<=13)){s = "nw_wambo001";i = 50;}
else if((iRand2>=14)&&(iRand2<=18)){s = "nw_wambu001";i = 50;}
else if((iRand2>=19)&&(iRand2<=19)){s = "nw_wthdt001";i = 50;}
else if((iRand2>=20)&&(iRand2<=20)){s = "nw_wthsh001";i = 1;}
else if((iRand2>=21)&&(iRand2<=21)){s = "nw_wthax001";i = 1;}
else if((iRand2>=22)&&(iRand2<=22)){s = "customscroll";i = 1;}
else if((iRand2>=23)&&(iRand2<=23)){s = "potion_ale";i = 1;}
else if((iRand2>=24)&&(iRand2<=24)){s = "nw_wblcl001";i = 1;}
else if((iRand2>=25)&&(iRand2<=25)){s = "x2_it_wpwhip";i = 1;}
else if((iRand2>=26)&&(iRand2<=26)){s = "cr_apple";i = 1;}
else if((iRand2>=27)&&(iRand2<=27)){s = "cr_banana";i = 1;}
else if((iRand2>=28)&&(iRand2<=28)){s = "cr_cereal";i = 1;}
else if((iRand2>=29)&&(iRand2<=29)){s = "cr_egg";i = 1;}
else if((iRand2>=30)&&(iRand2<=30)){s = "cr_feathers";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "cr_firelit";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "cr_milk";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "cr_arabano";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "cr_astrakan";i = 1;}
else if((iRand2>=35)&&(iRand2<=35)){s = "cr_barbazun";i = 1;}
else if((iRand2>=36)&&(iRand2<=36)){s = "cr_bouzkashi";i = 1;}
else if((iRand2>=37)&&(iRand2<=37)){s = "cr_cajun";i = 1;}
else if((iRand2>=38)&&(iRand2<=38)){s = "cr_plantcommon";i = 1;}
else if((iRand2>=39)&&(iRand2<=39)){s = "cr_hino";i = 1;}
else if((iRand2>=40)&&(iRand2<=40)){s = "cr_jinja";i = 1;}
else if((iRand2>=41)&&(iRand2<=41)){s = "cr_mika";i = 1;}
else if((iRand2>=42)&&(iRand2<=42)){s = "cr_shosho";i = 1;}
else if((iRand2>=43)&&(iRand2<=43)){s = "cr_sokol";i = 1;}
else if((iRand2>=44)&&(iRand2<=44)){s = "cr_tiaranwe";i = 1;}
else if((iRand2>=45)&&(iRand2<=45)){s = "cr_poison";i = 1;}
else if((iRand2>=46)&&(iRand2<=49)){s = "cr_sandwich";i = 1;}
else if((iRand2>=50)&&(iRand2<=52)){s = "potion_wine";i = 1;}
else if((iRand2>=53)&&(iRand2<=55)){s = "nw_wswdg001";i = 1;}
else if((iRand2>=56)&&(iRand2<=58)){s = "cr_bottleempty";i = 1;}
else if((iRand2>=59)&&(iRand2<=63)){s = "cr_food";i = 1;}
else if((iRand2>=64)&&(iRand2<=67)){s = "nw_it_torch001";i = 1;}
else if((iRand2>=68)&&(iRand2<=68)){s = "cr_cotton";i = 1;}
else if((iRand2>=69)&&(iRand2<=69)){s = "cr_bag";i = 1;}
else if((iRand2>=70)&&(iRand2<=70)){s = "cr_box";i = 1;}
else if((iRand2>=71)&&(iRand2<=71)){s = "cr_pemican";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(51)+100);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==2){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+8; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(89)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=2)){s = "customscroll";i = 1;}
else if((iRand2>=3)&&(iRand2<=4)){s = "potion_ale";i = 1;}
else if((iRand2>=5)&&(iRand2<=5)){s = "nw_wblcl001";i = 1;}
else if((iRand2>=6)&&(iRand2<=6)){s = "x2_it_wpwhip";i = 1;}
else if((iRand2>=7)&&(iRand2<=7)){s = "cr_apple";i = 1;}
else if((iRand2>=8)&&(iRand2<=8)){s = "cr_banana";i = 1;}
else if((iRand2>=9)&&(iRand2<=9)){s = "cr_cereal";i = 1;}
else if((iRand2>=10)&&(iRand2<=10)){s = "cr_egg";i = 1;}
else if((iRand2>=11)&&(iRand2<=11)){s = "cr_feathers";i = 1;}
else if((iRand2>=12)&&(iRand2<=12)){s = "cr_firelit";i = 1;}
else if((iRand2>=13)&&(iRand2<=13)){s = "cr_milk";i = 1;}
else if((iRand2>=14)&&(iRand2<=14)){s = "cr_arabano";i = 1;}
else if((iRand2>=15)&&(iRand2<=15)){s = "cr_astrakan";i = 1;}
else if((iRand2>=16)&&(iRand2<=16)){s = "cr_barbazun";i = 1;}
else if((iRand2>=17)&&(iRand2<=17)){s = "cr_bouzkashi";i = 1;}
else if((iRand2>=18)&&(iRand2<=18)){s = "cr_cajun";i = 1;}
else if((iRand2>=19)&&(iRand2<=19)){s = "cr_plantcommon";i = 1;}
else if((iRand2>=20)&&(iRand2<=20)){s = "cr_hino";i = 1;}
else if((iRand2>=21)&&(iRand2<=21)){s = "cr_jinja";i = 1;}
else if((iRand2>=22)&&(iRand2<=22)){s = "cr_mika";i = 1;}
else if((iRand2>=23)&&(iRand2<=23)){s = "cr_shosho";i = 1;}
else if((iRand2>=24)&&(iRand2<=24)){s = "cr_sokol";i = 1;}
else if((iRand2>=25)&&(iRand2<=25)){s = "cr_tiaranwe";i = 1;}
else if((iRand2>=26)&&(iRand2<=26)){s = "cr_poison";i = 1;}
else if((iRand2>=27)&&(iRand2<=30)){s = "cr_sandwich";i = 1;}
else if((iRand2>=31)&&(iRand2<=33)){s = "potion_wine";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "nw_wswdg001";i = 1;}
else if((iRand2>=35)&&(iRand2<=37)){s = "cr_bottleempty";i = 1;}
else if((iRand2>=38)&&(iRand2<=40)){s = "cr_food";i = 1;}
else if((iRand2>=41)&&(iRand2<=42)){s = "cr_boltofcloth";i = 1;}
else if((iRand2>=43)&&(iRand2<=44)){s = "cr_bone";i = 1;}
else if((iRand2>=45)&&(iRand2<=46)){s = "cr_bread";i = 1;}
else if((iRand2>=47)&&(iRand2<=48)){s = "cr_eggs";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "cr_fish";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "cr_meat";i = 1;}
else if((iRand2>=51)&&(iRand2<=52)){s = "cr_coal";i = 1;}
else if((iRand2>=53)&&(iRand2<=54)){s = "cr_iron";i = 1;}
else if((iRand2>=55)&&(iRand2<=56)){s = "cr_lead";i = 1;}
else if((iRand2>=57)&&(iRand2<=58)){s = "cr_sand";i = 1;}
else if((iRand2>=59)&&(iRand2<=60)){s = "cr_stone";i = 1;}
else if((iRand2>=61)&&(iRand2<=62)){s = "cr_tin";i = 1;}
else if((iRand2>=63)&&(iRand2<=64)){s = "cr_woodbasic";i = 1;}
else if((iRand2>=65)&&(iRand2<=65)){s = "cr_woodsoft";i = 1;}
else if((iRand2>=66)&&(iRand2<=66)){s = "cr_woodstrong";i = 1;}
else if((iRand2>=67)&&(iRand2<=69)){s = "nw_it_torch001";i = 1;}
else if((iRand2>=70)&&(iRand2<=71)){s = "potion_spirits";i = 1;}
else if((iRand2>=72)&&(iRand2<=72)){s = "cr_gem010";i = 1;}
else if((iRand2>=73)&&(iRand2<=73)){s = "cr_gem011";i = 1;}
else if((iRand2>=74)&&(iRand2<=74)){s = "nw_ashsw001";i = 1;}
else if((iRand2>=75)&&(iRand2<=75)){s = "x2_it_spdvscr001";i = 1;}
else if((iRand2>=76)&&(iRand2<=76)){s = "cr_gem006";i = 1;}
else if((iRand2>=77)&&(iRand2<=77)){s = "nw_wblml001";i = 1;}
else if((iRand2>=78)&&(iRand2<=80)){s = "bedroll";i = 1;}
else if((iRand2>=81)&&(iRand2<=85)){s = "key001";i = 1;}
else if((iRand2>=86)&&(iRand2<=86)){s = "cr_cotton";i = 1;}
else if((iRand2>=87)&&(iRand2<=87)){s = "cr_bag";i = 1;}
else if((iRand2>=88)&&(iRand2<=88)){s = "cr_box";i = 1;}
else if((iRand2>=89)&&(iRand2<=89)){s = "cr_pemican";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(81)+150);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==3){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+7; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(96)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=2)){s = "cr_boltofcloth";i = 1;}
else if((iRand2>=3)&&(iRand2<=4)){s = "cr_bone";i = 1;}
else if((iRand2>=5)&&(iRand2<=6)){s = "cr_bread";i = 1;}
else if((iRand2>=7)&&(iRand2<=8)){s = "cr_eggs";i = 1;}
else if((iRand2>=9)&&(iRand2<=9)){s = "cr_fish";i = 1;}
else if((iRand2>=10)&&(iRand2<=10)){s = "cr_meat";i = 1;}
else if((iRand2>=11)&&(iRand2<=13)){s = "cr_coal";i = 1;}
else if((iRand2>=14)&&(iRand2<=16)){s = "cr_iron";i = 1;}
else if((iRand2>=17)&&(iRand2<=19)){s = "cr_lead";i = 1;}
else if((iRand2>=20)&&(iRand2<=22)){s = "cr_sand";i = 1;}
else if((iRand2>=23)&&(iRand2<=25)){s = "cr_stone";i = 1;}
else if((iRand2>=26)&&(iRand2<=28)){s = "cr_tin";i = 1;}
else if((iRand2>=29)&&(iRand2<=30)){s = "cr_woodbasic";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "cr_woodsoft";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "cr_woodstrong";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "nw_it_torch001";i = 1;}
else if((iRand2>=34)&&(iRand2<=35)){s = "potion_spirits";i = 1;}
else if((iRand2>=36)&&(iRand2<=37)){s = "cr_gem010";i = 1;}
else if((iRand2>=38)&&(iRand2<=39)){s = "cr_gem011";i = 1;}
else if((iRand2>=40)&&(iRand2<=41)){s = "nw_ashsw001";i = 1;}
else if((iRand2>=42)&&(iRand2<=42)){s = "x2_it_spdvscr001";i = 1;}
else if((iRand2>=43)&&(iRand2<=44)){s = "cr_gem006";i = 1;}
else if((iRand2>=45)&&(iRand2<=46)){s = "nw_wblml001";i = 1;}
else if((iRand2>=47)&&(iRand2<=47)){s = "bedroll";i = 1;}
else if((iRand2>=48)&&(iRand2<=48)){s = "cr_bronze";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "cr_powderfaerun";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "cr_copper";i = 1;}
else if((iRand2>=51)&&(iRand2<=51)){s = "cr_mercury";i = 1;}
else if((iRand2>=52)&&(iRand2<=52)){s = "cr_steel";i = 1;}
else if((iRand2>=53)&&(iRand2<=53)){s = "nw_waxhn001";i = 1;}
else if((iRand2>=54)&&(iRand2<=54)){s = "nw_wspsc001";i = 1;}
else if((iRand2>=55)&&(iRand2<=55)){s = "nw_it_contain001";i = 1;}
else if((iRand2>=56)&&(iRand2<=57)){s = "nw_it_picks001";i = 1;}
else if((iRand2>=58)&&(iRand2<=58)){s = "nw_arhe001";i = 1;}
else if((iRand2>=59)&&(iRand2<=59)){s = "nw_it_sparscr003";i = 1;}
else if((iRand2>=60)&&(iRand2<=60)){s = "nw_it_sparscr004";i = 1;}
else if((iRand2>=61)&&(iRand2<=61)){s = "x2_it_spdvscr002";i = 1;}
else if((iRand2>=62)&&(iRand2<=62)){s = "cr_gem003";i = 1;}
else if((iRand2>=63)&&(iRand2<=63)){s = "cr_gem012";i = 1;}
else if((iRand2>=64)&&(iRand2<=64)){s = "nw_it_mpotion001";i = 1;}
else if((iRand2>=65)&&(iRand2<=65)){s = "cr_acidflask";i = 1;}
else if((iRand2>=66)&&(iRand2<=66)){s = "cr_alchemistfire";i = 1;}
else if((iRand2>=67)&&(iRand2<=67)){s = "cr_calltrops";i = 1;}
else if((iRand2>=68)&&(iRand2<=69)){s = "cr_rope";i = 1;}
else if((iRand2>=70)&&(iRand2<=71)){s = "tool_sickle";i = 1;}
else if((iRand2>=72)&&(iRand2<=72)){s = "nw_it_sparscr107";i = 1;}
else if((iRand2>=73)&&(iRand2<=73)){s = "x1_it_sparscr003";i = 1;}
else if((iRand2>=74)&&(iRand2<=74)){s = "x1_it_sparscr001";i = 1;}
else if((iRand2>=75)&&(iRand2<=75)){s = "x1_it_spdvscr001";i = 1;}
else if((iRand2>=76)&&(iRand2<=76)){s = "cr_holywater";i = 1;}
else if((iRand2>=77)&&(iRand2<=78)){s = "tool_axe";i = 1;}
else if((iRand2>=79)&&(iRand2<=79)){s = "nw_it_mpotion020";i = 1;}
else if((iRand2>=80)&&(iRand2<=80)){s = "x2_it_spdvscr104";i = 1;}
else if((iRand2>=81)&&(iRand2<=81)){s = "nw_it_sparscr113";i = 1;}
else if((iRand2>=82)&&(iRand2<=85)){s = "key001";i = 1;}
else if((iRand2>=86)&&(iRand2<=90)){s = "key002";i = 1;}
else if((iRand2>=91)&&(iRand2<=91)){s = "maskunderwater";i = 1;}
// Raise
else if((iRand2>=92)&&(iRand2<=96)){s = "cr_raisedead";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(101)+200);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==4){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+6; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(122)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=2)){s = "cr_gem010";i = 1;}
else if((iRand2>=3)&&(iRand2<=4)){s = "cr_gem011";i = 1;}
else if((iRand2>=5)&&(iRand2<=6)){s = "nw_ashsw001";i = 1;}
else if((iRand2>=7)&&(iRand2<=8)){s = "x2_it_spdvscr001";i = 1;}
else if((iRand2>=9)&&(iRand2<=10)){s = "cr_gem006";i = 1;}
else if((iRand2>=11)&&(iRand2<=11)){s = "nw_wblml001";i = 1;}
else if((iRand2>=12)&&(iRand2<=12)){s = "bedroll";i = 1;}
else if((iRand2>=14)&&(iRand2<=14)){s = "cr_bronze";i = 1;}
else if((iRand2>=16)&&(iRand2<=16)){s = "cr_powderfaerun";i = 1;}
else if((iRand2>=18)&&(iRand2<=18)){s = "cr_copper";i = 1;}
else if((iRand2>=20)&&(iRand2<=20)){s = "cr_mercury";i = 1;}
else if((iRand2>=21)&&(iRand2<=21)){s = "cr_steel";i = 1;}
else if((iRand2>=22)&&(iRand2<=22)){s = "nw_waxhn001";i = 1;}
else if((iRand2>=23)&&(iRand2<=23)){s = "nw_wspsc001";i = 1;}
else if((iRand2>=24)&&(iRand2<=24)){s = "nw_it_contain001";i = 1;}
else if((iRand2>=25)&&(iRand2<=25)){s = "nw_it_picks001";i = 1;}
else if((iRand2>=26)&&(iRand2<=26)){s = "nw_arhe001";i = 1;}
else if((iRand2>=27)&&(iRand2<=27)){s = "nw_it_sparscr003";i = 1;}
else if((iRand2>=28)&&(iRand2<=28)){s = "nw_it_sparscr004";i = 1;}
else if((iRand2>=29)&&(iRand2<=29)){s = "x2_it_spdvscr002";i = 1;}
else if((iRand2>=30)&&(iRand2<=30)){s = "cr_gem003";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "cr_gem012";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "nw_it_mpotion001";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "cr_acidflask";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "cr_alchemistfire";i = 1;}
else if((iRand2>=35)&&(iRand2<=35)){s = "cr_calltrops";i = 1;}
else if((iRand2>=36)&&(iRand2<=36)){s = "cr_rope";i = 1;}
else if((iRand2>=37)&&(iRand2<=37)){s = "tool_sickle";i = 1;}
else if((iRand2>=38)&&(iRand2<=38)){s = "nw_it_sparscr107";i = 1;}
else if((iRand2>=39)&&(iRand2<=39)){s = "x1_it_sparscr003";i = 1;}
else if((iRand2>=40)&&(iRand2<=40)){s = "x1_it_sparscr001";i = 1;}
else if((iRand2>=41)&&(iRand2<=41)){s = "x1_it_spdvscr001";i = 1;}
else if((iRand2>=42)&&(iRand2<=42)){s = "cr_holywater";i = 1;}
else if((iRand2>=43)&&(iRand2<=43)){s = "tool_axe";i = 1;}
else if((iRand2>=44)&&(iRand2<=44)){s = "nw_it_mpotion020";i = 1;}
else if((iRand2>=45)&&(iRand2<=45)){s = "x2_it_spdvscr104";i = 1;}
else if((iRand2>=46)&&(iRand2<=46)){s = "nw_it_sparscr113";i = 1;}
else if((iRand2>=47)&&(iRand2<=47)){s = "cr_gem002";i = 1;}
else if((iRand2>=48)&&(iRand2<=48)){s = "nw_it_mpotion009";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "x2_it_mpotion001";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "cr_chokingpowder";i = 1;}
else if((iRand2>=51)&&(iRand2<=51)){s = "cr_thunderstone";i = 1;}
else if((iRand2>=52)&&(iRand2<=52)){s = "tool_pick";i = 1;}
else if((iRand2>=53)&&(iRand2<=53)){s = "nw_it_sparscr109";i = 1;}
else if((iRand2>=54)&&(iRand2<=54)){s = "cr_gem008";i = 1;}
else if((iRand2>=55)&&(iRand2<=55)){s = "belt";i = 1;}
else if((iRand2>=56)&&(iRand2<=56)){s = "boots";i = 1;}
else if((iRand2>=57)&&(iRand2<=57)){s = "bracers";i = 1;}
else if((iRand2>=58)&&(iRand2<=58)){s = "cloak";i = 1;}
else if((iRand2>=59)&&(iRand2<=59)){s = "gauntlet";i = 1;}
else if((iRand2>=60)&&(iRand2<=60)){s = "tent001";i = 1;}
else if((iRand2>=61)&&(iRand2<=61)){s = "nw_it_medkit001";i = 1;}
else if((iRand2>=62)&&(iRand2<=62)){s = "x2_it_spdvscr203";i = 1;}
else if((iRand2>=63)&&(iRand2<=63)){s = "cr_tanglefootbag";i = 1;}
else if((iRand2>=64)&&(iRand2<=64)){s = "nw_it_medkit002";i = 1;}
else if((iRand2>=65)&&(iRand2<=65)){s = "nw_it_mpotion002";i = 1;}
else if((iRand2>=66)&&(iRand2<=66)){s = "x1_it_sparscr102";i = 1;}
else if((iRand2>=67)&&(iRand2<=67)){s = "x1_it_spdvscr101";i = 1;}
else if((iRand2>=68)&&(iRand2<=68)){s = "x2_it_spdvscr103";i = 1;}
else if((iRand2>=69)&&(iRand2<=69)){s = "nw_it_sparscr112";i = 1;}
else if((iRand2>=70)&&(iRand2<=70)){s = "x1_it_spdvscr107";i = 1;}
else if((iRand2>=71)&&(iRand2<=71)){s = "nw_it_spdvscr202";i = 1;}
else if((iRand2>=72)&&(iRand2<=72)){s = "nw_it_sparscr110";i = 1;}
else if((iRand2>=73)&&(iRand2<=73)){s = "x1_it_spdvscr102";i = 1;}
else if((iRand2>=74)&&(iRand2<=74)){s = "x2_it_spdvscr105";i = 1;}
else if((iRand2>=75)&&(iRand2<=75)){s = "nw_it_sparscr101";i = 1;}
else if((iRand2>=76)&&(iRand2<=76)){s = "x2_it_spdvscr106";i = 1;}
else if((iRand2>=77)&&(iRand2<=77)){s = "x1_it_spdvscr103";i = 1;}
else if((iRand2>=78)&&(iRand2<=78)){s = "x1_it_sparscr101";i = 1;}
else if((iRand2>=79)&&(iRand2<=79)){s = "nw_it_sparscr103";i = 1;}
else if((iRand2>=80)&&(iRand2<=80)){s = "x2_it_sparscr101";i = 1;}
else if((iRand2>=81)&&(iRand2<=81)){s = "x2_it_sparscr104";i = 1;}
else if((iRand2>=82)&&(iRand2<=82)){s = "x1_it_spdvscr104";i = 1;}
else if((iRand2>=83)&&(iRand2<=83)){s = "x2_it_sparscr102";i = 1;}
else if((iRand2>=84)&&(iRand2<=84)){s = "nw_it_sparscr104";i = 1;}
else if((iRand2>=85)&&(iRand2<=85)){s = "x1_it_spdvscr106";i = 1;}
else if((iRand2>=86)&&(iRand2<=86)){s = "x2_it_sparscr105";i = 1;}
else if((iRand2>=87)&&(iRand2<=87)){s = "nw_it_sparscr102";i = 1;}
else if((iRand2>=88)&&(iRand2<=88)){s = "nw_it_sparscr111";i = 1;}
else if((iRand2>=89)&&(iRand2<=89)){s = "x2_it_spdvscr107";i = 1;}
else if((iRand2>=90)&&(iRand2<=90)){s = "nw_it_sparscr001";i = 1;}
else if((iRand2>=91)&&(iRand2<=91)){s = "x2_it_spdvscr108";i = 1;}
else if((iRand2>=92)&&(iRand2<=92)){s = "nw_it_sparscr210";i = 1;}
else if((iRand2>=93)&&(iRand2<=93)){s = "x2_it_sparscr103";i = 1;}
else if((iRand2>=94)&&(iRand2<=94)){s = "x1_it_sparscr103";i = 1;}
else if((iRand2>=95)&&(iRand2<=95)){s = "x1_it_spdvscr105";i = 1;}
else if((iRand2>=96)&&(iRand2<=96)){s = "nw_it_sparscr108";i = 1;}
else if((iRand2>=97)&&(iRand2<=97)){s = "nw_it_sparscr105";i = 1;}
else if((iRand2>=98)&&(iRand2<=98)){s = "x1_it_sparscr104";i = 1;}
else if((iRand2>=99)&&(iRand2<=104)){s = "key001";i = 1;}
else if((iRand2>=105)&&(iRand2<=110)){s = "key002";i = 1;}
else if((iRand2>=111)&&(iRand2<=115)){s = "key003";i = 1;}
else if((iRand2>=116)&&(iRand2<=116)){s = "maskunderwater";i = 1;}
// Raise
else if((iRand2>=117)&&(iRand2<=122)){s = "cr_raisedead";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(151)+250);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==5){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+5; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(87)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=1)){s = "nw_it_medkit001";i = 1;}
else if((iRand2>=2)&&(iRand2<=2)){s = "x2_it_spdvscr203";i = 1;}
else if((iRand2>=3)&&(iRand2<=3)){s = "cr_tanglefootbag";i = 1;}
else if((iRand2>=4)&&(iRand2<=4)){s = "nw_it_medkit002";i = 1;}
else if((iRand2>=5)&&(iRand2<=5)){s = "nw_it_mpotion002";i = 1;}
else if((iRand2>=6)&&(iRand2<=6)){s = "x1_it_sparscr102";i = 1;}
else if((iRand2>=7)&&(iRand2<=7)){s = "x1_it_spdvscr101";i = 1;}
else if((iRand2>=8)&&(iRand2<=8)){s = "x2_it_spdvscr103";i = 1;}
else if((iRand2>=9)&&(iRand2<=9)){s = "nw_it_sparscr112";i = 1;}
else if((iRand2>=10)&&(iRand2<=10)){s = "x1_it_spdvscr107";i = 1;}
else if((iRand2>=11)&&(iRand2<=11)){s = "nw_it_spdvscr202";i = 1;}
else if((iRand2>=12)&&(iRand2<=12)){s = "nw_it_sparscr110";i = 1;}
else if((iRand2>=13)&&(iRand2<=13)){s = "x1_it_spdvscr102";i = 1;}
else if((iRand2>=14)&&(iRand2<=14)){s = "x2_it_spdvscr105";i = 1;}
else if((iRand2>=15)&&(iRand2<=15)){s = "nw_it_sparscr101";i = 1;}
else if((iRand2>=16)&&(iRand2<=16)){s = "x2_it_spdvscr106";i = 1;}
else if((iRand2>=17)&&(iRand2<=17)){s = "x1_it_spdvscr103";i = 1;}
else if((iRand2>=18)&&(iRand2<=18)){s = "x1_it_sparscr101";i = 1;}
else if((iRand2>=19)&&(iRand2<=19)){s = "nw_it_sparscr103";i = 1;}
else if((iRand2>=20)&&(iRand2<=20)){s = "x2_it_sparscr101";i = 1;}
else if((iRand2>=21)&&(iRand2<=21)){s = "x2_it_sparscr104";i = 1;}
else if((iRand2>=22)&&(iRand2<=22)){s = "x1_it_spdvscr104";i = 1;}
else if((iRand2>=23)&&(iRand2<=23)){s = "x2_it_sparscr102";i = 1;}
else if((iRand2>=24)&&(iRand2<=24)){s = "nw_it_sparscr104";i = 1;}
else if((iRand2>=25)&&(iRand2<=25)){s = "x1_it_spdvscr106";i = 1;}
else if((iRand2>=26)&&(iRand2<=26)){s = "x2_it_sparscr105";i = 1;}
else if((iRand2>=27)&&(iRand2<=27)){s = "nw_it_sparscr102";i = 1;}
else if((iRand2>=28)&&(iRand2<=28)){s = "nw_it_sparscr111";i = 1;}
else if((iRand2>=29)&&(iRand2<=29)){s = "x2_it_spdvscr107";i = 1;}
else if((iRand2>=30)&&(iRand2<=30)){s = "nw_it_sparscr001";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "x2_it_spdvscr108";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "nw_it_sparscr210";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "x2_it_sparscr103";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "x1_it_sparscr103";i = 1;}
else if((iRand2>=35)&&(iRand2<=35)){s = "x1_it_spdvscr105";i = 1;}
else if((iRand2>=36)&&(iRand2<=36)){s = "nw_it_sparscr108";i = 1;}
else if((iRand2>=37)&&(iRand2<=37)){s = "nw_it_sparscr105";i = 1;}
else if((iRand2>=38)&&(iRand2<=38)){s = "x1_it_sparscr104";i = 1;}
else if((iRand2>=39)&&(iRand2<=39)){s = "nw_it_mpotion005";i = 1;}
else if((iRand2>=40)&&(iRand2<=40)){s = "nw_it_medkit003";i = 1;}
else if((iRand2>=41)&&(iRand2<=41)){s = "tent002";i = 1;}
else if((iRand2>=42)&&(iRand2<=45)){s = "cr_silver";i = 1;}
else if((iRand2>=46)&&(iRand2<=46)){s = "cr_blooddragon";i = 1;}
else if((iRand2>=47)&&(iRand2<=47)){s = "cr_gem009";i = 1;}
else if((iRand2>=48)&&(iRand2<=48)){s = "nw_it_mpotion016";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "nw_it_mpotion015";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "nw_it_mpotion014";i = 1;}
else if((iRand2>=51)&&(iRand2<=51)){s = "nw_it_mpotion007";i = 1;}
else if((iRand2>=52)&&(iRand2<=52)){s = "x2_it_mpotion002";i = 1;}
else if((iRand2>=53)&&(iRand2<=53)){s = "nw_it_mpotion010";i = 1;}
else if((iRand2>=54)&&(iRand2<=54)){s = "nw_it_mpotion013";i = 1;}
else if((iRand2>=55)&&(iRand2<=55)){s = "nw_it_mpotion017";i = 1;}
else if((iRand2>=56)&&(iRand2<=56)){s = "nw_it_mpotion008";i = 1;}
else if((iRand2>=57)&&(iRand2<=57)){s = "nw_it_mpotion011";i = 1;}
else if((iRand2>=58)&&(iRand2<=58)){s = "nw_it_mpotion019";i = 1;}
else if((iRand2>=59)&&(iRand2<=59)){s = "nw_it_mpotion018";i = 1;}
else if((iRand2>=60)&&(iRand2<=60)){s = "x2_it_spdvscr308";i = 1;}
else if((iRand2>=61)&&(iRand2<=61)){s = "nw_it_mring022";i = 1;}
else if((iRand2>=62)&&(iRand2<=62)){s = "nw_it_picks002";i = 1;}
else if((iRand2>=63)&&(iRand2<=63)){s = "x2_it_spdvscr202";i = 1;}
else if((iRand2>=64)&&(iRand2<=64)){s = "cr_gem001";i = 1;}
else if((iRand2>=65)&&(iRand2<=65)){s = "nw_it_medkit004";i = 1;}
else if((iRand2>=66)&&(iRand2<=66)){s = "x2_it_spdvscr102";i = 1;}
else if((iRand2>=67)&&(iRand2<=67)){s = "x2_it_spdvscr101";i = 1;}
else if((iRand2>=68)&&(iRand2<=68)){s = "x2_it_sparscral";i = 1;}
else if((iRand2>=69)&&(iRand2<=73)){s = "key002";i = 1;}
else if((iRand2>=74)&&(iRand2<=77)){s = "key003";i = 1;}
else if((iRand2>=78)&&(iRand2<=81)){s = "key004";i = 1;}
// Raise
else if((iRand2>=82)&&(iRand2<=87)){s = "cr_raisedead";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(201)+300);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==6){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+4; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(106)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=3)){s = "cr_silver";i = 1;}
else if((iRand2>=4)&&(iRand2<=4)){s = "cr_blooddragon";i = 1;}
else if((iRand2>=5)&&(iRand2<=6)){s = "cr_gem009";i = 1;}
else if((iRand2>=7)&&(iRand2<=7)){s = "nw_it_mpotion016";i = 1;}
else if((iRand2>=8)&&(iRand2<=8)){s = "nw_it_mpotion015";i = 1;}
else if((iRand2>=9)&&(iRand2<=9)){s = "nw_it_mpotion014";i = 1;}
else if((iRand2>=10)&&(iRand2<=10)){s = "nw_it_mpotion007";i = 1;}
else if((iRand2>=11)&&(iRand2<=11)){s = "x2_it_mpotion002";i = 1;}
else if((iRand2>=12)&&(iRand2<=12)){s = "nw_it_mpotion010";i = 1;}
else if((iRand2>=13)&&(iRand2<=13)){s = "nw_it_mpotion013";i = 1;}
else if((iRand2>=14)&&(iRand2<=14)){s = "nw_it_mpotion017";i = 1;}
else if((iRand2>=15)&&(iRand2<=15)){s = "nw_it_mpotion008";i = 1;}
else if((iRand2>=16)&&(iRand2<=16)){s = "nw_it_mpotion011";i = 1;}
else if((iRand2>=17)&&(iRand2<=17)){s = "nw_it_mpotion019";i = 1;}
else if((iRand2>=18)&&(iRand2<=18)){s = "nw_it_mpotion018";i = 1;}
else if((iRand2>=19)&&(iRand2<=19)){s = "x2_it_spdvscr308";i = 1;}
else if((iRand2>=20)&&(iRand2<=20)){s = "nw_it_mring022";i = 1;}
else if((iRand2>=21)&&(iRand2<=21)){s = "nw_it_picks002";i = 1;}
else if((iRand2>=22)&&(iRand2<=22)){s = "x2_it_spdvscr202";i = 1;}
else if((iRand2>=23)&&(iRand2<=23)){s = "cr_gem001";i = 1;}
else if((iRand2>=24)&&(iRand2<=24)){s = "nw_it_medkit004";i = 1;}
else if((iRand2>=25)&&(iRand2<=25)){s = "x2_it_spdvscr102";i = 1;}
else if((iRand2>=26)&&(iRand2<=26)){s = "x2_it_spdvscr101";i = 1;}
else if((iRand2>=27)&&(iRand2<=27)){s = "x2_it_sparscral";i = 1;}
else if((iRand2>=28)&&(iRand2<=28)){s = "amulet";i = 1;}
else if((iRand2>=29)&&(iRand2<=29)){s = "tent003";i = 1;}
else if((iRand2>=30)&&(iRand2<=30)){s = "x2_it_spdvscr201";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "x1_it_spdvscr204";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "x1_it_sparscr201";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "nw_it_sparscr211";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "x1_it_spdvscr202";i = 1;}
else if((iRand2>=35)&&(iRand2<=35)){s = "nw_it_sparscr212";i = 1;}
else if((iRand2>=36)&&(iRand2<=36)){s = "x2_it_sparscr207";i = 1;}
else if((iRand2>=37)&&(iRand2<=37)){s = "nw_it_sparscr217";i = 1;}
else if((iRand2>=38)&&(iRand2<=38)){s = "x2_it_sparscr206";i = 1;}
else if((iRand2>=39)&&(iRand2<=39)){s = "x2_it_sparscr201";i = 1;}
else if((iRand2>=40)&&(iRand2<=40)){s = "nw_it_sparscr206";i = 1;}
else if((iRand2>=41)&&(iRand2<=41)){s = "x2_it_sparscr202";i = 1;}
else if((iRand2>=42)&&(iRand2<=42)){s = "nw_it_sparscr219";i = 1;}
else if((iRand2>=43)&&(iRand2<=43)){s = "nw_it_sparscr215";i = 1;}
else if((iRand2>=44)&&(iRand2<=44)){s = "x2_it_sparscr305";i = 1;}
else if((iRand2>=45)&&(iRand2<=45)){s = "x1_it_spdvscr205";i = 1;}
else if((iRand2>=46)&&(iRand2<=46)){s = "nw_it_sparscr220";i = 1;}
else if((iRand2>=47)&&(iRand2<=47)){s = "x2_it_sparscr203";i = 1;}
else if((iRand2>=48)&&(iRand2<=48)){s = "nw_it_sparscr208";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "nw_it_sparscr209";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "x2_it_spdvscr204";i = 1;}
else if((iRand2>=51)&&(iRand2<=51)){s = "nw_it_sparscr308";i = 1;}
else if((iRand2>=52)&&(iRand2<=52)){s = "nw_it_sparscr106";i = 1;}
else if((iRand2>=53)&&(iRand2<=53)){s = "x1_it_spdvscr201";i = 1;}
else if((iRand2>=54)&&(iRand2<=54)){s = "nw_it_sparscr207";i = 1;}
else if((iRand2>=55)&&(iRand2<=55)){s = "nw_it_sparscr216";i = 1;}
else if((iRand2>=56)&&(iRand2<=56)){s = "nw_it_sparscr218";i = 1;}
else if((iRand2>=57)&&(iRand2<=57)){s = "nw_it_spdvscr201";i = 1;}
else if((iRand2>=58)&&(iRand2<=58)){s = "nw_it_sparscr202";i = 1;}
else if((iRand2>=59)&&(iRand2<=59)){s = "x1_it_spdvscr203";i = 1;}
else if((iRand2>=60)&&(iRand2<=60)){s = "nw_it_sparscr221";i = 1;}
else if((iRand2>=61)&&(iRand2<=61)){s = "x2_it_spdvscr205";i = 1;}
else if((iRand2>=62)&&(iRand2<=62)){s = "nw_it_sparscr201";i = 1;}
else if((iRand2>=63)&&(iRand2<=63)){s = "nw_it_sparscr205";i = 1;}
else if((iRand2>=64)&&(iRand2<=64)){s = "nw_it_spdvscr203";i = 1;}
else if((iRand2>=65)&&(iRand2<=65)){s = "nw_it_spdvscr204";i = 1;}
else if((iRand2>=66)&&(iRand2<=66)){s = "x2_it_sparscr204";i = 1;}
else if((iRand2>=67)&&(iRand2<=67)){s = "nw_it_sparscr203";i = 1;}
else if((iRand2>=68)&&(iRand2<=68)){s = "x1_it_sparscr202";i = 1;}
else if((iRand2>=69)&&(iRand2<=69)){s = "nw_it_sparscr214";i = 1;}
else if((iRand2>=70)&&(iRand2<=70)){s = "nw_it_sparscr204";i = 1;}
else if((iRand2>=71)&&(iRand2<=71)){s = "cr_gem015";i = 1;}
else if((iRand2>=72)&&(iRand2<=72)){s = "nw_it_mpotion003";i = 1;}
else if((iRand2>=73)&&(iRand2<=73)){s = "nw_it_mpotion006";i = 1;}
else if((iRand2>=74)&&(iRand2<=74)){s = "nw_it_mpotion004";i = 1;}
else if((iRand2>=75)&&(iRand2<=75)){s = "nw_it_sparscr303";i = 1;}
else if((iRand2>=76)&&(iRand2<=76)){s = "nw_it_spdvscr302";i = 1;}
else if((iRand2>=77)&&(iRand2<=77)){s = "nw_it_sparscr311";i = 1;}
else if((iRand2>=78)&&(iRand2<=78)){s = "nw_it_mring023";i = 1;}
else if((iRand2>=79)&&(iRand2<=82)){s = "cr_adamantine";i = 1;}
else if((iRand2>=83)&&(iRand2<=86)){s = "cr_mithril";i = 1;}
else if((iRand2>=87)&&(iRand2<=87)){s = "x2_it_spdvscr402";i = 1;}
else if((iRand2>=88)&&(iRand2<=91)){s = "key003";i = 1;}
else if((iRand2>=92)&&(iRand2<=95)){s = "key004";i = 1;}
else if((iRand2>=96)&&(iRand2<=99)){s = "key005";i = 1;}
else if((iRand2>=100)&&(iRand2<=100)){s = "cr_bag_magic";i = 1;}
else if((iRand2>=101)&&(iRand2<=101)){s = "cr_box_magic";i = 1;}
// Raise
else if((iRand2>=102)&&(iRand2<=106)){s = "cr_raisedead";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(251)+350);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==7){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+3; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(87)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=2)){s = "cr_gem015";i = 1;}
else if((iRand2>=3)&&(iRand2<=4)){s = "nw_it_mpotion003";i = 1;}
else if((iRand2>=5)&&(iRand2<=6)){s = "nw_it_mpotion006";i = 1;}
else if((iRand2>=7)&&(iRand2<=8)){s = "nw_it_mpotion004";i = 1;}
else if((iRand2>=9)&&(iRand2<=10)){s = "nw_it_sparscr303";i = 1;}
else if((iRand2>=11)&&(iRand2<=12)){s = "nw_it_spdvscr302";i = 1;}
else if((iRand2>=13)&&(iRand2<=14)){s = "nw_it_sparscr311";i = 1;}
else if((iRand2>=15)&&(iRand2<=16)){s = "nw_it_mring023";i = 1;}
else if((iRand2>=17)&&(iRand2<=20)){s = "cr_adamantine";i = 1;}
else if((iRand2>=21)&&(iRand2<=24)){s = "cr_mithril";i = 1;}
else if((iRand2>=25)&&(iRand2<=25)){s = "x2_it_spdvscr402";i = 1;}
else if((iRand2>=26)&&(iRand2<=26)){s = "nw_it_sparscr509";i = 1;}
else if((iRand2>=27)&&(iRand2<=27)){s = "nw_it_sparscr414";i = 1;}
else if((iRand2>=28)&&(iRand2<=28)){s = "x2_it_spdvscr303";i = 1;}
else if((iRand2>=29)&&(iRand2<=29)){s = "x2_it_spdvscr307";i = 1;}
else if((iRand2>=30)&&(iRand2<=30)){s = "nw_it_sparscr405";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "nw_it_sparscr307";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "nw_it_sparscr406";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "nw_it_sparscr411";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "nw_it_sparscr301";i = 1;}
else if((iRand2>=35)&&(iRand2<=35)){s = "x1_it_sparscr301";i = 1;}
else if((iRand2>=36)&&(iRand2<=36)){s = "x2_it_spdvscr309";i = 1;}
else if((iRand2>=37)&&(iRand2<=37)){s = "nw_it_sparscr413";i = 1;}
else if((iRand2>=38)&&(iRand2<=38)){s = "nw_it_sparscr309";i = 1;}
else if((iRand2>=39)&&(iRand2<=39)){s = "nw_it_sparscr304";i = 1;}
else if((iRand2>=40)&&(iRand2<=40)){s = "x2_it_spdvscr306";i = 1;}
else if((iRand2>=41)&&(iRand2<=41)){s = "x1_it_spdvscr303";i = 1;}
else if((iRand2>=42)&&(iRand2<=42)){s = "x2_it_sparscr304";i = 1;}
else if((iRand2>=43)&&(iRand2<=43)){s = "nw_it_sparscr312";i = 1;}
else if((iRand2>=44)&&(iRand2<=44)){s = "x2_it_spdvscr302";i = 1;}
else if((iRand2>=45)&&(iRand2<=45)){s = "x2_it_spdvscr301";i = 1;}
else if((iRand2>=46)&&(iRand2<=46)){s = "x1_it_spdvscr302";i = 1;}
else if((iRand2>=47)&&(iRand2<=47)){s = "x2_it_spdvscr310";i = 1;}
else if((iRand2>=48)&&(iRand2<=48)){s = "nw_it_sparscr314";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "x2_it_sparscr303";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "x2_it_sparscr602";i = 1;}
else if((iRand2>=51)&&(iRand2<=51)){s = "nw_it_sparscr310";i = 1;}
else if((iRand2>=52)&&(iRand2<=52)){s = "x2_it_sparscrmc";i = 1;}
else if((iRand2>=53)&&(iRand2<=53)){s = "x2_it_spdvscr304";i = 1;}
else if((iRand2>=54)&&(iRand2<=54)){s = "x2_it_sparscr301";i = 1;}
else if((iRand2>=55)&&(iRand2<=55)){s = "x2_it_spdvscr311";i = 1;}
else if((iRand2>=56)&&(iRand2<=56)){s = "nw_it_spdvscr402";i = 1;}
else if((iRand2>=57)&&(iRand2<=57)){s = "x2_it_spdvscr407";i = 1;}
else if((iRand2>=58)&&(iRand2<=58)){s = "x2_it_spdvscr312";i = 1;}
else if((iRand2>=59)&&(iRand2<=59)){s = "x1_it_spdvscr305";i = 1;}
else if((iRand2>=60)&&(iRand2<=60)){s = "nw_it_spdvscr301";i = 1;}
else if((iRand2>=61)&&(iRand2<=61)){s = "nw_it_sparscr402";i = 1;}
else if((iRand2>=62)&&(iRand2<=62)){s = "x2_it_sparscr302";i = 1;}
else if((iRand2>=63)&&(iRand2<=63)){s = "x2_it_spdvscr313";i = 1;}
else if((iRand2>=64)&&(iRand2<=64)){s = "nw_it_sparscr313";i = 1;}
else if((iRand2>=65)&&(iRand2<=65)){s = "x1_it_spdvscr304";i = 1;}
else if((iRand2>=66)&&(iRand2<=66)){s = "nw_it_sparscr305";i = 1;}
else if((iRand2>=67)&&(iRand2<=67)){s = "nw_it_sparscr306";i = 1;}
else if((iRand2>=68)&&(iRand2<=68)){s = "x1_it_sparscr302";i = 1;}
else if((iRand2>=69)&&(iRand2<=69)){s = "nw_it_picks003";i = 1;}
else if((iRand2>=70)&&(iRand2<=74)){s = "key004";i = 1;}
else if((iRand2>=75)&&(iRand2<=78)){s = "key005";i = 1;}
else if((iRand2>=79)&&(iRand2<=80)){s = "key006";i = 1;}
else if((iRand2>=81)&&(iRand2<=81)){s = "cr_bag_magic";i = 1;}
else if((iRand2>=82)&&(iRand2<=82)){s = "cr_box_magic";i = 1;}
// Raise
else if((iRand2>=83)&&(iRand2<=87)){s = "cr_raisedead";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(301)+400);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==8){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+2; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(125)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=2)){s = "nw_it_picks003";i = 1;}
else if((iRand2>=3)&&(iRand2<=3)){s = "nw_it_sparscr315";i = 1;}
else if((iRand2>=4)&&(iRand2<=4)){s = "x2_it_sparscr501";i = 1;}
else if((iRand2>=5)&&(iRand2<=5)){s = "x2_it_spdvscr501";i = 1;}
else if((iRand2>=6)&&(iRand2<=6)){s = "x2_it_spdvscr401";i = 1;}
else if((iRand2>=7)&&(iRand2<=7)){s = "x2_it_sparscr502";i = 1;}
else if((iRand2>=8)&&(iRand2<=8)){s = "x2_it_spdvscr502";i = 1;}
else if((iRand2>=9)&&(iRand2<=9)){s = "x2_it_spdvscr503";i = 1;}
else if((iRand2>=10)&&(iRand2<=11)){s = "cr_gem014";i = 1;}
else if((iRand2>=12)&&(iRand2<=13)){s = "x2_it_picks001";i = 1;}
else if((iRand2>=14)&&(iRand2<=16)){s = "cr_gold";i = 1;}
else if((iRand2>=17)&&(iRand2<=19)){s = "cr_crystal";i = 1;}
else if((iRand2>=20)&&(iRand2<=22)){s = "cr_platine";i = 1;}
else if((iRand2>=23)&&(iRand2<=23)){s = "x2_it_spdvscr403";i = 1;}
else if((iRand2>=24)&&(iRand2<=24)){s = "nw_it_sparscr501";i = 1;}
else if((iRand2>=25)&&(iRand2<=25)){s = "x2_it_spdvscr404";i = 1;}
else if((iRand2>=26)&&(iRand2<=26)){s = "nw_it_sparscr503";i = 1;}
else if((iRand2>=27)&&(iRand2<=27)){s = "nw_it_sparscr416";i = 1;}
else if((iRand2>=28)&&(iRand2<=28)){s = "nw_it_sparscr412";i = 1;}
else if((iRand2>=29)&&(iRand2<=29)){s = "nw_it_sparscr418";i = 1;}
else if((iRand2>=30)&&(iRand2<=30)){s = "x1_it_spdvscr403";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "x2_it_spdvscr405";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "x2_it_spdvscr406";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "nw_it_sparscr505";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "nw_it_sparscr408";i = 1;}
else if((iRand2>=35)&&(iRand2<=35)){s = "x1_it_spdvscr401";i = 1;}
else if((iRand2>=36)&&(iRand2<=36)){s = "x1_it_sparscr401";i = 1;}
else if((iRand2>=37)&&(iRand2<=37)){s = "nw_it_sparscr417";i = 1;}
else if((iRand2>=38)&&(iRand2<=38)){s = "x1_it_spdvscr402";i = 1;}
else if((iRand2>=39)&&(iRand2<=39)){s = "nw_it_sparscr401";i = 1;}
else if((iRand2>=40)&&(iRand2<=40)){s = "nw_it_sparscr409";i = 1;}
else if((iRand2>=41)&&(iRand2<=41)){s = "nw_it_sparscr415";i = 1;}
else if((iRand2>=42)&&(iRand2<=42)){s = "nw_it_spdvscr401";i = 1;}
else if((iRand2>=43)&&(iRand2<=43)){s = "nw_it_sparscr410";i = 1;}
else if((iRand2>=44)&&(iRand2<=44)){s = "nw_it_sparscr403";i = 1;}
else if((iRand2>=45)&&(iRand2<=45)){s = "nw_it_sparscr404";i = 1;}
else if((iRand2>=46)&&(iRand2<=46)){s = "nw_it_contain004";i = 1;}
else if((iRand2>=47)&&(iRand2<=47)){s = "x2_it_spdvscr509";i = 1;}
else if((iRand2>=48)&&(iRand2<=48)){s = "x1_it_sparscr303";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "x2_it_sparscr902";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "nw_it_sparscr507";i = 1;}
else if((iRand2>=51)&&(iRand2<=51)){s = "nw_it_sparscr602";i = 1;}
else if((iRand2>=52)&&(iRand2<=52)){s = "nw_it_sparscr407";i = 1;}
else if((iRand2>=53)&&(iRand2<=53)){s = "nw_it_mpotion012";i = 1;}
else if((iRand2>=54)&&(iRand2<=54)){s = "nw_wthmsh006";i = 1;}
else if((iRand2>=55)&&(iRand2<=55)){s = "cr_gem007";i = 1;}
else if((iRand2>=56)&&(iRand2<=56)){s = "x2_it_acidbomb";i = 1;}
else if((iRand2>=57)&&(iRand2<=57)){s = "x2_it_firebomb";i = 1;}
else if((iRand2>=58)&&(iRand2<=58)){s = "nw_it_picks004";i = 1;}
else if((iRand2>=59)&&(iRand2<=59)){s = "nw_wthmdt006";i = 1;}
else if((iRand2>=60)&&(iRand2<=60)){s = "nw_wthmdt005";i = 1;}
else if((iRand2>=61)&&(iRand2<=61)){s = "x2_it_spdvscr508";i = 1;}
else if((iRand2>=62)&&(iRand2<=62)){s = "x1_it_sparscr502";i = 1;}
else if((iRand2>=63)&&(iRand2<=63)){s = "x2_it_spdvscr504";i = 1;}
else if((iRand2>=64)&&(iRand2<=64)){s = "nw_it_sparscr502";i = 1;}
else if((iRand2>=65)&&(iRand2<=65)){s = "nw_it_sparscr608";i = 1;}
else if((iRand2>=66)&&(iRand2<=66)){s = "nw_it_sparscr504";i = 1;}
else if((iRand2>=67)&&(iRand2<=67)){s = "x1_it_sparscr501";i = 1;}
else if((iRand2>=68)&&(iRand2<=68)){s = "nw_it_sparscr508";i = 1;}
else if((iRand2>=69)&&(iRand2<=69)){s = "x2_it_spdvscr505";i = 1;}
else if((iRand2>=70)&&(iRand2<=70)){s = "x2_it_sparscr401";i = 1;}
else if((iRand2>=71)&&(iRand2<=71)){s = "x1_it_spdvscr501";i = 1;}
else if((iRand2>=72)&&(iRand2<=72)){s = "nw_it_sparscr511";i = 1;}
else if((iRand2>=73)&&(iRand2<=73)){s = "nw_it_sparscr512";i = 1;}
else if((iRand2>=74)&&(iRand2<=74)){s = "nw_it_sparscr513";i = 1;}
else if((iRand2>=75)&&(iRand2<=75)){s = "nw_it_sparscr506";i = 1;}
else if((iRand2>=76)&&(iRand2<=76)){s = "x1_it_spdvscr502";i = 1;}
else if((iRand2>=77)&&(iRand2<=77)){s = "cr_raisedead";i = 1;}
else if((iRand2>=78)&&(iRand2<=78)){s = "x2_it_spdvscr506";i = 1;}
else if((iRand2>=79)&&(iRand2<=79)){s = "x2_it_spdvscr507";i = 1;}
else if((iRand2>=80)&&(iRand2<=80)){s = "nw_it_sparscr510";i = 1;}
else if((iRand2>=81)&&(iRand2<=81)){s = "nw_it_sparscr606";i = 1;}
else if((iRand2>=82)&&(iRand2<=82)){s = "x2_it_sparscr701";i = 1;}
else if((iRand2>=83)&&(iRand2<=83)){s = "cr_gem004";i = 1;}
else if((iRand2>=84)&&(iRand2<=84)){s = "cr_diamondine";i = 1;}
else if((iRand2>=85)&&(iRand2<=85)){s = "x2_it_picks002";i = 1;}
else if((iRand2>=86)&&(iRand2<=86)){s = "nw_it_sparscr603";i = 1;}
else if((iRand2>=87)&&(iRand2<=87)){s = "x1_it_spdvscr601";i = 1;}
else if((iRand2>=88)&&(iRand2<=88)){s = "x1_it_sparscr602";i = 1;}
else if((iRand2>=89)&&(iRand2<=89)){s = "x2_it_spdvscr603";i = 1;}
else if((iRand2>=90)&&(iRand2<=90)){s = "nw_it_sparscr607";i = 1;}
else if((iRand2>=91)&&(iRand2<=91)){s = "nw_it_sparscr610";i = 1;}
else if((iRand2>=92)&&(iRand2<=92)){s = "x1_it_spdvscr605";i = 1;}
else if((iRand2>=93)&&(iRand2<=93)){s = "x2_it_spdvscr601";i = 1;}
else if((iRand2>=94)&&(iRand2<=94)){s = "x1_it_sparscr601";i = 1;}
else if((iRand2>=95)&&(iRand2<=95)){s = "x1_it_spdvscr604";i = 1;}
else if((iRand2>=96)&&(iRand2<=96)){s = "x2_it_sparscr503";i = 1;}
else if((iRand2>=97)&&(iRand2<=97)){s = "x1_it_sparscr605";i = 1;}
else if((iRand2>=98)&&(iRand2<=98)){s = "nw_it_sparscr601";i = 1;}
else if((iRand2>=99)&&(iRand2<=99)){s = "nw_it_sparscr612";i = 1;}
else if((iRand2>=100)&&(iRand2<=100)){s = "nw_it_sparscr613";i = 1;}
else if((iRand2>=101)&&(iRand2<=101)){s = "x2_it_spdvscr604";i = 1;}
else if((iRand2>=102)&&(iRand2<=102)){s = "x2_it_spdvscr605";i = 1;}
else if((iRand2>=103)&&(iRand2<=103)){s = "x1_it_sparscr603";i = 1;}
else if((iRand2>=104)&&(iRand2<=104)){s = "nw_it_sparscr611";i = 1;}
else if((iRand2>=105)&&(iRand2<=105)){s = "x1_it_spdvscr603";i = 1;}
else if((iRand2>=106)&&(iRand2<=106)){s = "nw_it_sparscr604";i = 1;}
else if((iRand2>=107)&&(iRand2<=107)){s = "nw_it_sparscr609";i = 1;}
else if((iRand2>=108)&&(iRand2<=108)){s = "x1_it_sparscr604";i = 1;}
else if((iRand2>=109)&&(iRand2<=109)){s = "x2_it_spdvscr602";i = 1;}
else if((iRand2>=110)&&(iRand2<=110)){s = "nw_it_sparscr605";i = 1;}
else if((iRand2>=111)&&(iRand2<=111)){s = "nw_it_sparscr614";i = 1;}
else if((iRand2>=112)&&(iRand2<=112)){s = "x2_it_sparscr601";i = 1;}
else if((iRand2>=113)&&(iRand2<=113)){s = "cr_gem013";i = 1;}
else if((iRand2>=114)&&(iRand2<=116)){s = "key005";i = 1;}
else if((iRand2>=117)&&(iRand2<=119)){s = "key006";i = 1;}
// Raise
else if((iRand2>=120)&&(iRand2<=125)){s = "cr_raisedead";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(401)+450);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else if(iLevel==9){
////////////////////////////////////////////////////////////////////////////////
                           iRand1 = Random(3)+1; // Random number of treasures
while(iRand1>0){iRand1--;  iRand2 = Random(73)+1; // Probability of the treasures
////////////////////////////////////////////////////////////////////////////////
     if((iRand2>=1)&&(iRand2<=2)){s = "cr_gem013";i = 1;}
else if((iRand2>=3)&&(iRand2<=3)){s = "x1_it_spdvscr701";i = 1;}
else if((iRand2>=4)&&(iRand2<=4)){s = "x1_it_sparscr701";i = 1;}
else if((iRand2>=5)&&(iRand2<=5)){s = "nw_it_sparscr707";i = 1;}
else if((iRand2>=6)&&(iRand2<=6)){s = "x1_it_spdvscr702";i = 1;}
else if((iRand2>=7)&&(iRand2<=7)){s = "nw_it_sparscr704";i = 1;}
else if((iRand2>=8)&&(iRand2<=8)){s = "x1_it_spdvscr703";i = 1;}
else if((iRand2>=9)&&(iRand2<=9)){s = "nw_it_sparscr708";i = 1;}
else if((iRand2>=10)&&(iRand2<=10)){s = "x1_it_spdvscr704";i = 1;}
else if((iRand2>=11)&&(iRand2<=11)){s = "nw_it_spdvscr701";i = 1;}
else if((iRand2>=12)&&(iRand2<=12)){s = "x2_it_spdvscr606";i = 1;}
else if((iRand2>=13)&&(iRand2<=13)){s = "nw_it_sparscr705";i = 1;}
else if((iRand2>=14)&&(iRand2<=14)){s = "nw_it_sparscr702";i = 1;}
else if((iRand2>=15)&&(iRand2<=15)){s = "nw_it_sparscr706";i = 1;}
else if((iRand2>=16)&&(iRand2<=16)){s = "nw_it_sparscr802";i = 1;}
else if((iRand2>=17)&&(iRand2<=17)){s = "x2_it_spdvscr702";i = 1;}
else if((iRand2>=18)&&(iRand2<=18)){s = "nw_it_spdvscr702";i = 1;}
else if((iRand2>=19)&&(iRand2<=19)){s = "x2_it_sparscr703";i = 1;}
else if((iRand2>=20)&&(iRand2<=20)){s = "nw_it_sparscr701";i = 1;}
else if((iRand2>=21)&&(iRand2<=21)){s = "nw_it_sparscr703";i = 1;}
else if((iRand2>=22)&&(iRand2<=22)){s = "x2_it_spdvscr803";i = 1;}
else if((iRand2>=23)&&(iRand2<=23)){s = "x2_it_spdvscr701";i = 1;}
else if((iRand2>=24)&&(iRand2<=26)){s = "cr_gem005";i = 1;}
else if((iRand2>=27)&&(iRand2<=27)){s = "x2_it_spdvscr804";i = 1;}
else if((iRand2>=28)&&(iRand2<=28)){s = "x1_it_sparscr801";i = 1;}
else if((iRand2>=29)&&(iRand2<=29)){s = "x2_it_sparscr801";i = 1;}
else if((iRand2>=30)&&(iRand2<=30)){s = "x1_it_spdvscr803";i = 1;}
else if((iRand2>=31)&&(iRand2<=31)){s = "x1_it_spdvscr804";i = 1;}
else if((iRand2>=32)&&(iRand2<=32)){s = "x1_it_spdvscr801";i = 1;}
else if((iRand2>=33)&&(iRand2<=33)){s = "nw_it_sparscr803";i = 1;}
else if((iRand2>=34)&&(iRand2<=34)){s = "nw_it_sparscr809";i = 1;}
else if((iRand2>=35)&&(iRand2<=35)){s = "nw_it_sparscr804";i = 1;}
else if((iRand2>=36)&&(iRand2<=36)){s = "nw_it_sparscr807";i = 1;}
else if((iRand2>=37)&&(iRand2<=37)){s = "nw_it_sparscr806";i = 1;}
else if((iRand2>=38)&&(iRand2<=38)){s = "x2_it_spdvscr801";i = 1;}
else if((iRand2>=39)&&(iRand2<=39)){s = "nw_it_sparscr801";i = 1;}
else if((iRand2>=40)&&(iRand2<=40)){s = "x2_it_spdvscr802";i = 1;}
else if((iRand2>=41)&&(iRand2<=41)){s = "nw_it_sparscr808";i = 1;}
else if((iRand2>=42)&&(iRand2<=42)){s = "nw_it_sparscr805";i = 1;}
else if((iRand2>=43)&&(iRand2<=43)){s = "x1_it_spdvscr802";i = 1;}
else if((iRand2>=44)&&(iRand2<=44)){s = "x1_it_sparscr901";i = 1;}
else if((iRand2>=45)&&(iRand2<=45)){s = "x2_it_sparscr901";i = 1;}
else if((iRand2>=46)&&(iRand2<=46)){s = "nw_it_sparscr905";i = 1;}
else if((iRand2>=47)&&(iRand2<=47)){s = "x2_it_spdvscr901";i = 1;}
else if((iRand2>=48)&&(iRand2<=48)){s = "nw_it_sparscr908";i = 1;}
else if((iRand2>=49)&&(iRand2<=49)){s = "nw_it_sparscr902";i = 1;}
else if((iRand2>=50)&&(iRand2<=50)){s = "nw_it_sparscr912";i = 1;}
else if((iRand2>=51)&&(iRand2<=51)){s = "x2_it_spdvscr902";i = 1;}
else if((iRand2>=52)&&(iRand2<=52)){s = "nw_it_sparscr906";i = 1;}
else if((iRand2>=53)&&(iRand2<=53)){s = "nw_it_sparscr901";i = 1;}
else if((iRand2>=54)&&(iRand2<=54)){s = "nw_it_sparscr903";i = 1;}
else if((iRand2>=55)&&(iRand2<=55)){s = "nw_it_sparscr910";i = 1;}
else if((iRand2>=56)&&(iRand2<=56)){s = "x2_it_spdvscr903";i = 1;}
else if((iRand2>=57)&&(iRand2<=57)){s = "nw_it_sparscr904";i = 1;}
else if((iRand2>=58)&&(iRand2<=58)){s = "nw_it_sparscr911";i = 1;}
else if((iRand2>=59)&&(iRand2<=59)){s = "x1_it_spdvscr901";i = 1;}
else if((iRand2>=60)&&(iRand2<=60)){s = "nw_it_sparscr909";i = 1;}
else if((iRand2>=61)&&(iRand2<=61)){s = "nw_it_sparscr907";i = 1;}
else if((iRand2>=62)&&(iRand2<=62)){s = "cr_diamond";i = 1;}
else if((iRand2>=63)&&(iRand2<=65)){s = "key005";i = 1;}
else if((iRand2>=66)&&(iRand2<=68)){s = "key006";i = 1;}
// Raise
else if((iRand2>=69)&&(iRand2<=73)){s = "cr_raisedead";i = 1;}
////////////////////////////////////////////////////////////////////////////////
oItem = CreateItemOnObject(s,OBJECT_SELF,i);SetLocalInt(oItem,"DontSave",1);}
oItem = CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(501)+500);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}}}
////////////////////////////////////////////////////////////////////////////////
}
