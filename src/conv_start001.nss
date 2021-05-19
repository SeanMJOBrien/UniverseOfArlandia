void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iGender = GetGender(oPC);
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");
int iAppOrig = GetLocalInt(oGoldbag,"AppOrig");
int iAppearance;string sMes;int iHead;

     if(iChoice==1) {iAppearance = 1002;} // Brownie
else if(iChoice==2) {iAppearance = APPEARANCE_TYPE_BUGBEAR_A;}
else if(iChoice==3) {iAppearance = APPEARANCE_TYPE_DROW_FIGHTER;}
else if(iChoice==4) {iAppearance = APPEARANCE_TYPE_FAIRY;}
else if(iChoice==5) {iAppearance = APPEARANCE_TYPE_GOBLIN_A;}
else if(iChoice==6) {iAppearance = APPEARANCE_TYPE_GNOLL_WARRIOR;}
else if(iChoice==7) {if(iGender==GENDER_FEMALE){iAppearance = 1516;}else{iAppearance = 1518;}} // Kenku
else if(iChoice==8) {iAppearance = APPEARANCE_TYPE_KOBOLD_A;}
else if(iChoice==9) {iAppearance = APPEARANCE_TYPE_LIZARDFOLK_A;}
else if(iChoice==10){iAppearance = APPEARANCE_TYPE_MINOTAUR;}
else if(iChoice==11){iAppearance = APPEARANCE_TYPE_OGRE;}
else if(iChoice==12){iAppearance = APPEARANCE_TYPE_ORC_A;}
else if(iChoice==13){iAppearance = APPEARANCE_TYPE_TROLL;}
else if(iChoice==14){iAppearance = APPEARANCE_TYPE_WERECAT;}
else if(iChoice==15){iAppearance = APPEARANCE_TYPE_WEREWOLF;}
else if(iChoice==16){iAppearance = APPEARANCE_TYPE_GNOME;iHead = 30;} // Narok
else if(iChoice==17){iAppearance = 1568;} // Abishai
else if(iChoice==18){iAppearance = 1434;} // Cornugon
else if(iChoice==19){iAppearance = 392;}  // Devil
else if(iChoice==20){iAppearance = 1418;} // Glabrezu
else if(iChoice==21){iAppearance = 4577;} // Nalfeshnee
else if(iChoice==22){iAppearance = 1936;} // Oschore
else if(iChoice==23){iAppearance = APPEARANCE_TYPE_SUCCUBUS;}
else if(iChoice==24){iAppearance = 3038;} // Yagnoloth

if(iAppOrig==0){SetLocalInt(oGoldbag,"AppOrig",GetAppearanceType(oPC)+1);SetLocalInt(oPC,"HeadOrig",GetCreatureBodyPart(CREATURE_PART_HEAD,oPC)+1);}
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),oPC);
SetCreatureAppearanceType(oPC,iAppearance);
if(iHead>0){SetCreatureBodyPart(CREATURE_PART_HEAD,iHead,oPC);}
SetLocalInt(oGoldbag,"Race",iChoice);
}
