#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
// Cluster member areas (DM area-builder, dmb_inc.nss) are static hand-built
// content and all members of a cluster share one coordinate: letting the
// generic save/destroy/local-wipe below run would cross-write the members'
// "<Planet>&<X_Y>&Objects" records into each other and strip their placed
// content. Leave them live and untouched instead.
if(GetLocalInt(OBJECT_SELF,"IsClusterMember")==1){return;}
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
//
object oObjects = GetFirstObjectInArea(OBJECT_SELF);
int jTot = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&ObjectsTot");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
//
int i;int j;int j2;int k;int l;int m;string sj;string sMod;string sItem;object oItem;string sPer;int iDungeons;int iFaction;
string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemVar;string sItemBonus;string sItemCharges;string sAll;string sVar;string sCount;string sCount1;string sCount2;
////////////////////////////////////////////////////////////////////////////////
// area_exit.nss checks occupancy before scheduling this via a 0.3s DelayCommand;
// a PC can enter this same area in that window, so re-check now and bail out
// entirely if it's occupied again - otherwise we'd wipe Planet/Area and other
// locals (and destroy live objects) out from under a returning player.
object oPCs = GetFirstPC();
string sTag = GetTag(OBJECT_SELF);
int i1;
while(GetIsObjectValid(oPCs)){if((GetTag(GetArea(oPCs))==sTag)||(GetLocalString(oPCs,"PlayerAreaTo")==sTag)){i1++;break;}oPCs = GetNextPC();}
if(i1>=1){return;}
////////////////////////////////////////////////////////////////////////////////
// Save objects
while(GetIsObjectValid(oObjects))
 {
if((GetLocalInt(oObjects,"Permanent")!=1)&&(GetMaster(oObjects)==OBJECT_INVALID))
  {
// Don't save
if((GetLocalInt(oObjects,"DontSave")!=1)&&(GetTag(oObjects)!="BodyBag")&&(GetTag(oObjects)!="x2_plc_ipbox")&&(GetStringLeft(GetTag(oObjects),13)!="ZEP_GATEBLOCK")&&(GetStringLeft(GetTag(oObjects),13)!="ZEP_SGATEBLCK")&&(GetStringLeft(GetTag(OBJECT_SELF),5)!="sewer")&&((GetObjectType(oObjects)==OBJECT_TYPE_CREATURE)||(GetObjectType(oObjects)==OBJECT_TYPE_ITEM)||(GetObjectType(oObjects)==OBJECT_TYPE_PLACEABLE)||(GetObjectType(oObjects)==OBJECT_TYPE_STORE)||(GetObjectType(oObjects)==OBJECT_TYPE_WAYPOINT)))
   {
////////////////////////////////////////////////////////////////////////////////
// Special dungeons
if((GetObjectType(oObjects)==OBJECT_TYPE_CREATURE)&&(GetCurrentHitPoints(oObjects)>0)){k++;}
// Faction object
if(GetLocalInt(oObjects,"Fleeing")==1){iFaction = GetLocalInt(oObjects,"Faction");}else if(GetStandardFactionReputation(STANDARD_FACTION_COMMONER,oObjects)>=90){iFaction = 1;}else if(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER,oObjects)>=90){iFaction = 2;}else if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oObjects)>=90){iFaction = 3;}else{iFaction = 4;}

