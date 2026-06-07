////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastUsedBy();
object oWP = GetNearestObjectByTag("wp_teleporters7");
object oArea = GetArea(oWP);
string sAreaTag = GetTag(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
float fX = GetPosition(oWP).x;
float fY = GetPosition(oWP).y;
float fZ = 0.0;if(GetStringLeft(GetTag(oArea),8)=="tropical"){fZ = 1.0;}else if((GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")){fZ = 5.0;}
int iEnc = GetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Lever");
//
object oLever1 = GetNearestObjectByTag("lever1",oWP);
object oLever2 = GetNearestObjectByTag("lever2",oWP);
object oLever3 = GetNearestObjectByTag("lever3",oWP);
object oLever4 = GetNearestObjectByTag("lever4",oWP);
object oLever5 = GetNearestObjectByTag("lever5",oWP);
object oLever6 = GetNearestObjectByTag("lever6",oWP);
//
object oWP1 = GetNearestObjectByTag("wp_teleporters1",oWP);
object oWP2 = GetNearestObjectByTag("wp_teleporters2",oWP);
object oWP3 = GetNearestObjectByTag("wp_teleporters3",oWP);
object oWP4 = GetNearestObjectByTag("wp_teleporters4",oWP);
object oWP5 = GetNearestObjectByTag("wp_teleporters5",oWP);
object oWP6 = GetNearestObjectByTag("wp_teleporters6",oWP);
//
int iActivated = GetLocalInt(OBJECT_SELF,"Activated");
//
object oWPs;object oNew;int iCheck;int i1;int i2;int i3;int i4;int i5;int i6;int i7;int i;int a;int b;int c;int d;string sCombi1;string sCombi2;
////////////////////////////////////////////////////////////////////////////////
// Activations
if(iActivated==1){DeleteLocalInt(OBJECT_SELF,"Activated");ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);FloatingTextStringOnCreature("Lever unactivated",oPC);}else{SetLocalInt(OBJECT_SELF,"Activated",1);ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);FloatingTextStringOnCreature("Lever activated",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Initilalise challenge
////////////////////////////////////////////////////////////////////////////////
// Place teleporters
if(iEnc!=1)
 {
SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Lever",1);

while(i<7)
  {
i++;
oWPs = GetNearestObjectByTag("wp_teleporters"+IntToString(i),oWP);if(i==7){oWPs = oWP;}
fX = GetPosition(oWPs).x;
fY = GetPosition(oWPs).y;

oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+1.0,fY+1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+0.5,fY+1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+0.0,fY+1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX-0.5,fY+1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX-1.0,fY+1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+1.0,fY-1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+0.5,fY-1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+0.0,fY-1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX-0.5,fY-1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX-1.0,fY-1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+1.0,fY+0.5,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+1.0,fY+1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX+1.0,fY-0.5,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX-1.0,fY+0.5,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX-1.0,fY+1.0,fZ+0.0),DIRECTION_NORTH));
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_visual002",Location(oArea,Vector(fX-1.0,fY-0.5,fZ+0.0),DIRECTION_NORTH));
  }
FloatingTextStringOnCreature("Teleporters activated",oPC);
PlaySound("as_mg_telepin1");
i=0;
////////////////////////////////////////////////////////////////////////////////
// Find good combination
fX = GetPosition(oWP).x;
fY = GetPosition(oWP).y;
// Two activated levers
a = Random(6)+1;SetLocalInt(oWP,"Lever"+IntToString(a),1);i1 = a;
b = Random(6)+1;while(b==a){b = Random(6)+1;}SetLocalInt(oWP,"Lever"+IntToString(b),1);i2 = b;
// Two inversed levers
c = Random(6)+1;while((c==a)||(c==b)){c = Random(6)+1;}SetLocalInt(oWP,"Lever"+IntToString(c),1);i3 = c;
d = Random(6)+1;while((d==a)||(d==b)||(d==c)){d = Random(6)+1;}SetLocalInt(oWP,"Lever"+IntToString(d),2);i4 = d;
// Set instructions
SetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Ins","Challenge Instructions :\n\nLevers "+IntToString(i1)+" and "+IntToString(i2)+" you should activate,\nLevers "+IntToString(i3)+" and "+IntToString(i4)+" you should inverse,\nThe rest you should disperse,\nSo you may pass the grate.");
// Each lever
i1 = Random(2);if(GetLocalInt(oWP,"Lever1")==1){i1 = 1;}else if(GetLocalInt(oWP,"Lever1")==2){i1 = 0;}
i2 = Random(2);if(GetLocalInt(oWP,"Lever2")==1){i2 = 1;}else if(GetLocalInt(oWP,"Lever2")==2){i2 = 0;}
i3 = Random(2);if(GetLocalInt(oWP,"Lever3")==1){i3 = 1;}else if(GetLocalInt(oWP,"Lever3")==2){i3 = 0;}
i4 = Random(2);if(GetLocalInt(oWP,"Lever4")==1){i4 = 1;}else if(GetLocalInt(oWP,"Lever4")==2){i4 = 0;}
i5 = Random(2);if(GetLocalInt(oWP,"Lever5")==1){i5 = 1;}else if(GetLocalInt(oWP,"Lever5")==2){i5 = 0;}
i6 = Random(2);if(GetLocalInt(oWP,"Lever6")==1){i6 = 1;}else if(GetLocalInt(oWP,"Lever6")==2){i6 = 0;}

sCombi1 =IntToString(i1)+IntToString(i2)+IntToString(i3)+IntToString(i4)+IntToString(i5)+IntToString(i6);
// Record good combination
SetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Comb",sCombi1);
 }
