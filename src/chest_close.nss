////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
float fX = GetPosition(OBJECT_SELF).x;string sX = FloatToString(fX);
float fY = GetPosition(OBJECT_SELF).y;string sY = FloatToString(fY);
object oItem = GetFirstItemInInventory(OBJECT_SELF);
int iConfig = GetLocalInt(OBJECT_SELF,"Config");
int i;
////////////////////////////////////////////////////////////////////////////////
if((iConfig!=0)&&(oItem==OBJECT_INVALID))
 {
DestroyObject(OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
while(GetIsObjectValid(oItem))
  {
i++;
SetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"BP",GetResRef(oItem));
SetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"Tag",GetTag(oItem));
SetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"Name",GetName(oItem));
SetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"Stack",GetItemStackSize(oItem));
SetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"Wear",GetLocalInt(oItem,"Wear"));
SetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"ID",GetIdentified(oItem));
SetLocalInt(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"Charges",GetItemCharges(oItem));
SetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"Bonus",GetLocalString(oItem,"Bonus"));
SetLocalString(oModule,sPlanet+sArea+sX+sY+IntToString(i)+"Var",GetLocalString(oItem,"Var"));
oItem = GetNextItemInInventory(OBJECT_SELF);
  }
SetLocalInt(oModule,sPlanet+sArea+sX+sY+"Chest",i);
 }
////////////////////////////////////////////////////////////////////////////////
}