// Module save
if(GetLocalInt(oObjects,"Persistent")!=1){i++;
//          BluePrint                 Tag                    Name                    Object Type                                X position                                   Y position                                   Z position                                   Facing                                              Stop or wander                                  Master                                  Hit points                                       Stack                                         Faction                     Magical bonus                          Useable                                     Locked                                 Trapped                                   Camp                                            Leader                                            Wear                                            Wear%                                            Fix                                            Plot                                     Charges                                      ID                             Variables
     sMod = GetResRef(oObjects)+"_A_"+GetTag(oObjects)+"_B_"+GetName(oObjects)+"_C_"+IntToString(GetObjectType(oObjects))+"_D_"+FloatToString(GetPosition(oObjects).x)+"_E_"+FloatToString(GetPosition(oObjects).y)+"_F_"+FloatToString(GetPosition(oObjects).z)+"_G_"+FloatToString(GetFacing(oObjects))+"_H_"+IntToString(GetLocalInt(oObjects,"Stop"))+"_I_"+GetLocalString(oObjects,"Master")+"_J_"+IntToString(GetCurrentHitPoints(oObjects))+"_K_"+IntToString(GetItemStackSize(oObjects))+"_L_"+IntToString(iFaction)+"_M_"+GetLocalString(oObjects,"Bonus")+"_N_"+IntToString(GetUseableFlag(oObjects))+"_O_"+IntToString(GetLocked(oObjects))+"_P_"+IntToString(GetIsTrapped(oObjects))+"_Q_"+IntToString(GetLocalInt(oObjects,"Camp"))+"_R_"+IntToString(GetLocalInt(oObjects,"Leader"))+"_S_"+IntToString(GetLocalInt(oObjects,"Wear"))+"_T_"+IntToString(GetLocalInt(oObjects,"Wear%"))+"_U_"+IntToString(GetLocalInt(oObjects,"Fix"))+"_V_"+IntToString(GetPlotFlag(oObjects))+"_W_"+IntToString(GetItemCharges(oObjects))+"_X_"+IntToString(GetIdentified(oObjects))+"_Y_"+GetLocalString(oObjects,"Var")+"_Z_";SetLocalString(oModule,sPlanet+"_"+sArea+"_Objects"+IntToString(i),sMod);
// Random adventurer henches (tavern hire slots, or ones a PC dismissed and
// left standing here - see area_recall.nss/henchs.nss) aren't a fixed
// blueprint; the string above only captures generic fields (name/position/
// HP/faction/...), so recreating one from just GetResRef()=="adventurer"
// would give a blank level-1 Commoner. Snapshot the full NWNX-built identity
// and gear via StoreCampaignObject, keyed the same way as the generic string
// above so area_recall.nss can look it up by the same index. This campaign
// namespace is explicitly wiped at every server boot (see mod_load.nss) -
// it's meant to survive an area emptying out and refilling within a
// session, not a restart.
if((GetObjectType(oObjects)==OBJECT_TYPE_CREATURE)&&(GetResRef(oObjects)=="adventurer")){StoreCampaignObject("AdvAreaSnap",sPlanet+"_"+sArea+"_Objects"+IntToString(i),oObjects,OBJECT_INVALID,TRUE);}}
// Database save
                                     else{j++;sj = IntToString(j);if(j<10){sj = "00"+IntToString(j);}else if(j<100){sj = "0"+IntToString(j);}sj = "&"+sj+"&";
//          BluePrint                 Tag                    Name                    Object Type                                X position                                             Y position                                            Z position                                             Facing                                              Stop or wander                                  Master                                  Hit points                                       Stack                                         Faction                     Magical bonus                          Useable                                     Locked                                 Trapped                                   Camp                                            Leader                                            Wear                                            Wear%                                            Fix                                            Plot                                     Charges                                                 ID                             Variables
sPer = sPer+GetResRef(oObjects)+"_A_"+GetTag(oObjects)+"_B_"+GetName(oObjects)+"_C_"+IntToString(GetObjectType(oObjects))+"_D_"+IntToString(FloatToInt(GetPosition(oObjects).x))+"_E_"+IntToString(FloatToInt(GetPosition(oObjects).y))+"_F_"+IntToString(FloatToInt(GetPosition(oObjects).z))+"_G_"+IntToString(FloatToInt(GetFacing(oObjects)))+"_H_"+IntToString(GetLocalInt(oObjects,"Stop"))+"_I_"+GetLocalString(oObjects,"Master")+"_J_"+IntToString(GetCurrentHitPoints(oObjects))+"_K_"+IntToString(GetItemStackSize(oObjects))+"_L_"+IntToString(iFaction)+"_M_"+GetLocalString(oObjects,"Bonus")+"_N_"+IntToString(GetUseableFlag(oObjects))+"_O_"+IntToString(GetLocked(oObjects))+"_P_"+IntToString(GetIsTrapped(oObjects))+"_Q_"+IntToString(GetLocalInt(oObjects,"Camp"))+"_R_"+IntToString(GetLocalInt(oObjects,"Leader"))+"_S_"+IntToString(GetLocalInt(oObjects,"Wear"))+"_T_"+IntToString(GetLocalInt(oObjects,"Wear%"))+"_U_"+IntToString(GetLocalInt(oObjects,"Fix"))+"_V_"+IntToString(GetPlotFlag(oObjects))+"_W_"+IntToString(GetItemCharges(oObjects))+"_X_"+IntToString(GetIdentified(oObjects))+"_Y_"+GetLocalString(oObjects,"Var")+"_Z_"+sj;}
////////////////////////////////////////////////////////////////////////////////
   }