////////////////////////////////////////////////////////////////////////////////
// For each lever activated or unactivated

// Check combination
i1 = GetLocalInt(oLever1,"Activated");
i2 = GetLocalInt(oLever2,"Activated");
i3 = GetLocalInt(oLever3,"Activated");
i4 = GetLocalInt(oLever4,"Activated");
i5 = GetLocalInt(oLever5,"Activated");
i6 = GetLocalInt(oLever6,"Activated");

sCombi1 =IntToString(i1)+IntToString(i2)+IntToString(i3)+IntToString(i4)+IntToString(i5)+IntToString(i6);
// Set teleporters combinations
sCombi2 = GetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+sCombi1);
// Combination does not already exist
if(sCombi2=="")
 {
// Good combination
if(sCombi1==GetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Comb"))
  {
i1=0;i2=0;i3=0;i4=0;i5=0;i6=0;i7=0;DeleteLocalInt(oWP,"TeleportTo1");DeleteLocalInt(oWP,"TeleportTo2");DeleteLocalInt(oWP,"TeleportTo3");DeleteLocalInt(oWP,"TeleportTo4");DeleteLocalInt(oWP,"TeleportTo5");DeleteLocalInt(oWP,"TeleportTo6");DeleteLocalInt(oWP,"TeleportTo7");

while(iCheck!=1)
   {
i1 = Random(7)+1;while((i1==7)||(i1==1)){i1 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i1),1);
i2 = Random(7)+1;while((i1==7)||(i2==2)||(i2==i1)||(GetLocalInt(oWP,"TeleportTo2")==i2)){i2 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i2),2);
i3 = Random(7)+1;while((i1==7)||(i3==3)||(i3==i1)||(i3==i2)||(GetLocalInt(oWP,"TeleportTo3")==i3)){i3 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i3),3);
i4 = 7;SetLocalInt(oWP,"TeleportTo"+IntToString(i4),4);
i5 = Random(7)+1;while((i1==7)||(i5==5)||(i5==i1)||(i5==i2)||(i5==i3)||(i5==i4)||(GetLocalInt(oWP,"TeleportTo5")==i5)){i5 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i5),5);
i6 = Random(7)+1;while((i1==7)||(i6==6)||(i6==i1)||(i6==i2)||(i6==i3)||(i6==i4)||(i6==i5)||(GetLocalInt(oWP,"TeleportTo6")==i6)){i6 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i6),6);
if((i1==7)||(i2==7)||(i3==7)||(i4==7)||(i5==7)||(i6==7)){if(GetLocalInt(oWP,"TeleportTo1")==0){i7 = 1;}else if(GetLocalInt(oWP,"TeleportTo2")==0){i7 = 2;}else if(GetLocalInt(oWP,"TeleportTo3")==0){i7 = 3;}else if(GetLocalInt(oWP,"TeleportTo4")==0){i7 = 4;}else if(GetLocalInt(oWP,"TeleportTo5")==0){i7 = 5;}else if(GetLocalInt(oWP,"TeleportTo6")==0){i7 = 6;}iCheck = 1;break;}
   }
  }
// Other combinations
else
  {
i1=0;i2=0;i3=0;i4=0;i5=0;i6=0;i7=0;DeleteLocalInt(oWP,"TeleportTo1");DeleteLocalInt(oWP,"TeleportTo2");DeleteLocalInt(oWP,"TeleportTo3");DeleteLocalInt(oWP,"TeleportTo4");DeleteLocalInt(oWP,"TeleportTo5");DeleteLocalInt(oWP,"TeleportTo6");DeleteLocalInt(oWP,"TeleportTo7");

while(iCheck!=1)
   {
i1 = Random(7)+1;while((i1==4)||(i1==1)){i1 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i1),1);
i2 = Random(7)+1;while((i2==4)||(i2==2)||(i2==i1)||(GetLocalInt(oWP,"TeleportTo2")==i2)){i2 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i2),2);
i3 = Random(7)+1;while((i3==4)||(i3==3)||(i3==i1)||(i3==i2)||(GetLocalInt(oWP,"TeleportTo3")==i3)){i3 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i3),3);
i4 = 0;
i5 = Random(7)+1;while((i5==4)||(i5==5)||(i5==i1)||(i5==i2)||(i5==i3)||(i5==i4)||(GetLocalInt(oWP,"TeleportTo5")==i5)){i5 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i5),5);
i6 = Random(7)+1;while((i6==4)||(i6==6)||(i6==i1)||(i6==i2)||(i6==i3)||(i6==i4)||(i6==i5)||(GetLocalInt(oWP,"TeleportTo6")==i6)){i6 = Random(7)+1;}SetLocalInt(oWP,"TeleportTo"+IntToString(i6),6);
if((i1==7)||(i2==7)||(i3==7)||(i4==7)||(i5==7)||(i6==7)){if(GetLocalInt(oWP,"TeleportTo1")==0){i7 = 1;}else if(GetLocalInt(oWP,"TeleportTo2")==0){i7 = 2;}else if(GetLocalInt(oWP,"TeleportTo3")==0){i7 = 3;}else if(GetLocalInt(oWP,"TeleportTo5")==0){i7 = 5;}else if(GetLocalInt(oWP,"TeleportTo6")==0){i7 = 6;}iCheck = 1;break;}
   }
  }
sCombi2 =IntToString(i1)+IntToString(i2)+IntToString(i3)+IntToString(i4)+IntToString(i5)+IntToString(i6)+IntToString(i7);
SetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+sCombi1,sCombi2);
 }
// Set combination for teleporters
SetLocalString(oWP,"Destinations",sCombi2);
////////////////////////////////////////////////////////////////////////////////
}
