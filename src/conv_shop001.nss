#include "nw_i0_plot"
#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oStore = GetNearestObject(OBJECT_TYPE_STORE);
object oArea = GetArea(oPC);
//
string sGuild = GetLocalString(oGoldbag,"Guild");
int iGuild = GetLocalInt(oGoldbag,"GuildMB");
object oMember = GetFirstFactionMember(oPC);
int iLevel = GetLocalInt(oGoldbag,"GuildLevel");
int iLevel2 = GetLocalInt(oArea,"Level");
int iStructure = GetLocalInt(oArea,"Structure");
int iAppraise;
//
int n;if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}}
if((n>=iDomainGuildMin)&&(iLevel>=2)){iAppraise = iAppraise+10;}
if(iStructure==16){if(iLevel>=2){iAppraise = iAppraise+10;}if(iLevel>=4){iAppraise = iAppraise+10;}}

// Feats bonus
if(
((GetLocalInt(oGoldbag,"Alchemist")==1)&&(GetTag(oStore)=="store005"))||
((GetLocalInt(oGoldbag,"Animaler")==1)&&(GetTag(oStore)=="store011"))||
((GetLocalInt(oGoldbag,"Architect")==1)&&(GetTag(oStore)=="store016"))||
((GetLocalInt(oGoldbag,"Armorsmith")==1)&&(GetTag(oStore)=="store003"))||
((GetLocalInt(oGoldbag,"Banker")==1)&&(GetTag(oStore)=="store010"))||
((GetLocalInt(oGoldbag,"Blacksmith")==1)&&(GetTag(oStore)=="store012"))||
((GetLocalInt(oGoldbag,"Bookseller")==1)&&(GetTag(oStore)=="store009"))||
((GetLocalInt(oGoldbag,"Caster")==1)&&(GetTag(oStore)=="store004"))||
((GetLocalInt(oGoldbag,"Engineer")==1)&&(GetTag(oStore)=="store016"))||
((GetLocalInt(oGoldbag,"Foodmaker")==1)&&(GetTag(oStore)=="store001"))||
((GetLocalInt(oGoldbag,"Healer")==1)&&(GetTag(oStore)=="store015"))||
((GetLocalInt(oGoldbag,"Jeweler")==1)&&(GetTag(oStore)=="store006"))||
((GetLocalInt(oGoldbag,"Tailor")==1)&&(GetTag(oStore)=="store008"))||
((GetLocalInt(oGoldbag,"Taverner")==1)&&(GetTag(oStore)=="store014"))||
((GetLocalInt(oGoldbag,"Trainer")==1)&&(GetTag(oStore)=="store017"))||
((GetLocalInt(oGoldbag,"Weaponsmith")==1)&&(GetTag(oStore)=="store002"))
){iAppraise = iAppraise+20;}


if(GetTag(oStore)=="store000")
 {
OpenStore(oStore,oPC);
 }
else
 {
DeleteLocalInt(oPC,"Seller");
gplotAppraiseOpenStore(oStore,oPC,0,iAppraise);
 }
}