// Save and Destroy inventory
if(GetHasInventory(oObjects))
   {
oItem = GetFirstItemInInventory(oObjects);sItem = "";l=0;
while(GetIsObjectValid(oItem))
    {
if(((GetObjectType(oObjects)==OBJECT_TYPE_PLACEABLE)&&(GetStringLeft(GetTag(oObjects),5)!="chest"))||(GetLocalInt(oObjects,"Hench")==1))
     {
l++;
//          BluePrint              Tag                 Name                 Object Type                             X position                                          Y position                                         Z position                                          Facing                                           Stop or wander                               Master                               Hit points                                    Stack                                      Faction                     Magical bonus                       Useable                                  Locked                              Trapped                                Camp                                         Leader                                         Wear                                         Wear%                                         Fix                                         Plot                                  Charges                                          ID                          Variables
sItem = GetResRef(oItem)+"_A_"+GetTag(oItem)+"_B_"+GetName(oItem)+"_C_"+IntToString(GetObjectType(oItem))+"_D_"+IntToString(FloatToInt(GetPosition(oItem).x))+"_E_"+IntToString(FloatToInt(GetPosition(oItem).y))+"_F_"+IntToString(FloatToInt(GetPosition(oItem).z))+"_G_"+IntToString(FloatToInt(GetFacing(oItem)))+"_H_"+IntToString(GetLocalInt(oItem,"Stop"))+"_I_"+GetLocalString(oItem,"Master")+"_J_"+IntToString(GetCurrentHitPoints(oItem))+"_K_"+IntToString(GetItemStackSize(oItem))+"_L_"+IntToString(iFaction)+"_M_"+GetLocalString(oItem,"Bonus")+"_N_"+IntToString(GetUseableFlag(oItem))+"_O_"+IntToString(GetLocked(oItem))+"_P_"+IntToString(GetIsTrapped(oItem))+"_Q_"+IntToString(GetLocalInt(oItem,"Camp"))+"_R_"+IntToString(GetLocalInt(oItem,"Leader"))+"_S_"+IntToString(GetLocalInt(oItem,"Wear"))+"_T_"+IntToString(GetLocalInt(oItem,"Wear%"))+"_U_"+IntToString(GetLocalInt(oItem,"Fix"))+"_V_"+IntToString(GetPlotFlag(oItem))+"_W_"+IntToString(GetItemCharges(oItem))+"_X_"+IntToString(GetIdentified(oItem))+"_Y_"+GetLocalString(oItem,"Var")+"_Z_";
SetLocalString(oModule,sPlanet+"_"+sArea+"_Objects"+IntToString(i)+"Inventory"+IntToString(l),sItem);
     }
DestroyObject(oItem);
oItem = GetNextItemInInventory(oObjects);
    }
SetLocalInt(oModule,sPlanet+"&"+sArea+"&ObjectsTot"+IntToString(i)+"Inventory",l);

// Save slots
if(GetLocalInt(oObjects,"Hench")==1)
    {
sVar = "";m=0;
while(m<18)
     {
m++;
if(m==1) {iSlot = INVENTORY_SLOT_ARMS;}
if(m==2) {iSlot = INVENTORY_SLOT_ARROWS;}
if(m==3) {iSlot = INVENTORY_SLOT_BELT;}
if(m==4) {iSlot = INVENTORY_SLOT_BOLTS;}
if(m==5) {iSlot = INVENTORY_SLOT_BOOTS;}
if(m==6) {iSlot = INVENTORY_SLOT_BULLETS;}
if(m==7) {iSlot = INVENTORY_SLOT_CARMOUR;}
if(m==8) {iSlot = INVENTORY_SLOT_CHEST;}
if(m==9) {iSlot = INVENTORY_SLOT_CLOAK;}
if(m==10){iSlot = INVENTORY_SLOT_CWEAPON_B;}
if(m==11){iSlot = INVENTORY_SLOT_CWEAPON_L;}
if(m==12){iSlot = INVENTORY_SLOT_CWEAPON_R;}
if(m==13){iSlot = INVENTORY_SLOT_HEAD;}
if(m==14){iSlot = INVENTORY_SLOT_LEFTHAND;}
if(m==15){iSlot = INVENTORY_SLOT_LEFTRING;}
if(m==16){iSlot = INVENTORY_SLOT_NECK;}
if(m==17){iSlot = INVENTORY_SLOT_RIGHTHAND;}
if(m==18){iSlot = INVENTORY_SLOT_RIGHTRING;}

oItem = GetItemInSlot(iSlot,oObjects);

sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemCharges = IntToString(GetItemCharges(oItem));
sItemVar = GetLocalString(oItem,"Var");
sItemBonus = GetLocalString(oItem,"Bonus");
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemWear2+"_G_"+sItemFix+"_H_"+sItemCharges+"_I_"+sItemVar+"_J_"+sItemBonus+"_K_";

sCount = IntToString(m);if(m<10){sCount = "00"+IntToString(m);}else if(m<100){sCount = "0"+IntToString(m);}sCount = "&"+sCount+"&";
sVar = sVar+sAll+sCount;

SetDroppableFlag(oItem,TRUE);
     }
SetLocalString(oModule,sPlanet+"_"+sArea+"_Objects"+IntToString(i)+"Slots",sVar);
    }
   }
