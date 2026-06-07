////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastAttacker();
object oArea = GetArea(OBJECT_SELF);
int iAreaWidth = GetAreaSize(AREA_WIDTH,oArea)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,oArea)*10;
////////////////////////////////////////////////////////////////////////////////
// Animal reserves
if((GetLocalInt(oPC,"AniReserve")>0)&&(GetLocalInt(OBJECT_SELF,GetName(oPC))!=1))
 {
SetLocalInt(OBJECT_SELF,GetName(oPC),1);
SetLocalInt(oPC,"AniReserve",GetLocalInt(oPC,"AniReserve")-1);
SetPlotFlag(OBJECT_SELF,FALSE);
FloatingTextStringOnCreature(IntToString(GetLocalInt(oPC,"AniReserve"))+" animals left",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
}
