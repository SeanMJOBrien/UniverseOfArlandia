////////////////////////////////////////////////////////////////////////////////
// Sacrophagus
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastOpenedBy();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
float fX = GetPosition(OBJECT_SELF).x;
float fY = GetPosition(OBJECT_SELF).y;
int iOpen = GetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Open");
//
object oNew;string sNew;int iRandom1 = Random(10);int iRandom2 = Random(10)+1;
////////////////////////////////////////////////////////////////////////////////
if(iOpen!=1)
 {
////////////////////////////////////////////////////////////////////////////////
if((GetIsObjectValid(oPC))||(iRandom1==0))
  {
     if((iRandom2>=1)&&(iRandom1<=4)){sNew = "mn_squel007";}
else if((iRandom2>=5)&&(iRandom1<=7)){sNew = "mn_zombie004";}
else if((iRandom2>=8)&&(iRandom1<=9)){sNew = "mn_mummy001";}
else                               {sNew = "mn_vampire001";}

oNew = CreateObject(OBJECT_TYPE_CREATURE,sNew,GetLocation(OBJECT_SELF));
CreateItemOnObject("nw_it_gold001",OBJECT_SELF,Random(101)+50);

SetLocked(OBJECT_SELF,FALSE);PlayAnimation(ANIMATION_PLACEABLE_OPEN);

SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Open",1);
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
}