SetImmortal(oObjects,FALSE);SetPlotFlag(oObjects,FALSE);AssignCommand(oObjects,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObjects);
  }
////////////////////////////////////////////////////////////////////////////////
// Permanent objects
else
  {
// Close permanent doors but not the exits
if((GetObjectType(oObjects)==OBJECT_TYPE_DOOR)&&(GetTag(oObjects)!="door_exit"))
   {
if(GetLocalInt(oObjects,"Locked")==1){SetLocked(oObjects,TRUE);DeleteLocalInt(oObjects,"Locked");}
AssignCommand(oObjects,ActionCloseDoor(oObjects));
   }
// Stop monster challenges
else if(GetTag(oObjects)=="altar_challenges")
   {
DeleteLocalObject(oObjects,"FireMonster");
DeleteLocalObject(oObjects,"PC");
DeleteLocalInt(oObjects,"Firing");
SetLocked(GetNearestObjectByTag("door_challenge",oObjects),FALSE);
   }
////////////////////////////////////////////////////////////////////////////////
  }
if(j==5){j=0;j2++;SetPersistentString(oModule,sPlanet+"&"+sArea+"&Objects"+IntToString(j2),sPer);sPer = "";}
oObjects = GetNextObjectInArea(OBJECT_SELF);
 }
