#include "dmfi_dmw_inc"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetItemActivator();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oItem = GetItemActivated();
string sItemTag = GetTag(oItem);
object oTarget = GetItemActivatedTarget();
location lTarget = GetItemActivatedTargetLocation();
object oArea = GetArea(oPC);
string sAreaTag = GetTag(oArea);
string sAreaName = GetName(oArea);
float fAreaX = IntToFloat(GetAreaSize(AREA_WIDTH,oArea)*5);
float fAreaY = IntToFloat(GetAreaSize(AREA_HEIGHT,oArea)*5);
object oItems = GetFirstItemInInventory(oPC);
int iRace = GetLocalInt(oGoldbag,"Race");
object oNew;string sCheck1;string sCheck2;int a;int b;float fX;float fY;float fZ;int iTalent;int i;
////////////////////////////////////////////////////////////////////////////////
// Analyser
if(sItemTag=="analyser"){SetLocalObject(oPC,"ItemActivated",oItem);SetLocalObject(oPC,"ItemTarget",oTarget);SetLocalLocation(oPC,"ItemLocation",lTarget);ExecuteScript("analyser",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Animal henchs bought
else if((oTarget==OBJECT_INVALID)&&(GetStringLeft(GetName(oItem),8)=="Animal :")&&(GetStringRight(sItemTag,1)=="t")){oNew = CreateObject(OBJECT_TYPE_CREATURE,GetStringLeft(sItemTag,GetStringLength(sItemTag)-1),lTarget);DestroyObject(oItem,0.1);SetLocalInt(oNew,"Hench",1);SetLocalInt(oNew,"Stop",1);SetLocalInt(oNew,"NotFlee",1);}
////////////////////////////////////////////////////////////////////////////////
// Barrels
     if((sItemTag=="obarrelempty")&&(oTarget==OBJECT_INVALID)&&(sAreaName!="Sky")&&(sAreaName!="Space")&&(sAreaName!="Underwater")){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"barrelempty",lTarget);FloatingTextStringOnCreature("*unpacking barrel*",oPC,TRUE);}
else if((sItemTag=="obarrelexplosive")&&(oTarget==OBJECT_INVALID)&&(sAreaName!="Sky")&&(sAreaName!="Space")&&(sAreaName!="Underwater")){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"barrelexplosive",lTarget);FloatingTextStringOnCreature("*unpacking barrel*",oPC,TRUE);}
////////////////////////////////////////////////////////////////////////////////
// Campfire
else if(((sItemTag=="cr_firelit")||(sItemTag=="cr_shosho"))&&(sAreaName!="Sky")&&(sAreaName!="Space")&&(sAreaName!="Underwater")&&(oTarget==OBJECT_INVALID)){FloatingTextStringOnCreature("*lighting a campfire*",oPC,TRUE);oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_campfire001",lTarget);DestroyObject(oItem);}
////////////////////////////////////////////////////////////////////////////////
// Cannon
else if((sItemTag=="ocannon")&&(oTarget==OBJECT_INVALID)&&(sAreaName!="Sky")&&(sAreaName!="Space")&&(sAreaName!="Underwater")){oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"cannoncommoner",lTarget);FloatingTextStringOnCreature("*unpacking cannon*",oPC,TRUE);}
////////////////////////////////////////////////////////////////////////////////
// Clones
else if(sItemTag=="clones"){if((GetStringLeft(sAreaTag,6)=="clouds")||(GetStringLeft(sAreaTag,3)=="gaz")||(GetStringLeft(sAreaTag,5)=="ocean")||(GetStringLeft(sAreaTag,5)=="space")||(GetStringLeft(sAreaTag,10)=="underwater")){FloatingTextStringOnCreature("you can't use your clone power in this environment",oPC);}else{ExecuteScript("clones",oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Code enigm
else if(sItemTag=="code"){sCheck1 = GetLocalString(oItem,"EnigmSigns");sCheck2 = GetLocalString(oItem,"EnigmResult");if(GetLocalInt(oItem,"Enigm")>1){SetCustomToken(10405,"Code :\n\n"+ColorText(IntToString(GetLocalInt(oItem,"Enigm"))+":\n\n"+sCheck2,"g"));}else{SetCustomToken(10405,"Code :\n\n"+ColorText(GetLocalString(oItem,"EnigmSigns1")+" "+GetLocalString(oItem,"EnigmSigns2")+" "+GetLocalString(oItem,"EnigmSigns3")+"\n"+GetLocalString(oItem,"EnigmSigns4")+" "+GetLocalString(oItem,"EnigmSigns5")+" "+GetLocalString(oItem,"EnigmSigns6")+"\n"+GetLocalString(oItem,"EnigmSigns7")+" "+GetLocalString(oItem,"EnigmSigns8")+" "+GetLocalString(oItem,"EnigmSigns9")+"\n\n"+sCheck2,"g"));}SetLocalInt(oPC,"CheckCode",1);AssignCommand(oPC,ActionStartConversation(oPC,"enigm",TRUE,FALSE));}
////////////////////////////////////////////////////////////////////////////////
// Cook fish/meat/eggs
else if(((sItemTag=="cr_eggs")||(sItemTag=="cr_fish")||(sItemTag=="cr_meat"))&&(sAreaName!="Sky")&&(sAreaName!="Space")&&(sAreaName!="Underwater")&&(GetTag(oTarget)=="campfire")){if(GetResRef(oItem)=="cr_eggs"){FloatingTextStringOnCreature("You prepared your eggs",oPC,TRUE);}else if(GetResRef(oItem)=="cr_fish"){FloatingTextStringOnCreature("You cook your fish",oPC,TRUE);}else{FloatingTextStringOnCreature("You cook your meat",oPC,TRUE);}DestroyObject(oItem);CreateItemOnObject("cr_food",oPC);}
////////////////////////////////////////////////////////////////////////////////
// DM Tool
else if(sItemTag=="dmtool"){if(GetIsObjectValid(oTarget)){SetLocalObject(oPC,"oTarget",oTarget);DeleteLocalLocation(oPC,"lTarget");}else{DeleteLocalObject(oPC,"oTarget");SetLocalLocation(oPC,"lTarget",lTarget);}DeleteLocalInt(oPC,"AreaMode");AssignCommand(oPC,ActionStartConversation(oPC,"dm",TRUE,FALSE));}
////////////////////////////////////////////////////////////////////////////////
// Domain
else if(sItemTag=="domain"){if(GetIsObjectValid(oTarget)){FloatingTextStringOnCreature("activate the item on the ground",oPC);}else{SetLocalInt(oPC,"PlaceDomain",1);SetLocalObject(oPC,"DomainItem",oItem);AssignCommand(oPC,ActionJumpToLocation(Location(oArea,Vector(fAreaX,fAreaY-5.0,0.0),DIRECTION_NORTH)));AssignCommand(oPC,ActionStartConversation(oPC,"domain",TRUE,FALSE));}}
////////////////////////////////////////////////////////////////////////////////
// Food bonus
else if(((sItemTag=="cr_apple")||(sItemTag=="cr_banana")||(sItemTag=="cr_cereal")||(sItemTag=="cr_egg")||(sItemTag=="cr_food")||(sItemTag=="cr_grape")||(sItemTag=="cr_jelly")||(sItemTag=="cr_milk")||(sItemTag=="cr_pemican")||(sItemTag=="cr_arabano")||(sItemTag=="cr_sandwich")||(sItemTag=="food"))&&(oTarget==oPC)){if(GetCurrentHitPoints(oPC)<GetMaxHitPoints(oPC)*2){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(10),oPC);DestroyObject(oItem);AssignCommand(oPC,ActionSpeakString("Miam Miam"));DelayCommand(4.0,AssignCommand(oPC,ActionSpeakString("Burp")));FloatingTextStringOnCreature("You eat some food",oPC,TRUE);}}
////////////////////////////////////////////////////////////////////////////////
// Help item
else if(sItemTag=="help"){fX = GetPosition(oPC).x;fY = GetPosition(oPC).y;fZ = GetPosition(oPC).z;float fF = GetFacing(oPC);if(fF<=90.0) {lTarget = Location(oArea,Vector(fX,fY+1.0,fZ),fF);}else if(fF<=180.0){lTarget = Location(oArea,Vector(fX-1.0,fY,fZ),fF);}else if(fF<=270.0){lTarget = Location(oArea,Vector(fX,fY-1.0,fZ),fF);}else if(fF<=360.0)  {lTarget = Location(oArea,Vector(fX+1.0,fY,fZ),fF);}AssignCommand(oPC,ActionJumpToLocation(lTarget));}
////////////////////////////////////////////////////////////////////////////////
// Item sensor
else if(sItemTag=="cr_itemsensor"){if(GetLocalInt(oGoldbag,"Item Sensor")==0){FloatingTextStringOnCreature("you must learn the 'Item sensor' talent before you can use this rod",oPC);SetItemCharges(oItem,GetItemCharges(oItem)+1);}else{oNew = GetNearestObject(OBJECT_TYPE_ITEM,oPC);if(oNew==OBJECT_INVALID){FloatingTextStringOnCreature("no item nearby",oPC);SetItemCharges(oItem,GetItemCharges(oItem)+1);}else{fX = GetPosition(oNew).x;fY = GetPosition(oNew).y;FloatingTextStringOnCreature("a "+GetName(oNew)+" is located at x="+IntToString(FloatToInt(fX))+" / y="+IntToString(FloatToInt(fY)),oPC);}}}
////////////////////////////////////////////////////////////////////////////////
// Item powers
else if(sItemTag=="cr_heart"){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,1),oPC,120.0);DestroyObject(oItem);}
////////////////////////////////////////////////////////////////////////////////
// Keys
else if(GetStringLeft(sItemTag,3)=="key"){if(GetIsObjectValid(oTarget)){if((GetStringLeft(sItemTag,6)=="key001")&&(GetStringLeft(GetTag(oTarget),5)=="chest")&&(GetStringLeft(GetTag(oTarget),11)!="chestplayer")&&(GetLocked(oTarget))){SetLocked(oTarget,FALSE);DestroyObject(oItem);i=1;}}if(i==0){FloatingTextStringOnCreature("no action possible",oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Mount item
else if(sItemTag=="mountitem"){if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>=5){if(GetLocalInt(oGoldbag,"HorsePaladin")!=1){SetLocalInt(oPC,"HenchAction",8);}else{SetLocalInt(oPC,"HenchAction",9);}}else{SetLocalInt(oPC,"HenchAction",9);}ExecuteScript("henchs",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Race power
else if((sItemTag=="racialpower")||(sItemTag=="racialproperties")){if(((iRace==8)||(iRace==9))&&((GetStringLeft(sAreaTag,6)=="clouds")||(GetStringLeft(sAreaTag,3)=="gaz")||(GetStringLeft(sAreaTag,5)=="ocean")||(GetStringLeft(sAreaTag,5)=="space")||(GetStringLeft(sAreaTag,10)=="underwater"))){FloatingTextStringOnCreature("you can't use your racial power in this environment",oPC);}else{ExecuteScript("races",oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Repair Kit
else if(sItemTag=="cr_repairkit"){if(GetLocalInt(oGoldbag,"Blacksmith")==0){FloatingTextStringOnCreature("you must be a blacksmith to repair items",oPC);}else{SetLocalInt(oPC,"Price",GetLocalInt(oTarget,"Fix"));SetLocalObject(oPC,"oItem",oItem);SetLocalObject(oPC,"oTarget",oTarget);SetCustomToken(10451,IntToString(GetLocalInt(oTarget,"Fix")));AssignCommand(oPC,ActionStartConversation(oPC,"repair",TRUE,FALSE));}}
////////////////////////////////////////////////////////////////////////////////
// Scroll
else if(sItemTag=="customscroll"){string sVar = GetLocalString(oItem,"Var");while(GetIsObjectValid(oItems)){if(GetTag(oItems)=="cr_feathers"){a++;}else if(GetStringLeft(GetTag(oItems),9)=="x2_it_dye"){b++;}oItems = GetNextItemInInventory(oPC);}if((sVar=="")&&(GetIsPC(oPC))&&(!GetIsDM(oPC))&&(!GetIsDMPossessed(oPC))&&((a==0)||(b==0))){SendMessageToPC(oPC,"Examine the scroll to see how to use it!");}else{SetLocalObject(oPC,"Scroll",oItem);if(sVar==""){oNew = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",GetLocation(oPC));AssignCommand(oPC,ActionStartConversation(oNew,"null",TRUE,FALSE));DelayCommand(4.0,FloatingTextStringOnCreature("Ready",oPC,FALSE));}else{SetCustomToken(10186,GetStringLeft(sVar,FindSubString(sVar,"_A_")));SetCustomToken(10187,GetStringRight(sVar,GetStringLength(sVar)-FindSubString(sVar,"_A_")-3));AssignCommand(oPC,ActionStartConversation(oPC,"scroll",TRUE,FALSE));}}}
////////////////////////////////////////////////////////////////////////////////
// Scrolls & Wands
else if(sItemTag=="cr_scroll"){if((!GetIsDM(oPC))&&(!GetIsDMPossessed(oPC))&&(!GetHasFeat(FEAT_SCRIBE_SCROLL,oPC))){FloatingTextStringOnCreature("you need the 'scribe scroll' feat to enchant this scroll",oPC);}else if(GetLocalInt(oItem,"Ready")!=1){ExecuteScript("conv_dm_varempty",oPC);SetLocalObject(oPC,"Item",oItem);SetLocalString(oPC,"Bonus","Scroll_Wand");SetLocalInt(oPC,"Choice1",4);SetLocalInt(oPC,"Step",1);AssignCommand(oPC,ActionStartConversation(oPC,"crafting",TRUE,FALSE));}}
else if(sItemTag=="cr_wand"){if((!GetIsDM(oPC))&&(!GetIsDMPossessed(oPC))&&(!GetHasFeat(FEAT_CRAFT_WAND,oPC))){FloatingTextStringOnCreature("you need the 'craft wand' feat to enchant this wand",oPC);}else if(GetLocalInt(oItem,"Ready")!=1){ExecuteScript("conv_dm_varempty",oPC);SetLocalObject(oPC,"Item",oItem);SetLocalString(oPC,"Bonus","Scroll_Wand");SetLocalInt(oPC,"Choice1",4);SetLocalInt(oPC,"Step",1);AssignCommand(oPC,ActionStartConversation(oPC,"crafting",TRUE,FALSE));}}
////////////////////////////////////////////////////////////////////////////////
// Ships
else if((sItemTag=="tool_ship")||(sItemTag=="tool_airship")||(sItemTag=="tool_starship")){SetLocalString(oPC,"shiptool",sItemTag);AssignCommand(oPC,ActionStartConversation(oPC,"ship",TRUE,FALSE));}
////////////////////////////////////////////////////////////////////////////////
// Super power
else if((sItemTag=="superpower")&&(GetLocalInt(oGoldbag,"Super Power")!=0)){if((GetIsObjectValid(oTarget))&&(oTarget==oPC)){AssignCommand(oPC,ActionStartConversation(oPC,"power",TRUE,FALSE));}else{ExecuteScript("superpower",oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Talents
else if(GetStringLeft(sItemTag,4)=="tal_"){SetLocalInt(oPC,"TalentAction",1);ExecuteScript("talents",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Tents
else if((GetStringLeft(sItemTag,4)=="tent")&&(sAreaName!="Sky")&&(sAreaName!="Space")&&(sAreaName!="Underwater")){if(oTarget==OBJECT_INVALID){if(GetDistanceBetweenLocations(GetLocation(oPC),lTarget)>3.0){FloatingTextStringOnCreature("Too far to install the tent",oPC,FALSE);}else{FloatingTextStringOnCreature("Installing the tent",oPC,FALSE);oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_tent00"+GetStringRight(sItemTag,1),lTarget);SetLocalInt(oNew,"Wear",GetLocalInt(oItem,"Wear"));DestroyObject(oItem);}}}
////////////////////////////////////////////////////////////////////////////////
// UOA Book
else if(sItemTag=="uoabook"){int i;while(i<iUOAreferences){i++;SetLocalInt(oPC,"ChoiceDone"+IntToString(i),1);}AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE));}
////////////////////////////////////////////////////////////////////////////////
// Crafting
else if((GetStringLeft(sItemTag,3)=="cr_")||(GetStringRight(GetStringLeft(sItemTag,4),3)=="cr_")){
// First
int a = 3;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
else{ExecuteScript("crafting",oPC);}}
////////////////////////////////////////////////////////////////////////////////
}
