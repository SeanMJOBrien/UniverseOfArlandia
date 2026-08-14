#include "aps_include"
// ---------------------------------------------------------------------------
// Spawn-group capture engine (DM tool).
//
// Walks OBJECT_SELF (a staging area a DM has decorated with creatures and
// placeables) and saves the whole layout as a named, reusable "spawn group"
// that area_creatures.nss can later stamp as a random, level-gated camp.
//
// Each object is stored whole (equipment + locals preserved) in the
// "SpawnGroups" campaign DB via StoreCampaignObject; only the layout geometry
// (offset from the area centre + facing) and the group registry live in the
// pwdata SQL table, so the random-spawn picker and any external tooling can
// enumerate groups. This mirrors area_save.nss (serialise) / area_recall.nss
// (re-stamp), but keeps positions relative so the group is relocatable.
//
// Caller (DM tool / mod_activate item) supplies on the area, before running:
//   string "SpawnGrpName"  - group name (falls back to the area's own name)
//   int    "SpawnGrpLevel" - minimum planet level to spawn at (default 1)
//   object "SpawnGrpDM"    - the DM to message with the result (optional)
// The source objects are left intact (StoreCampaignObject copies them).
// ---------------------------------------------------------------------------

// Strip delimiter characters so the name is safe as a campaign/pwdata key.
string SG_Clean(string sIn)
{
int iLen = GetStringLength(sIn);int n;string sOut;
for(n=0;n<iLen;n++){string sC = GetSubString(sIn,n,1);if((sC!="&")&&(sC!="_")&&(sC!=" ")){sOut = sOut+sC;}}
return sOut;
}

void main()
{
object oModule = GetModule();
object oArea = OBJECT_SELF;
object oDM = GetLocalObject(oArea,"SpawnGrpDM");

string sGroup = SG_Clean(GetLocalString(oArea,"SpawnGrpName"));
if(sGroup==""){sGroup = SG_Clean(GetName(oArea));}
if(sGroup==""){if(GetIsObjectValid(oDM)){SendMessageToPC(oDM,"Spawn group save aborted: no usable name.");}return;}

int iMinLevel = GetLocalInt(oArea,"SpawnGrpLevel");if(iMinLevel<1){iMinLevel = 1;}

string sCampaign = "SpawnGroups";
string sKey = "SpawnGrp&"+sGroup+"&";

// Same origin area_creatures.nss stamps camps at: the area centre.
float fCX = IntToFloat(GetAreaSize(AREA_WIDTH,oArea)*10)/2.0;
float fCY = IntToFloat(GetAreaSize(AREA_HEIGHT,oArea)*10)/2.0;

// Clear any prior capture stored under this name (campaign objects + geometry).
int iOld = GetPersistentInt(oModule,sKey+"Count");int c;
for(c=1;c<=iOld;c++){DeleteCampaignVariable(sCampaign,sGroup+"_o"+IntToString(c));DeletePersistentVariable(oModule,sKey+"Geo"+IntToString(c));}

int i;
object oObj = GetFirstObjectInArea(oArea);
while(GetIsObjectValid(oObj))
 {
 int iType = GetObjectType(oObj);
 if(((iType==OBJECT_TYPE_CREATURE)||(iType==OBJECT_TYPE_PLACEABLE))&&(!GetIsPC(oObj))&&(GetLocalInt(oObj,"DontSave")!=1)&&(GetLocalInt(oObj,"Permanent")!=1)&&(GetTag(oObj)!="BodyBag"))
  {
  i++;
  float fDX = GetPosition(oObj).x-fCX;
  float fDY = GetPosition(oObj).y-fCY;
  StoreCampaignObject(sCampaign,sGroup+"_o"+IntToString(i),oObj);
  SetPersistentString(oModule,sKey+"Geo"+IntToString(i),FloatToString(fDX)+"_A_"+FloatToString(fDY)+"_B_"+FloatToString(GetFacing(oObj))+"_C_"+IntToString(iType)+"_D_");
  }
 oObj = GetNextObjectInArea(oArea);
 }

SetPersistentInt(oModule,sKey+"Count",i);
SetPersistentInt(oModule,sKey+"MinLevel",iMinLevel);

// Register the group name in the enumerable index (dedup).
int iTot = GetPersistentInt(oModule,"SpawnGroupsTot");int r;int iFound;
for(r=1;r<=iTot;r++){if(GetPersistentString(oModule,"SpawnGroup"+IntToString(r))==sGroup){iFound = 1;break;}}
if((i>0)&&(iFound==0)){iTot++;SetPersistentString(oModule,"SpawnGroup"+IntToString(iTot),sGroup);SetPersistentInt(oModule,"SpawnGroupsTot",iTot);}

DeleteLocalString(oArea,"SpawnGrpName");DeleteLocalInt(oArea,"SpawnGrpLevel");DeleteLocalObject(oArea,"SpawnGrpDM");

if(GetIsObjectValid(oDM)){SendMessageToPC(oDM,"Spawn group '"+sGroup+"' saved: "+IntToString(i)+" object(s), min level "+IntToString(iMinLevel)+".");}
}
