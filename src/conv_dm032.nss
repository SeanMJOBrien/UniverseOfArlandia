#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oRoads = GetFirstObjectInArea(oArea);
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
location oLoc1 = GetLocalLocation(oPC,"Loc1");
location oLoc2 = GetLocalLocation(oPC,"Loc2");
vector v1 = GetPositionFromLocation(oLoc1);float fv1x = v1.x;float fv1y = v1.y;
vector v2 = GetPositionFromLocation(oLoc2);float fv2x = v2.x;float fv2y = v2.y;
float fAx;float fx1;float fx2;if(fv1x>=fv2x){fAx = fv1x-fv2x;fx1 = fv1x;fx2 = fv1x-fAx;}else{fAx = fv2x-fv1x;fx1 = fv2x;fx2 = fv2x-fAx;}
float fAy;float fy1;float fy2;if(fv1y>=fv2y){fAy = fv1y-fv2y;fy1 = fv1y;fy2 = fv1y-fAy;}else{fAy = fv2y-fv1y;fy1 = fv2y;fy2 = fv2y-fAy;}
float vP1;float vP2;float vP3;vector vRoads;string sTag;

if(GetAreaFromLocation(oLoc1)==GetAreaFromLocation(oLoc2))
 {
while(GetIsObjectValid(oRoads))
  {
vRoads = GetPosition(oRoads);vP1 = vRoads.x;vP2= vRoads.y;vP3 = vRoads.z;
sTag = GetTag(oRoads);
     if((iChoice1==1)&&((GetObjectType(oRoads)==OBJECT_TYPE_PLACEABLE)&&((vP1<=fx1)&&(vP1>=fx2)&&(vP2<=fy1)&&(vP2>=fy2)))){DestroyObject(oRoads);}
else if((iChoice1==2)&&(((sTag=="nw_plc_raft")||(sTag=="PillarStyle2")||(sTag=="ZEP_FENCE002")||(sTag=="bridgepass"))&&((vP1<=fx1)&&(vP1>=fx2)&&(vP2<=fy1)&&(vP2>=fy2)))){DestroyObject(oRoads);}
else if((iChoice1==3)&&((sTag=="ZEP_FENCE012")&&((vP1<=fx1)&&(vP1>=fx2)&&(vP2<=fy1)&&(vP2>=fy2)))){DestroyObject(oRoads);}
else if((iChoice1==4)&&((GetStringLeft(sTag,8)=="ZEP_ROAD")&&((vP1<=fx1)&&(vP1>=fx2)&&(vP2<=fy1)&&(vP2>=fy2)))){DestroyObject(oRoads);}
else if((iChoice1==5)&&((sTag=="codiwall2")&&((vP1<=fx1)&&(vP1>=fx2)&&(vP2<=fy1)&&(vP2>=fy2)))){DestroyObject(oRoads);}
else if((iChoice1==6)&&((sTag=="ZEP_WALL001")&&((vP1<=fx1)&&(vP1>=fx2)&&(vP2<=fy1)&&(vP2>=fy2)))){DestroyObject(oRoads);}
else if((iChoice1==7)&&((sTag=="ZEP_FENCE001")&&((vP1<=fx1)&&(vP1>=fx2)&&(vP2<=fy1)&&(vP2>=fy2)))){DestroyObject(oRoads);}
oRoads = GetNextObjectInArea(oArea);
  }
 }
}