// Save
SetLocalInt(oModule,sPlanet+"&"+sArea+"&ObjectsTot",i);
if(j>0){j2++;SetPersistentString(oModule,sPlanet+"&"+sArea+"&Objects"+IntToString(j2),sPer);}
SetPersistentInt(oModule,sPlanet+"&"+sArea+"&ObjectsTot",j2);
if((j==0)&&(j2==0)){DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&ObjectsTot");}
while(j2<jTot){j2++;DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Objects"+IntToString(j2));}
////////////////////////////////////////////////////////////////////////////////
// Dungeons
if(GetStringLeft(GetTag(OBJECT_SELF),2)=="d_")
 {
string sArea2 = GetStringLeft(sArea,FindSubString(sArea,"&"));

if(GetLocalInt(oModule,sPlanet+"_"+sArea2+"_Dungeons")!=0)
  {
iDungeons = GetLocalInt(oModule,sPlanet+"_"+sArea2+"_Dungeons");
  }
else
  {
iDungeons = GetPersistentInt(oModule,"Dungeons")+1;SetPersistentInt(oModule,"Dungeons",iDungeons);SetLocalInt(oModule,sPlanet+"_"+sArea2+"_Dungeons",iDungeons);
  }
SetPersistentString(oModule,"Dungeons"+IntToString(iDungeons),sPlanet+"_A_"+sArea2+"_B_"+IntToString(k));
 }
////////////////////////////////////////////////////////////////////////////////
// Delete variables
DeleteLocalObject(oModule,sPlanet+"_"+sArea);
DeleteLocalString(oModule,GetLocalString(OBJECT_SELF,"Var"));
DeleteLocalString(oModule,"Trans1"+sPlanet+sArea);
DeleteLocalString(oModule,"Trans2"+sPlanet+sArea);
DeleteLocalInt(OBJECT_SELF,"Used");
DeleteLocalString(OBJECT_SELF,"Var");
DeleteLocalInt(OBJECT_SELF,"TransType");
DeleteLocalString(OBJECT_SELF,"PlanetType");
DeleteLocalString(OBJECT_SELF,"PlanetOrb");
DeleteLocalString(OBJECT_SELF,"PlanetProv");
DeleteLocalString(OBJECT_SELF,"PlanetDest");
DeleteLocalString(OBJECT_SELF,"AreaProv");
DeleteLocalString(OBJECT_SELF,"AreaDest");
DeleteLocalString(OBJECT_SELF,"Master");
DeleteLocalFloat(OBJECT_SELF,"fXExit");
DeleteLocalFloat(OBJECT_SELF,"fYExit");
DeleteLocalFloat(OBJECT_SELF,"fX");
DeleteLocalFloat(OBJECT_SELF,"fY");
DeleteLocalFloat(OBJECT_SELF,"fF");
DeleteLocalInt(OBJECT_SELF,"NoCamp");
DeleteLocalInt(OBJECT_SELF,"Bonus");
DeleteLocalInt(OBJECT_SELF,"TransDist");
DeleteLocalInt(OBJECT_SELF,"TimeLeft");
DeleteLocalInt(OBJECT_SELF,"Transports");
DeleteLocalInt(OBJECT_SELF,"Night");
DeleteLocalInt(OBJECT_SELF,"Mountain");
DeleteLocalInt(OBJECT_SELF,"Slot");
DeleteLocalInt(OBJECT_SELF,"Structure");
DeleteLocalInt(OBJECT_SELF,"Level");
DeleteLocalInt(OBJECT_SELF,"Gain");
DeleteLocalInt(OBJECT_SELF,"DomResIni");
DeleteLocalInt(OBJECT_SELF,"DungeonRespawn");
DeleteLocalObject(OBJECT_SELF,"DungeonRespawnPoint");
DeleteLocalInt(OBJECT_SELF,"DungeonLevel");
DeleteLocalInt(OBJECT_SELF,"DungeonFamily");
DeleteLocalInt(OBJECT_SELF,"DDLevel");
DeleteLocalObject(OBJECT_SELF,"CampEntry");
DeleteLocalInt(OBJECT_SELF,"Used");
////////////////////////////////////////////////////////////////////////////////
// Only true CopyArea() clones can be safely destroyed and recreated later from
// their "000" template. Static single-instance areas (no template, or pooled
// interiors like taverns/shops/dungeons handled by transitions2.nss) must
// survive so GetObjectByTag() can find and reuse them next time - AND they must
// keep their "Planet"/"Area"/"AreaExit"/"AreaExitObj" identity while surviving,
// not just the object itself: transitions2.nss's bank/shop exit logic has a
// "direct jump" fast path (GetLocalObject(oArea,"AreaExitObj")) that jumps
// straight back into a static exterior area like this WITHOUT going through
// transitions.nss - which is the only thing that normally re-stamps these
// locals. If they're wiped here on every vacate (as they used to be,
// unconditionally), entering an interior and leaving it again would jump the
// player back into an exterior area with no Planet/Area identity, breaking
// the next tile-to-tile move with "*no area available*" even though nothing
// was ever destroyed. The "Used" flag above is what actually tracks pool
// availability for reuse, not these - so only clear them when the object is
// about to be destroyed anyway (moot at that point).
if(GetLocalInt(OBJECT_SELF,"IsCopy")==1)
 {
DeleteLocalString(OBJECT_SELF,"Planet");
DeleteLocalString(OBJECT_SELF,"Area");
DeleteLocalString(OBJECT_SELF,"AreaExit");
DeleteLocalObject(OBJECT_SELF,"AreaExitObj");
DestroyArea(OBJECT_SELF);
 }
}
