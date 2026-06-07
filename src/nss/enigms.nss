#include "aps_include"
#include "dmfi_dmw_inc"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastUsedBy();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sName = GetName(oPC);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iAreaX = GetAreaSize(AREA_WIDTH,oArea)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,oArea)*10;
string sX = IntToString(FloatToInt(GetPosition(OBJECT_SELF).x));
string sY = IntToString(FloatToInt(GetPosition(OBJECT_SELF).y));
string sTot = GetPersistentString(oModule,sPlanet);
int iLevel = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&009&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&009&")))-FindSubString(sTot,"&008&")-5));if(iLevel<1){iLevel = GetFactionAverageLevel(oPC)/3;}if(iLevel<1){iLevel = 1;}
//
object oNullhuman;object oCre;object oNew;string sEnigm1;string sEnigm2;int iXPs;string sResult;int iButtons;int iSwitchs;
int i;int iR;int i1;int i2;int i3;int i4;int i5;int i6;int i7;int i8;int i9;int i10;int i11;int i12;int i13;int i14;int i15;int i16;int i17;int i18;int i19;int i20;int i21;int i22;int i23;int i24;int i25;int i26;int i27;int i28;int i29;int i30;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
int iEnigms = 5; // Enigms Categories
//
int iPCTries = GetLocalInt(oPC,sPlanet+sArea+sX+sY+"Try");
int iEnigmRun = GetLocalInt(OBJECT_SELF,"EnigmRun");
string sEnigms = GetLocalString(OBJECT_SELF,"Var");
int iEnigm1 = StringToInt(GetStringLeft(sEnigms,FindSubString(sEnigms,"_")));
int iEnigm2 = StringToInt(GetStringRight(sEnigms,GetStringLength(sEnigms)-FindSubString(sEnigms,"_")-1));
//
if(sEnigms==""){if(GetTag(OBJECT_SELF)=="enigmmaker"){iEnigm1 = Random(iEnigms-2)+1;}else{iEnigm1 = Random(iEnigms)+1;}}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
if(iEnigmRun!=1)
 {
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Math
if(iEnigm1==1)
  {
if(sEnigms==""){iEnigm2 = Random(4)+1;} // Enigms Number
////////////////////////////////////////////////////////////////////////////////
// Reach the number
if(iEnigm2==1)
   {
i1 = Random(7)+3;
i2 = Random(7)+3;while(i2==i1){i2 = Random(7)+3;}
i3 = Random(7)+3;while((i3==i1)||(i3==i2)){i3 = Random(7)+3;}
i10 = Random(6)+1;if(i10==1){i4 = i1;i5 = i2;i6 = i3;}else if(i10==2){i4 = i1;i5 = i3;i6 = i2;}else if(i10==3){i4 = i2;i5 = i1;i6 = i3;}else if(i10==4){i4 = i2;i5 = i3;i6 = i1;}else if(i10==5){i4 = i3;i5 = i1;i6 = i2;}else if(i10==6){i4 = i3;i5 = i2;i6 = i1;}
i11 = Random(9)+1;
     if(i11==1){iR = i4+i5+i6;}
else if(i11==2){iR = i4+i5-i6;}
else if(i11==3){iR = i4+i5*i6;}
else if(i11==4){iR = i4-i5+i6;}
else if(i11==5){iR = i4-i5-i6;}
else if(i11==6){iR = i4-i5*i6;}
else if(i11==7){iR = i4*i5+i6;}
else if(i11==8){iR = i4*i5-i6;}
else if(i11==9){iR = i4*i5*i6;}
//
iXPs = 15;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Mathematic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\nHow can you use following numbers :\n\n"+ColorText(IntToString(i1),"g")+ColorText(" - ","w")+ColorText(IntToString(i2),"g")+ColorText(" - ","w")+ColorText(IntToString(i3),"g")+ColorText("\n\nto reach following result (use all numbers and only '+','-' or '*', no bracket) :\n\n","w")+ColorText(IntToString(iR),"g")+ColorText(" ?","w");
sResult = IntToString(iR);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
SetLocalString(OBJECT_SELF,"Number1",IntToString(i1));SetLocalString(OBJECT_SELF,"Number2",IntToString(i2));SetLocalString(OBJECT_SELF,"Number3",IntToString(i3));
   }
////////////////////////////////////////////////////////////////////////////////
// Reach the number
else if(iEnigm2==2)
   {
i1 = Random(7)+3;
i2 = Random(7)+3;while(i2==i1){i2 = Random(7)+3;}
i3 = Random(7)+3;while((i3==i1)||(i3==i2)){i3 = Random(7)+3;}
i4 = Random(7)+3;while((i4==i1)||(i4==i2)||(i4==i3)){i4 = Random(7)+3;}
i10 = Random(24)+1;if(i10==1){i5 = i1;i6 = i2;i7 = i3;i8 = i4;}else if(i10==2){i5 = i1;i6 = i2;i7 = i4;i8 = i3;}else if(i10==3){i5 = i1;i6 = i3;i7 = i2;i8 = i4;}else if(i10==4){i5 = i1;i6 = i3;i7 = i4;i8 = i2;}else if(i10==5){i5 = i1;i6 = i4;i7 = i2;i8 = i3;}else if(i10==6){i5 = i1;i6 = i4;i7 = i3;i8 = i2;}else if(i10==7){i5 = i2;i6 = i1;i7 = i3;i8 = i4;}else if(i10==8){i5 = i2;i6 = i1;i7 = i4;i8 = i3;}else if(i10==9){i5 = i2;i6 = i3;i7 = i1;i8 = i4;}else if(i10==10){i5 = i2;i6 = i3;i7 = i4;i8 = i1;}else if(i10==11){i5 = i2;i6 = i4;i7 = i1;i8 = i3;}else if(i10==12){i5 = i2;i6 = i4;i7 = i3;i8 = i1;}else if(i10==13){i5 = i3;i6 = i1;i7 = i2;i8 = i4;}else if(i10==14){i5 = i3;i6 = i1;i7 = i4;i8 = i2;}else if(i10==15){i5 = i3;i6 = i2;i7 = i1;i8 = i4;}else if(i10==16){i5 = i3;i6 = i2;i7 = i4;i8 = i1;}else if(i10==17){i5 = i3;i6 = i4;i7 = i1;i8 = i2;}else if(i10==18){i5 = i3;i6 = i4;i7 = i2;i8 = i1;}else if(i10==19){i5 = i4;i6 = i1;i7 = i2;i8 = i3;}else if(i10==20){i5 = i4;i6 = i1;i7 = i3;i8 = i2;}else if(i10==21){i5 = i4;i6 = i2;i7 = i1;i8 = i3;}else if(i10==22){i5 = i4;i6 = i2;i7 = i3;i8 = i1;}else if(i10==23){i5 = i4;i6 = i3;i7 = i1;i8 = i2;}else if(i10==24){i5 = i4;i6 = i3;i7 = i2;i8 = i1;}
i11 = Random(27)+1;
     if(i11==1){iR = i5+i6+i7+i8;}
else if(i11==2){iR = i5+i6+i7-i8;}
else if(i11==3){iR = i5+i6+i7*i8;}
else if(i11==4){iR = i5+i6-i7+i8;}
else if(i11==5){iR = i5+i6-i7-i8;}
else if(i11==6){iR = i5+i6-i7*i8;}
else if(i11==7){iR = i5+i6*i7+i8;}
else if(i11==8){iR = i5+i6*i7-i8;}
else if(i11==9){iR = i5+i6*i7*i8;}
else if(i11==10){iR = i5-i6+i7+i8;}
else if(i11==11){iR = i5-i6+i7-i8;}
else if(i11==12){iR = i5-i6+i7*i8;}
else if(i11==13){iR = i5-i6-i7+i8;}
else if(i11==14){iR = i5-i6-i7-i8;}
else if(i11==15){iR = i5-i6-i7*i8;}
else if(i11==16){iR = i5-i6*i7+i8;}
else if(i11==17){iR = i5-i6*i7-i8;}
else if(i11==18){iR = i5-i6*i7*i8;}
else if(i11==19){iR = i5*i6+i7+i8;}
else if(i11==20){iR = i5*i6+i7-i8;}
else if(i11==21){iR = i5*i6+i7*i8;}
else if(i11==22){iR = i5*i6-i7+i8;}
else if(i11==23){iR = i5*i6-i7-i8;}
else if(i11==24){iR = i5*i6-i7*i8;}
else if(i11==25){iR = i5*i6*i7+i8;}
else if(i11==26){iR = i5*i6*i7-i8;}
else if(i11==27){iR = i5*i6*i7*i8;}
//
iXPs = 40;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Mathematic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\nHow can you use following numbers :\n\n"+ColorText(IntToString(i1),"g")+ColorText(" - ","w")+ColorText(IntToString(i2),"g")+ColorText(" - ","w")+ColorText(IntToString(i3),"g")+ColorText(" - ","w")+ColorText(IntToString(i4),"g")+ColorText("\n\nto reach following result (use all numbers and only '+','-' or '*', no bracket) :\n\n","w")+ColorText(IntToString(iR),"g")+ColorText(" ?","w");
sResult = IntToString(iR);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
SetLocalString(OBJECT_SELF,"Number1",IntToString(i1));SetLocalString(OBJECT_SELF,"Number2",IntToString(i2));SetLocalString(OBJECT_SELF,"Number3",IntToString(i3));SetLocalString(OBJECT_SELF,"Number4",IntToString(i4));
   }
////////////////////////////////////////////////////////////////////////////////
// Find the serie
else if(iEnigm2==3)
   {
i9 = Random(5)+2;
i10 = Random(5)+2;while(i10==i9){i10 = Random(5)+2;}

i1 = Random(9)+2;
i2 = i1+(i9*i1);
i3 = i2+(i10*i1);
i4 = Random(9)+2;while(i4==i1){i4 = Random(9)+2;}
i5 = i4+(i9*i4);
i6 = i5+(i10*i4);
i7 = Random(9)+2;while((i7==i1)||(i7==i4)){i7 = Random(9)+2;}
i8 = i7+(i9*i7);
iR = i8+(i10*i7);
//
iXPs = 15;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Mathematic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\n"+ColorText("First serie : "+IntToString(i1)+" - "+IntToString(i2)+" - "+IntToString(i3)+"\nSecond serie : "+IntToString(i4)+" - "+IntToString(i5)+" - "+IntToString(i6)+"\nThird serie : "+IntToString(i7)+" - "+IntToString(i8)+" - ...","g")+"\nWhat is the third number of the third serie ?";
sResult = IntToString(iR);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
// Math
// Find the serie
else if(iEnigm2==4)
   {
i9 = Random(7)+3;
i10 = Random(7)+3;while(i10==i9){i10 = Random(7)+3;}

i1 = Random(9)+2;
i2 = (i9*i1)+(i9*i1);
i3 = (i10*i1)+(i10*i1);
i4 = Random(9)+2;while(i4==i1){i4 = Random(9)+2;}
i5 = (i9*i4)+(i9*i4);
i6 = (i10*i4)+(i10*i4);
i7 = Random(9)+2;while((i7==i1)||(i7==i4)){i7 = Random(9)+2;}
i8 = (i9*i7)+(i9*i7);
iR = (i10*i7)+(i10*i7);
//
iXPs = 30;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Mathematic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\n"+ColorText("First serie : "+IntToString(i1)+" - "+IntToString(i2)+" - "+IntToString(i3)+"\nSecond serie : "+IntToString(i4)+" - "+IntToString(i5)+" - "+IntToString(i6)+"\nThird serie : "+IntToString(i7)+" - "+IntToString(i8)+" - ...","g")+"\nWhat is the third number of the third serie ?";
sResult = IntToString(iR);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
  }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Logic
else if(iEnigm1==2)
  {
if(sEnigms==""){iEnigm2 = Random(6)+1;} // Enigms Number
if(GetTag(OBJECT_SELF)=="enigmmaker"){iEnigm2 = Random(4)+1;}
////////////////////////////////////////////////////////////////////////////////
// Find the answer
if(iEnigm2<3)
   {
i1 = Random(16)+15;
i2 = Random(3)+3;
i3 = 1;

iXPs = 40;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Logic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\n"+ColorText("A dungeon has "+IntToString(i1)+" closed doors. Each time you open "+IntToString(i2)+" doors, it closes "+IntToString(i3)+" other doors.\n\nHow many doors shall you open to have none closed ?","g");
while((i1>0)&&(i1>=i2)){i1 = i1-i2+i3;iR = iR+i2;}iR = iR+i1;
sResult = IntToString(iR);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
// Find the answer
else if(iEnigm2<5)
   {
i1 = Random(21)+20;
i2 = Random(2)+3;
i3 = 2;

iXPs = 50;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Logic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\n"+ColorText("A dungeon has "+IntToString(i1)+" closed doors. Each time you open "+IntToString(i2)+" doors, it closes "+IntToString(i3)+" other doors.\n\nHow many doors shall you open to have none closed ?","g");
while((i1>0)&&(i1>=i2)){i1 = i1-i2+i3;iR = iR+i2;}iR = iR+i1;
sResult = IntToString(iR);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
// Find the answer
else if(iEnigm2==5)
   {
iButtons = 7; // Number of buttons and lights
iSwitchs = 3; // Lights switched by buttons

i1 = 1;i2 = Random(iButtons)+1;i3 = Random(iButtons)+1;SetLocalString(OBJECT_SELF,"Button1",IntToString(i1)+"&001&"+IntToString(i2)+"&002&"+IntToString(i3)+"&003&");
i4 = 2;i5 = Random(iButtons)+1;i6 = Random(iButtons)+1;SetLocalString(OBJECT_SELF,"Button2",IntToString(i4)+"&001&"+IntToString(i5)+"&002&"+IntToString(i6)+"&003&");
i7 = 3;i8 = Random(iButtons)+1;i9 = Random(iButtons)+1;SetLocalString(OBJECT_SELF,"Button3",IntToString(i7)+"&001&"+IntToString(i8)+"&002&"+IntToString(i9)+"&003&");
i10 = 4;i11 = Random(iButtons)+1;i12 = Random(iButtons)+1;SetLocalString(OBJECT_SELF,"Button4",IntToString(i10)+"&001&"+IntToString(i11)+"&002&"+IntToString(i12)+"&003&");
i13 = 5;i14 = Random(iButtons)+1;i15 = Random(iButtons)+1;SetLocalString(OBJECT_SELF,"Button5",IntToString(i13)+"&001&"+IntToString(i14)+"&002&"+IntToString(i15)+"&003&");
i16 = 6;i17 = Random(iButtons)+1;i18 = Random(iButtons)+1;SetLocalString(OBJECT_SELF,"Button6",IntToString(i16)+"&001&"+IntToString(i17)+"&002&"+IntToString(i18)+"&003&");
i19 = 7;i20 = Random(iButtons)+1;i21 = Random(iButtons)+1;SetLocalString(OBJECT_SELF,"Button7",IntToString(i19)+"&001&"+IntToString(i20)+"&002&"+IntToString(i21)+"&003&");

iXPs = 100;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Logic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\nThere are "+IntToString(iButtons)+" buttons and "+IntToString(iButtons)+" lights on a wall. Each time you push a button, it switches "+IntToString(iSwitchs)+" lights. You have to lights on all the lights, knowing that following buttons switch following lights:\n\nButton 1 : "+ColorText(IntToString(i1),"c")+ColorText(" - ","w")+ColorText(IntToString(i2),"c")+ColorText(" - ","w")+ColorText(IntToString(i3),"c")+"\nButton 2 : "+ColorText(IntToString(i4),"c")+ColorText(" - ","w")+ColorText(IntToString(i5),"c")+ColorText(" - ","w")+ColorText(IntToString(i6),"c")+"\nButton 3 : "+ColorText(IntToString(i7),"c")+ColorText(" - ","w")+ColorText(IntToString(i8),"c")+ColorText(" - ","w")+ColorText(IntToString(i9),"c")+"\nButton 4 : "+ColorText(IntToString(i10),"c")+ColorText(" - ","w")+ColorText(IntToString(i11),"c")+ColorText(" - ","w")+ColorText(IntToString(i12),"c")+"\nButton 5 : "+ColorText(IntToString(i13),"c")+ColorText(" - ","w")+ColorText(IntToString(i14),"c")+ColorText(" - ","w")+ColorText(IntToString(i15),"c")+"\nButton 6 : "+ColorText(IntToString(i16),"c")+ColorText(" - ","w")+ColorText(IntToString(i17),"c")+ColorText(" - ","w")+ColorText(IntToString(i18),"c")+"\nButton 7 : "+ColorText(IntToString(i19),"c")+ColorText(" - ","w")+ColorText(IntToString(i20),"c")+ColorText(" - ","w")+ColorText(IntToString(i21),"c")+"\n\n"+ColorText("O O O O O O O","r")+ColorText("\n\nWhich button do you push ?\n\nType in your answer and click OK.","w");
sResult = "Buttons"+IntToString(i22);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
SetLocalInt(OBJECT_SELF,"Buttons",iButtons);DeleteLocalInt(OBJECT_SELF,"Light1");DeleteLocalInt(OBJECT_SELF,"Light2");DeleteLocalInt(OBJECT_SELF,"Light3");DeleteLocalInt(OBJECT_SELF,"Light4");DeleteLocalInt(OBJECT_SELF,"Light5");DeleteLocalInt(OBJECT_SELF,"Light6");DeleteLocalInt(OBJECT_SELF,"Light7");
   }
////////////////////////////////////////////////////////////////////////////////
// Find the answer
else if(iEnigm2==6)
   {
iButtons = 7; // Number of buttons and lights
iSwitchs = 4; // Lights switched by buttons

i1 = 1;i2 = Random(iButtons)+1;i3 = Random(iButtons)+1;i4 = Random(iButtons+1);SetLocalString(OBJECT_SELF,"Button1",IntToString(i1)+"&001&"+IntToString(i2)+"&002&"+IntToString(i3)+"&003&"+IntToString(i4)+"&004&");
i5 = 2;i6 = Random(iButtons)+1;i7 = Random(iButtons)+1;i8 = Random(iButtons+1);SetLocalString(OBJECT_SELF,"Button2",IntToString(i5)+"&001&"+IntToString(i6)+"&002&"+IntToString(i7)+"&003&"+IntToString(i8)+"&004&");
i9 = 3;i10 = Random(iButtons)+1;i11 = Random(iButtons)+1;i12 = Random(iButtons+1);SetLocalString(OBJECT_SELF,"Button3",IntToString(i9)+"&001&"+IntToString(i10)+"&002&"+IntToString(i11)+"&003&"+IntToString(i12)+"&004&");
i13 = 4;i14 = Random(iButtons)+1;i15 = Random(iButtons)+1;i16 = Random(iButtons+1);SetLocalString(OBJECT_SELF,"Button4",IntToString(i13)+"&001&"+IntToString(i14)+"&002&"+IntToString(i15)+"&003&"+IntToString(i16)+"&004&");
i17 = 5;i18 = Random(iButtons)+1;i19 = Random(iButtons)+1;i20 = Random(iButtons+1);SetLocalString(OBJECT_SELF,"Button5",IntToString(i17)+"&001&"+IntToString(i18)+"&002&"+IntToString(i19)+"&003&"+IntToString(i20)+"&004&");
i21 = 6;i22 = Random(iButtons)+1;i23 = Random(iButtons)+1;i24 = Random(iButtons+1);SetLocalString(OBJECT_SELF,"Button6",IntToString(i21)+"&001&"+IntToString(i22)+"&002&"+IntToString(i23)+"&003&"+IntToString(i24)+"&004&");
i25 = 7;i26 = Random(iButtons)+1;i27 = Random(iButtons)+1;i28 = Random(iButtons+1);SetLocalString(OBJECT_SELF,"Button7",IntToString(i25)+"&001&"+IntToString(i26)+"&002&"+IntToString(i27)+"&003&"+IntToString(i28)+"&004&");

iXPs = 200;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Logic puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\nThere are "+IntToString(iButtons)+" buttons and "+IntToString(iButtons)+" lights on a wall. Each time you push a button, it switches "+IntToString(iSwitchs)+" lights. You have to lights on all the lights, knowing that following buttons switch following lights:\n\nButton 1 : "+ColorText(IntToString(i1),"c")+ColorText(" - ","w")+ColorText(IntToString(i2),"c")+ColorText(" - ","w")+ColorText(IntToString(i3),"c")+ColorText(" - ","w")+ColorText(IntToString(i4),"c")+"\nButton 2 : "+ColorText(IntToString(i5),"c")+ColorText(" - ","w")+ColorText(IntToString(i6),"c")+ColorText(" - ","w")+ColorText(IntToString(i7),"c")+ColorText(" - ","w")+ColorText(IntToString(i8),"c")+"\nButton 3 : "+ColorText(IntToString(i9),"c")+ColorText(" - ","w")+ColorText(IntToString(i10),"c")+ColorText(" - ","w")+ColorText(IntToString(i11),"c")+ColorText(" - ","w")+ColorText(IntToString(i12),"c")+"\nButton 4 : "+ColorText(IntToString(i13),"c")+ColorText(" - ","w")+ColorText(IntToString(i14),"c")+ColorText(" - ","w")+ColorText(IntToString(i15),"c")+ColorText(" - ","w")+ColorText(IntToString(i16),"c")+"\nButton 5 : "+ColorText(IntToString(i17),"c")+ColorText(" - ","w")+ColorText(IntToString(i18),"c")+ColorText(" - ","w")+ColorText(IntToString(i19),"c")+ColorText(" - ","w")+ColorText(IntToString(i20),"c")+"\nButton 6 : "+ColorText(IntToString(i21),"c")+ColorText(" - ","w")+ColorText(IntToString(i22),"c")+ColorText(" - ","w")+ColorText(IntToString(i23),"c")+ColorText(" - ","w")+ColorText(IntToString(i24),"c")+"\nButton 7 : "+ColorText(IntToString(i25),"c")+ColorText(" - ","w")+ColorText(IntToString(i26),"c")+ColorText(" - ","w")+ColorText(IntToString(i27),"c")+ColorText(" - ","w")+ColorText(IntToString(i28),"c")+"\n\n"+ColorText("O O O O O O O","r")+ColorText("\n\nWhich button do you push ?\n\nType in your answer and click OK.","w");
sResult = "Buttons"+IntToString(i22);
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
SetLocalInt(OBJECT_SELF,"Buttons",iButtons);DeleteLocalInt(OBJECT_SELF,"Light1");DeleteLocalInt(OBJECT_SELF,"Light2");DeleteLocalInt(OBJECT_SELF,"Light3");DeleteLocalInt(OBJECT_SELF,"Light4");DeleteLocalInt(OBJECT_SELF,"Light5");DeleteLocalInt(OBJECT_SELF,"Light6");DeleteLocalInt(OBJECT_SELF,"Light7");
   }
////////////////////////////////////////////////////////////////////////////////
  }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Monsters
else if(iEnigm1==3)
  {
if(sEnigms==""){iEnigm2 = Random(2)+1;} // Enigms Number
////////////////////////////////////////////////////////////////////////////////
// Kill 1 monster
if(iEnigm2==1)
   {
     if(iLevel==1){sResult = "mn_goblin011";sEnigm2 = "Goblin";iXPs = 10;}
else if(iLevel==2){sResult = "mn_orc011";sEnigm2 = "Orc";iXPs = 20;}
else if(iLevel==3){sResult = "mn_ogre005";sEnigm2 = "Ogre";iXPs = 30;}
else if(iLevel==4){sResult = "mn_giant002";sEnigm2 = "Giant";iXPs = 50;}
else if(iLevel==5){sResult = "mn_gorochem003";sEnigm2 = "Gorochem";iXPs = 100;}
else if(iLevel==6){sResult = "mn_vampire008";sEnigm2 = "Vampire";iXPs = 200;}
else if(iLevel==7){sResult = "mn_marilith001";sEnigm2 = "Marilith";iXPs = 300;}
else if(iLevel==8){sResult = "mn_golem002";sEnigm2 = "Golem";iXPs = 400;}
else if(iLevel==9){sResult = "mn_dragoneni002";sEnigm2 = "Dragon";iXPs = 500;}

sEnigm1 = "[Spirit of the item]: "+ColorText("Combat puzzle ("+IntToString(iXPs)+" XPs)","g")+" against a "+ColorText(sEnigm2,"g")+". Are you ready to solve it ?";
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
// Kill 1 monster
else if(iEnigm2==2)
   {
     if(iLevel==1){sResult = "mn_goblin009";sEnigm2 = "Goblin";iXPs = 15;}
else if(iLevel==2){sResult = "mn_orc003";sEnigm2 = "Orc";iXPs = 25;}
else if(iLevel==3){sResult = "mn_ogre007";sEnigm2 = "Ogre";iXPs = 40;}
else if(iLevel==4){sResult = "mn_giant004";sEnigm2 = "Giant";iXPs = 60;}
else if(iLevel==5){sResult = "mn_gorochem004";sEnigm2 = "Gorochem";iXPs = 120;}
else if(iLevel==6){sResult = "mn_vampire007";sEnigm2 = "Vampire";iXPs = 240;}
else if(iLevel==7){sResult = "mn_balrog002";sEnigm2 = "Balrog";iXPs = 360;}
else if(iLevel==8){sResult = "mn_golem001";sEnigm2 = "Golem";iXPs = 480;}
else if(iLevel==9){sResult = "mn_dragoneni001";sEnigm2 = "Dragon";iXPs = 600;}

sEnigm1 = "[Spirit of the item]: "+ColorText("Combat puzzle ("+IntToString(iXPs)+" XPs)","g")+" against a "+ColorText(sEnigm2,"g")+". Are you ready to solve it ?";
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
  }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Find lost items
else if(iEnigm1==4)
  {
if(sEnigms==""){iEnigm2 = Random(2)+1;} // Enigms Number
////////////////////////////////////////////////////////////////////////////////
// Find 5 items
if(iEnigm2==1)
   {
i1 = 5;

i2 = Random(5)+1;
     if(i2==1){sResult = "nw_it_torch001";sEnigm2 = IntToString(i1)+" Torches";}
else if(i2==2){sResult = "nw_it_mpotion021";sEnigm2 = IntToString(i1)+" Ales";}
else if(i2==3){sResult = "bedroll";sEnigm2 = IntToString(i1)+" Bed Rolls";}
else if(i2==4){sResult = "cr_gem006";sEnigm2 = IntToString(i1)+" Fire Agates";}
else if(i2==5){sResult = "nw_arhe001";sEnigm2 = IntToString(i1)+" Pot Helmets";}

iXPs = 25;
sEnigm1 = "[Spirit of the item]: "+ColorText("Search puzzle ("+IntToString(iXPs)+" XPs)","g")+" find "+ColorText(sEnigm2,"g")+". Are you ready to solve it ?";
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
SetLocalInt(OBJECT_SELF,"Items",i1);
   }
////////////////////////////////////////////////////////////////////////////////
// Find 10 items
else if(iEnigm2==2)
   {
i1 = 10;

i2 = Random(5)+1;
     if(i2==1){sResult = "nw_it_torch001";sEnigm2 = IntToString(i1)+" Torches";}
else if(i2==2){sResult = "nw_it_mpotion021";sEnigm2 = IntToString(i1)+" Ales";}
else if(i2==3){sResult = "bedroll";sEnigm2 = IntToString(i1)+" Bed Rolls";}
else if(i2==4){sResult = "cr_gem006";sEnigm2 = IntToString(i1)+" Fire Agates";}
else if(i2==5){sResult = "nw_arhe001";sEnigm2 = IntToString(i1)+" Pot Helmets";}

iXPs = 50;
sEnigm1 = "[Spirit of the item]: "+ColorText("Search puzzle ("+IntToString(iXPs)+" XPs)","g")+" find "+ColorText(sEnigm2,"g")+". Are you ready to solve it ?";
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
SetLocalInt(OBJECT_SELF,"Items",i1);
   }
////////////////////////////////////////////////////////////////////////////////
  }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Code enigms
else if(iEnigm1==5)
  {
if(sEnigms==""){iEnigm2 = Random(2)+1;} // Enigms Number
////////////////////////////////////////////////////////////////////////////////
// Number code
if(iEnigm2==1)
   {
i1 = Random(99990)+10; // Code number
i2 = 5;               // Code letters number

if(GetLocalString(OBJECT_SELF,"CodeN")!=""){i1 = StringToInt(GetLocalString(OBJECT_SELF,"CodeN"));sResult = GetLocalString(OBJECT_SELF,"Result");}else{iPCTries = iPCTries-1;
while(i<i2){i++;i3 = Random(52)+1;if(i3==1){sEnigm2 = "a";}else if(i3==2){sEnigm2 = "b";}else if(i3==3){sEnigm2 = "c";}else if(i3==4){sEnigm2 = "d";}else if(i3==5){sEnigm2 = "e";}else if(i3==6){sEnigm2 = "f";}else if(i3==7){sEnigm2 = "g";}else if(i3==8){sEnigm2 = "h";}else if(i3==9){sEnigm2 = "i";}else if(i3==10){sEnigm2 = "j";}else if(i3==11){sEnigm2 = "k";}else if(i3==12){sEnigm2 = "l";}else if(i3==13){sEnigm2 = "m";}else if(i3==14){sEnigm2 = "n";}else if(i3==15){sEnigm2 = "o";}else if(i3==16){sEnigm2 = "p";}else if(i3==17){sEnigm2 = "q";}else if(i3==18){sEnigm2 = "r";}else if(i3==19){sEnigm2 = "s";}else if(i3==20){sEnigm2 = "t";}else if(i3==21){sEnigm2 = "u";}else if(i3==22){sEnigm2 = "v";}else if(i3==23){sEnigm2 = "w";}else if(i3==24){sEnigm2 = "x";}else if(i3==25){sEnigm2 = "y";}else if(i3==26){sEnigm2 = "z";}else if(i3==27){sEnigm2 = "A";}else if(i3==28){sEnigm2 = "B";}else if(i3==29){sEnigm2 = "C";}else if(i3==30){sEnigm2 = "D";}else if(i3==31){sEnigm2 = "E";}else if(i3==32){sEnigm2 = "F";}else if(i3==33){sEnigm2 = "G";}else if(i3==34){sEnigm2 = "H";}else if(i3==35){sEnigm2 = "I";}else if(i3==36){sEnigm2 = "J";}else if(i3==37){sEnigm2 = "K";}else if(i3==38){sEnigm2 = "L";}else if(i3==39){sEnigm2 = "M";}else if(i3==40){sEnigm2 = "N";}else if(i3==41){sEnigm2 = "O";}else if(i3==42){sEnigm2 = "P";}else if(i3==43){sEnigm2 = "Q";}else if(i3==44){sEnigm2 = "R";}else if(i3==45){sEnigm2 = "S";}else if(i3==46){sEnigm2 = "T";}else if(i3==47){sEnigm2 = "U";}else if(i3==48){sEnigm2 = "V";}else if(i3==49){sEnigm2 = "W";}else if(i3==50){sEnigm2 = "X";}else if(i3==51){sEnigm2 = "Y";}else if(i3==52){sEnigm2 = "Z";}sResult = sResult+sEnigm2;}
oCre = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",Location(oArea,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0));oNew = CreateObject(OBJECT_TYPE_ITEM,"code",GetLocation(oCre));DestroyObject(oCre);SetLocalInt(oNew,"DontSave",1);SetLocalInt(oNew,"Enigm",i1);SetLocalString(oNew,"EnigmResult",sResult);SetLocalString(OBJECT_SELF,"CodeN",IntToString(i1));SetLocalObject(OBJECT_SELF,"Code",oNew);}

iXPs = 20;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Code puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\nEnter following code :\n"+ColorText(IntToString(i1),"g");
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
// Signs code
if(iEnigm2==2)
   {
i1 = 9; // Code signs number
i2 = 5; // Code letters number

if(GetLocalString(OBJECT_SELF,"CodeN")!=""){i1 = StringToInt(GetLocalString(OBJECT_SELF,"CodeN"));sResult = GetLocalString(OBJECT_SELF,"Result");}else{iPCTries = iPCTries-1;
while(i<i1){i++;i3 = Random(6)+1;if(i3==1){sEnigm2 = "#";}else if(i3==2){sEnigm2 = "%";}else if(i3==3){sEnigm2 = "&";}else if(i3==4){sEnigm2 = "/";}else if(i3==5){sEnigm2 = "<";}else if(i3==6){sEnigm2 = ">";}SetLocalString(OBJECT_SELF,"EnigmSigns"+IntToString(i),sEnigm2);}i=0;
while(i<i2){i++;i3 = Random(52)+1;if(i3==1){sEnigm2 = "a";}else if(i3==2){sEnigm2 = "b";}else if(i3==3){sEnigm2 = "c";}else if(i3==4){sEnigm2 = "d";}else if(i3==5){sEnigm2 = "e";}else if(i3==6){sEnigm2 = "f";}else if(i3==7){sEnigm2 = "g";}else if(i3==8){sEnigm2 = "h";}else if(i3==9){sEnigm2 = "i";}else if(i3==10){sEnigm2 = "j";}else if(i3==11){sEnigm2 = "k";}else if(i3==12){sEnigm2 = "l";}else if(i3==13){sEnigm2 = "m";}else if(i3==14){sEnigm2 = "n";}else if(i3==15){sEnigm2 = "o";}else if(i3==16){sEnigm2 = "p";}else if(i3==17){sEnigm2 = "q";}else if(i3==18){sEnigm2 = "r";}else if(i3==19){sEnigm2 = "s";}else if(i3==20){sEnigm2 = "t";}else if(i3==21){sEnigm2 = "u";}else if(i3==22){sEnigm2 = "v";}else if(i3==23){sEnigm2 = "w";}else if(i3==24){sEnigm2 = "x";}else if(i3==25){sEnigm2 = "y";}else if(i3==26){sEnigm2 = "z";}else if(i3==27){sEnigm2 = "A";}else if(i3==28){sEnigm2 = "B";}else if(i3==29){sEnigm2 = "C";}else if(i3==30){sEnigm2 = "D";}else if(i3==31){sEnigm2 = "E";}else if(i3==32){sEnigm2 = "F";}else if(i3==33){sEnigm2 = "G";}else if(i3==34){sEnigm2 = "H";}else if(i3==35){sEnigm2 = "I";}else if(i3==36){sEnigm2 = "J";}else if(i3==37){sEnigm2 = "K";}else if(i3==38){sEnigm2 = "L";}else if(i3==39){sEnigm2 = "M";}else if(i3==40){sEnigm2 = "N";}else if(i3==41){sEnigm2 = "O";}else if(i3==42){sEnigm2 = "P";}else if(i3==43){sEnigm2 = "Q";}else if(i3==44){sEnigm2 = "R";}else if(i3==45){sEnigm2 = "S";}else if(i3==46){sEnigm2 = "T";}else if(i3==47){sEnigm2 = "U";}else if(i3==48){sEnigm2 = "V";}else if(i3==49){sEnigm2 = "W";}else if(i3==50){sEnigm2 = "X";}else if(i3==51){sEnigm2 = "Y";}else if(i3==52){sEnigm2 = "Z";}sResult = sResult+sEnigm2;}
oCre = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",Location(oArea,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0));oNew = CreateObject(OBJECT_TYPE_ITEM,"code",GetLocation(oCre));DestroyObject(oCre);SetLocalInt(oNew,"DontSave",1);SetLocalInt(oNew,"Enigm",1);SetLocalString(oNew,"EnigmSigns",sEnigms);SetLocalString(oNew,"EnigmResult",sResult);i=0;while(i<9){i++;SetLocalString(oNew,"EnigmSigns"+IntToString(i),GetLocalString(OBJECT_SELF,"EnigmSigns"+IntToString(i)));}SetLocalString(OBJECT_SELF,"CodeN",IntToString(i1));SetLocalObject(OBJECT_SELF,"Code",oNew);}

iXPs = 30;
sEnigm1 = "[Spirit of the item]:\n"+ColorText("Code puzzle ("+IntToString(iXPs)+" XPs)","g")+".\nAre you ready to solve it ?";
sEnigm2 = "[Spirit of the item]:\n\nEnter following code :\n\n"+ColorText(GetLocalString(OBJECT_SELF,"EnigmSigns1")+" "+GetLocalString(OBJECT_SELF,"EnigmSigns2")+" "+GetLocalString(OBJECT_SELF,"EnigmSigns3")+"\n"+GetLocalString(OBJECT_SELF,"EnigmSigns4")+" "+GetLocalString(OBJECT_SELF,"EnigmSigns5")+" "+GetLocalString(OBJECT_SELF,"EnigmSigns6")+"\n"+GetLocalString(OBJECT_SELF,"EnigmSigns7")+" "+GetLocalString(OBJECT_SELF,"EnigmSigns8")+" "+GetLocalString(OBJECT_SELF,"EnigmSigns9"),"g");
sEnigms = IntToString(iEnigm1)+"_"+IntToString(iEnigm2);
   }
////////////////////////////////////////////////////////////////////////////////
  }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
SetCustomToken(10401,sEnigm1);
SetLocalString(OBJECT_SELF,"Var",sEnigms);
SetLocalString(OBJECT_SELF,"Result",sResult);
SetLocalInt(OBJECT_SELF,"XPs",iXPs);
DeleteLocalInt(oPC,"Tries");
//
 }
if(iPCTries>=3)
 {
FloatingTextStringOnCreature("You can't try any more",oPC);
 }
//
else
 {
if((iEnigm1==1)||(iEnigm1==2)||(iEnigm1==5))
  {
SetCustomToken(10402,sEnigm2);
  }
else if(iEnigm1==3)
  {
SetCustomToken(10402,"creature");
SetCustomToken(10403,"The creature is still alive !");
SetCustomToken(10404,"Congratulations. You killed the creature !");
  }
else if(iEnigm1==4)
  {
SetCustomToken(10402,"items");
SetCustomToken(10403,"There are still some lost items !");
SetCustomToken(10404,"Congratulations. You found all the items !");
  }
if((GetIsObjectValid(oPC))&&(!GetIsInCombat(oPC)))
  {
SetLocalInt(oPC,sPlanet+sArea+sX+sY+"Try",iPCTries+1);
oNullhuman = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",GetLocation(oPC));
SetLocalString(oNullhuman,"Var",sEnigms);
SetLocalObject(oNullhuman,"oEnigm",OBJECT_SELF);
// First
int a = 8;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
else{AssignCommand(oNullhuman,ActionStartConversation(oPC,"enigm",FALSE,FALSE));}
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
