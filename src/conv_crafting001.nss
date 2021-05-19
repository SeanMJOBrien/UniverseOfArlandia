////////////////////////////////////////////////////////////////////////////////
void main()
{
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oItem = GetLocalObject(oPC,"Item");
object oTarget = GetLocalObject(oPC,"Target");
string sBP = GetLocalString(oPC,"Bonus");
int iCraftType = GetLocalInt(oPC,"CraftType");
int iIntelligence = GetLocalInt(oPC,"Intelligence");
int iClassBonus = GetLocalInt(oPC,"ClassBonus");
int iDC = GetLocalInt(oPC,"DC");
int iXP = GetLocalInt(oPC,"XP");
int iXPBonus = GetLocalInt(oPC,"XPBonus");

int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep))+((iStep-2)*10);

int iMagic;int iResult;string sResult;object oNew;
////////////////////////////////////////////////////////////////////////////////
// Scrolls & Wands
if(iChoice1==4)
 {
iChoice2 = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep))+((iStep-2)*20);
string sWand = GetLocalString(oModule,"Scroll_Wand_"+IntToString(iChoice2));
int j = StringToInt(GetStringLeft(sWand,FindSubString(sWand,"&1&")));
string sName = GetStringRight(GetStringLeft(sWand,FindSubString(sWand,"&2&")),GetStringLength(GetStringLeft(sWand,FindSubString(sWand,"&2&")))-FindSubString(sWand,"&1&")-3);
int k = StringToInt(GetStringRight(GetStringLeft(sWand,FindSubString(sWand,"&3&")),GetStringLength(GetStringLeft(sWand,FindSubString(sWand,"&3&")))-FindSubString(sWand,"&2&")-3));
iMagic = GetHasSpell(j,oPC);

if((iMagic>0)||(GetIsDM(oPC))||(GetIsDMPossessed(oPC)))
  {
AssignCommand(oPC,ActionCastFakeSpellAtObject(j,oItem));
// Wands
if(GetTag(oItem)=="cr_wand")
   {
SetLocalString(oItem,"Bonus",IntToString(k));
DelayCommand(2.0,SetItemCharges(oItem,20));
DelayCommand(2.0,SetName(oItem,GetName(oItem)+" of "+sName));
DelayCommand(2.0,ExecuteScript("bonus",oItem));
   }
// Scrolls
else
   {
     if(j==SPELL_ACID_FOG){sBP = "nw_it_sparscr603";}
else if(j==SPELL_ACID_SPLASH){sBP = "x1_it_sparscr002";}
else if(j==SPELL_AID){sBP = "x2_it_spdvscr201";}
else if(j==SPELL_AMPLIFY){sBP = "x1_it_sparscr102";}
else if(j==SPELL_ANIMATE_DEAD){sBP = "nw_it_sparscr509";}
else if(j==SPELL_AURAOFGLORY){sBP = "x1_it_spdvscr204";}
else if(j==SPELL_AURA_OF_VITALITY){sBP = "x1_it_spdvscr701";}
else if(j==SPELL_AWAKEN){sBP = "x2_it_spdvscr508";}
else if(j==SPELL_BALAGARNSIRONHORN){sBP = "x1_it_sparscr201";}
else if(j==SPELL_BALL_LIGHTNING){sBP = "x2_it_sparscr501";}
else if(j==SPELL_BANE){sBP = "x1_it_spdvscr101";}
else if(j==SPELL_BANISHMENT){sBP = "x1_it_spdvscr601";}
else if(j==SPELL_BARKSKIN){sBP = "x2_it_spdvscr202";}
else if(j==SPELL_BATTLETIDE){sBP = "x2_it_spdvscr501";}
else if(j==SPELL_BESTOW_CURSE){sBP = "nw_it_sparscr414";}
else if(j==SPELL_BIGBYS_CLENCHED_FIST){sBP = "x1_it_sparscr801";}
else if(j==SPELL_BIGBYS_CRUSHING_HAND){sBP = "x1_it_sparscr901";}
else if(j==SPELL_BIGBYS_FORCEFUL_HAND){sBP = "x1_it_sparscr602";}
else if(j==SPELL_BIGBYS_GRASPING_HAND){sBP = "x1_it_sparscr701";}
else if(j==SPELL_BIGBYS_INTERPOSING_HAND){sBP = "x1_it_sparscr502";}
else if(j==SPELL_BLACK_BLADE_OF_DISASTER){sBP = "x2_it_sparscr901";}
else if(j==SPELL_BLACKSTAFF){sBP = "x2_it_sparscr801";}
else if(j==SPELL_BLADE_BARRIER){sBP = "x2_it_spdvscr603";}
else if(j==SPELL_BLADE_THIRST){sBP = "x2_it_spdvscr303";}
else if(j==SPELL_BLESS){sBP = "x2_it_spdvscr103";}
else if(j==SPELL_BLESS_WEAPON){sBP = "x2_it_spdvscr102";}
else if(j==SPELL_BLINDNESS_AND_DEAFNESS){sBP = "nw_it_sparscr211";}
else if(j==SPELL_BLOOD_FRENZY){sBP = "x1_it_spdvscr202";}
else if(j==SPELL_BOMBARDMENT){sBP = "x1_it_spdvscr803";}
else if(j==SPELL_BULLS_STRENGTH){sBP = "nw_it_sparscr212";}
else if(j==SPELL_BURNING_HANDS){sBP = "nw_it_sparscr112";}
else if(j==SPELL_CALL_LIGHTNING){sBP = "x2_it_spdvscr307";}
else if(j==SPELL_CAMOFLAGE){sBP = "x1_it_spdvscr107";}
else if(j==SPELL_CATS_GRACE){sBP = "x2_it_sparscr207";}
else if(j==SPELL_CHAIN_LIGHTNING){sBP = "nw_it_sparscr607";}
else if(j==SPELL_CHARM_MONSTER){sBP = "nw_it_sparscr405";}
else if(j==SPELL_CHARM_PERSON){sBP = "nw_it_sparscr107";}
else if(j==SPELL_CHARM_PERSON_OR_ANIMAL){sBP = "nw_it_spdvscr202";}
else if(j==SPELL_CIRCLE_OF_DEATH){sBP = "nw_it_sparscr610";}
else if(j==SPELL_CIRCLE_OF_DOOM){sBP = "x2_it_spdvscr504";}
else if(j==SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE){sBP = "nw_it_sparscr307";}
else if(j==SPELL_CLARITY){sBP = "nw_it_sparscr217";}
else if(j==SPELL_CLOUD_OF_BEWILDERMENT){sBP = "x2_it_sparscr206";}
else if(j==SPELL_CLOUDKILL){sBP = "nw_it_sparscr502";}
else if(j==SPELL_COLOR_SPRAY){sBP = "nw_it_sparscr110";}
else if(j==SPELL_COMBUST){sBP = "x2_it_sparscr201";}
else if(j==SPELL_CONE_OF_COLD){sBP = "nw_it_sparscr507";}
else if(j==SPELL_CONFUSION){sBP = "nw_it_sparscr406";}
else if(j==SPELL_CONTAGION){sBP = "nw_it_sparscr411";}
else if(j==SPELL_CONTROL_UNDEAD){sBP = "nw_it_sparscr707";}
else if(j==SPELL_CREATE_GREATER_UNDEAD){sBP = "x1_it_spdvscr804";}
else if(j==SPELL_CREATE_UNDEAD){sBP = "x1_it_spdvscr605";}
else if(j==SPELL_CREEPING_DOOM){sBP = "x1_it_spdvscr702";}
else if(j==SPELL_CRUMBLE){sBP = "x2_it_spdvscr601";}
else if(j==SPELL_CURE_CRITICAL_WOUNDS){sBP = "x2_it_spdvscr402";}
else if(j==SPELL_CURE_LIGHT_WOUNDS){sBP = "x2_it_spdvscr104";}
else if(j==SPELL_CURE_MINOR_WOUNDS){sBP = "x2_it_spdvscr001";}
else if(j==SPELL_CURE_MODERATE_WOUNDS){sBP = "x2_it_spdvscr203";}
else if(j==SPELL_CURE_SERIOUS_WOUNDS){sBP = "x2_it_spdvscr308";}
else if(j==SPELL_DARKNESS){sBP = "nw_it_sparscr206";}
else if(j==SPELL_DAZE){sBP = "nw_it_sparscr003";}
else if(j==SPELL_DEAFENING_CLANG){sBP = "x2_it_spdvscr101";}
else if(j==SPELL_DEATH_ARMOR){sBP = "x2_it_sparscr202";}
else if(j==SPELL_DEATH_WARD){sBP = "x2_it_spdvscr403";}
else if(j==SPELL_DELAYED_BLAST_FIREBALL){sBP = "nw_it_sparscr704";}
else if(j==SPELL_DESTRUCTION){sBP = "x1_it_spdvscr703";}
else if(j==SPELL_DIRGE){sBP = "x1_it_sparscr601";}
else if(j==SPELL_DISMISSAL){sBP = "nw_it_sparscr501";}
else if(j==SPELL_DISPEL_MAGIC){sBP = "nw_it_sparscr301";}
else if(j==SPELL_DISPLACEMENT){sBP = "x1_it_sparscr301";}
else if(j==SPELL_DIVINE_FAVOR){sBP = "x1_it_spdvscr102";}
else if(j==SPELL_DIVINE_POWER){sBP = "x2_it_spdvscr404";}
else if(j==SPELL_DOMINATE_ANIMAL){sBP = "x2_it_spdvscr309";}
else if(j==SPELL_DOMINATE_MONSTER){sBP = "nw_it_sparscr905";}
else if(j==SPELL_DOMINATE_PERSON){sBP = "nw_it_sparscr503";}
else if(j==SPELL_DOOM){sBP = "x2_it_spdvscr105";}
else if(j==SPELL_DROWN){sBP = "x1_it_spdvscr604";}
else if(j==SPELL_EAGLE_SPLEDOR){sBP = "nw_it_sparscr219";}
else if(j==SPELL_EARTHQUAKE){sBP = "x1_it_spdvscr801";}
else if(j==SPELL_ELECTRIC_JOLT){sBP = "x1_it_sparscr003";}
else if(j==SPELL_ELEMENTAL_SHIELD){sBP = "nw_it_sparscr416";}
else if(j==SPELL_ELEMENTAL_SWARM){sBP = "x2_it_spdvscr901";}
else if(j==SPELL_ENDURANCE){sBP = "nw_it_sparscr215";}
else if(j==SPELL_ENDURE_ELEMENTS){sBP = "nw_it_sparscr101";}
else if(j==SPELL_ENERGY_BUFFER){sBP = "x2_it_sparscr503";}
else if(j==SPELL_ENERGY_DRAIN){sBP = "nw_it_sparscr908";}
else if(j==SPELL_ENERVATION){sBP = "nw_it_sparscr412";}
else if(j==SPELL_ENTANGLE){sBP = "x2_it_spdvscr106";}
else if(j==SPELL_ENTROPIC_SHIELD){sBP = "x1_it_spdvscr103";}
else if(j==SPELL_ETHEREAL_VISAGE){sBP = "nw_it_sparscr608";}
else if(j==SPELL_EVARDS_BLACK_TENTACLES){sBP = "nw_it_sparscr418";}
else if(j==SPELL_EXPEDITIOUS_RETREAT){sBP = "x1_it_sparscr101";}
else if(j==SPELL_FEAR){sBP = "nw_it_sparscr413";}
else if(j==SPELL_FEEBLEMIND){sBP = "nw_it_sparscr504";}
else if(j==SPELL_FIND_TRAPS){sBP = "x2_it_sparscr305";}
else if(j==SPELL_FINGER_OF_DEATH){sBP = "nw_it_sparscr708";}
else if(j==SPELL_FIRE_STORM){sBP = "x1_it_spdvscr704";}
else if(j==SPELL_FIREBALL){sBP = "nw_it_sparscr309";}
else if(j==SPELL_FIREBRAND){sBP = "x1_it_sparscr501";}
else if(j==SPELL_FLAME_ARROW){sBP = "nw_it_sparscr304";}
else if(j==SPELL_FLAME_LASH){sBP = "x1_it_spdvscr205";}
else if(j==SPELL_FLAME_STRIKE){sBP = "x1_it_spdvscr403";}
else if(j==SPELL_FLARE){sBP = "x1_it_sparscr001";}
else if(j==SPELL_FLESH_TO_STONE){sBP = "x1_it_sparscr605";}
else if(j==SPELL_FOXS_CUNNING){sBP = "nw_it_sparscr220";}
else if(j==SPELL_FREEDOM_OF_MOVEMENT){sBP = "x2_it_spdvscr405";}
else if(j==SPELL_GATE){sBP = "nw_it_sparscr902";}
else if(j==SPELL_GEDLEES_ELECTRIC_LOOP){sBP = "x2_it_sparscr203";}
else if(j==SPELL_GHOSTLY_VISAGE){sBP = "nw_it_sparscr208";}
else if(j==SPELL_GHOUL_TOUCH){sBP = "nw_it_sparscr209";}
else if(j==SPELL_GLOBE_OF_INVULNERABILITY){sBP = "nw_it_sparscr601";}
else if(j==SPELL_GLYPH_OF_WARDING){sBP = "x2_it_spdvscr306";}
else if(j==SPELL_GREASE){sBP = "nw_it_sparscr103";}
else if(j==SPELL_GREAT_THUNDERCLAP){sBP = "x2_it_sparscr701";}
else if(j==SPELL_GREATER_DISPELLING){sBP = "nw_it_sparscr602";}
else if(j==SPELL_GREATER_MAGIC_FANG){sBP = "x1_it_spdvscr303";}
else if(j==SPELL_GREATER_MAGIC_WEAPON){sBP = "x2_it_sparscr304";}
else if(j==SPELL_GREATER_PLANAR_BINDING){sBP = "nw_it_sparscr803";}
else if(j==SPELL_GREATER_RESTORATION){sBP = "nw_it_spdvscr701";}
else if(j==SPELL_GREATER_SPELL_BREACH){sBP = "nw_it_sparscr612";}
else if(j==SPELL_GREATER_SPELL_MANTLE){sBP = "nw_it_sparscr912";}
else if(j==SPELL_GREATER_STONESKIN){sBP = "nw_it_sparscr613";}
else if(j==SPELL_GUST_OF_WIND){sBP = "x1_it_sparscr303";}
else if(j==SPELL_HAMMER_OF_THE_GODS){sBP = "x2_it_spdvscr406";}
else if(j==SPELL_HARM){sBP = "x2_it_spdvscr604";}
else if(j==SPELL_HASTE){sBP = "nw_it_sparscr312";}
else if(j==SPELL_HEAL){sBP = "x2_it_spdvscr605";}
else if(j==SPELL_HEALING_CIRCLE){sBP = "x2_it_spdvscr505";}
else if(j==SPELL_HEALING_STING){sBP = "x2_it_spdvscr302";}
else if(j==SPELL_HOLD_ANIMAL){sBP = "x2_it_spdvscr204";}
else if(j==SPELL_HOLD_MONSTER){sBP = "nw_it_sparscr505";}
else if(j==SPELL_HOLD_PERSON){sBP = "nw_it_sparscr308";}
else if(j==SPELL_HOLY_SWORD){sBP = "x2_it_spdvscr401";}
else if(j==SPELL_HORIZIKAULS_BOOM){sBP = "x2_it_sparscr101";}
else if(j==SPELL_HORRID_WILTING){sBP = "nw_it_sparscr809";}
else if(j==SPELL_ICE_DAGGER){sBP = "x2_it_sparscr104";}
else if(j==SPELL_ICE_STORM){sBP = "x2_it_sparscr401";}
else if(j==SPELL_IDENTIFY){sBP = "nw_it_sparscr106";}
else if(j==SPELL_IMPLOSION){sBP = "x2_it_spdvscr902";}
else if(j==SPELL_IMPROVED_INVISIBILITY){sBP = "nw_it_sparscr408";}
else if(j==SPELL_INCENDIARY_CLOUD){sBP = "nw_it_sparscr804";}
else if(j==SPELL_INFERNO){sBP = "x1_it_spdvscr501";}
else if(j==SPELL_INFESTATION_OF_MAGGOTS){sBP = "x2_it_spdvscr301";}
else if(j==SPELL_INFLICT_CRITICAL_WOUNDS){sBP = "x1_it_spdvscr401";}
else if(j==SPELL_INFLICT_LIGHT_WOUNDS){sBP = "x1_it_spdvscr104";}
else if(j==SPELL_INFLICT_MINOR_WOUNDS){sBP = "x1_it_spdvscr001";}
else if(j==SPELL_INFLICT_MODERATE_WOUNDS){sBP = "x1_it_spdvscr201";}
else if(j==SPELL_INFLICT_SERIOUS_WOUNDS){sBP = "x1_it_spdvscr302";}
else if(j==SPELL_INVISIBILITY){sBP = "nw_it_sparscr207";}
else if(j==SPELL_INVISIBILITY_PURGE){sBP = "x2_it_spdvscr310";}
else if(j==SPELL_INVISIBILITY_SPHERE){sBP = "nw_it_sparscr314";}
else if(j==SPELL_IRONGUTS){sBP = "x2_it_sparscr102";}
else if(j==SPELL_ISAACS_GREATER_MISSILE_STORM){sBP = "x1_it_sparscr603";}
else if(j==SPELL_ISAACS_LESSER_MISSILE_STORM){sBP = "x1_it_sparscr401";}
else if(j==SPELL_KEEN_EDGE){sBP = "x2_it_sparscr303";}
else if(j==SPELL_KNOCK){sBP = "nw_it_sparscr216";}
else if(j==SPELL_LEGEND_LORE){sBP = "x2_it_sparscr602";}
else if(j==SPELL_LESSER_DISPEL){sBP = "nw_it_sparscr218";}
else if(j==SPELL_LESSER_MIND_BLANK){sBP = "nw_it_sparscr511";}
else if(j==SPELL_LESSER_PLANAR_BINDING){sBP = "nw_it_sparscr512";}
else if(j==SPELL_LESSER_RESTORATION){sBP = "nw_it_spdvscr201";}
else if(j==SPELL_LESSER_SPELL_BREACH){sBP = "nw_it_sparscr417";}
else if(j==SPELL_LESSER_SPELL_MANTLE){sBP = "nw_it_sparscr513";}
else if(j==SPELL_LIGHT){sBP = "nw_it_sparscr004";}
else if(j==SPELL_LIGHTNING_BOLT){sBP = "nw_it_sparscr310";}
else if(j==SPELL_MAGE_ARMOR){sBP = "nw_it_sparscr6nw_it_sparscr10403";}
else if(j==SPELL_MAGIC_FANG){sBP = "x1_it_spdvscr106";}
else if(j==SPELL_MAGIC_MISSILE){sBP = "nw_it_sparscr109";}
else if(j==SPELL_MAGIC_VESTMENT){sBP = "x2_it_spdvscr304";}
else if(j==SPELL_MAGIC_WEAPON){sBP = "x2_it_sparscr105";}
else if(j==SPELL_MASS_BLINDNESS_AND_DEAFNESS){sBP = "nw_it_sparscr807";}
else if(j==SPELL_MASS_CAMOFLAGE){sBP = "x1_it_spdvscr402";}
else if(j==SPELL_MASS_CHARM){sBP = "nw_it_sparscr806";}
else if(j==SPELL_MASS_HASTE){sBP = "nw_it_sparscr611";}
else if(j==SPELL_MASS_HEAL){sBP = "x2_it_spdvscr801";}
else if(j==SPELL_MELFS_ACID_ARROW){sBP = "nw_it_sparscr202";}
else if(j==SPELL_MESTILS_ACID_BREATH){sBP = "x2_it_sparscr301";}
else if(j==SPELL_MESTILS_ACID_SHEATH){sBP = "x2_it_sparscr502";}
else if(j==SPELL_METEOR_SWARM){sBP = "nw_it_sparscr906";}
else if(j==SPELL_MIND_BLANK){sBP = "nw_it_sparscr801";}
else if(j==SPELL_MIND_FOG){sBP = "nw_it_sparscr506";}
else if(j==SPELL_MINOR_GLOBE_OF_INVULNERABILITY){sBP = "nw_it_sparscr401";}
else if(j==SPELL_MONSTROUS_REGENERATION){sBP = "x2_it_spdvscr502";}
else if(j==SPELL_MORDENKAINENS_DISJUNCTION){sBP = "nw_it_sparscr901";}
else if(j==SPELL_MORDENKAINENS_SWORD){sBP = "nw_it_sparscr705";}
else if(j==SPELL_NATURES_BALANCE){sBP = "x2_it_spdvscr802";}
else if(j==SPELL_NEGATIVE_ENERGY_BURST){sBP = "nw_it_sparscr315";}
else if(j==SPELL_NEGATIVE_ENERGY_PROTECTION){sBP = "x2_it_spdvscr311";}
else if(j==SPELL_NEGATIVE_ENERGY_RAY){sBP = "nw_it_sparscr113";}
else if(j==SPELL_NEUTRALIZE_POISON){sBP = "nw_it_spdvscr402";}
else if(j==SPELL_ONE_WITH_THE_LAND){sBP = "x1_it_spdvscr203";}
else if(j==SPELL_OWLS_INSIGHT){sBP = "x1_it_spdvscr502";}
else if(j==SPELL_OWLS_WISDOM){sBP = "nw_it_sparscr221";}
else if(j==SPELL_PHANTASMAL_KILLER){sBP = "nw_it_sparscr409";}
else if(j==SPELL_PLANAR_ALLY){sBP = "x1_it_spdvscr603";}
else if(j==SPELL_PLANAR_BINDING){sBP = "nw_it_sparscr604";}
else if(j==SPELL_POISON){sBP = "x2_it_spdvscr407";}
else if(j==SPELL_POLYMORPH_SELF){sBP = "nw_it_sparscr415";}
else if(j==SPELL_POWER_WORD_KILL){sBP = "nw_it_sparscr903";}
else if(j==SPELL_POWER_WORD_STUN){sBP = "nw_it_sparscr702";}
else if(j==SPELL_PRAYER){sBP = "x2_it_spdvscr312";}
else if(j==SPELL_PREMONITION){sBP = "nw_it_sparscr808";}
else if(j==SPELL_PRISMATIC_SPRAY){sBP = "nw_it_sparscr706";}
else if(j==SPELL_PROTECTION_FROM_ELEMENTS){sBP = "nw_it_sparscr303";}
else if(j==SPELL_PROTECTION_FROM_SPELLS){sBP = "nw_it_sparscr802";}
else if(j==SPELL_QUILLFIRE){sBP = "x1_it_spdvscr305";}
else if(j==SPELL_RAISE_DEAD){sBP = "nw_it_spdvscr501";}
else if(j==SPELL_RAY_OF_ENFEEBLEMENT){sBP = "nw_it_sparscr111";}
else if(j==SPELL_RAY_OF_FROST){sBP = "nw_it_sparscr002";}
else if(j==SPELL_REGENERATE){sBP = "x2_it_spdvscr702";}
else if(j==SPELL_REMOVE_BLINDNESS_AND_DEAFNESS){sBP = "nw_it_spdvscr301";}
else if(j==SPELL_REMOVE_CURSE){sBP = "nw_it_sparscr402";}
else if(j==SPELL_REMOVE_DISEASE){sBP = "nw_it_spdvscr302";}
else if(j==SPELL_REMOVE_FEAR){sBP = "x2_it_spdvscr107";}
else if(j==SPELL_REMOVE_PARALYSIS){sBP = "x2_it_spdvscr205";}
else if(j==SPELL_RESIST_ELEMENTS){sBP = "nw_it_sparscr201";}
else if(j==SPELL_RESISTANCE){sBP = "nw_it_sparscr001";}
else if(j==SPELL_RESTORATION){sBP = "nw_it_spdvscr401";}
else if(j==SPELL_RESURRECTION){sBP = "nw_it_spdvscr702";}
else if(j==SPELL_SANCTUARY){sBP = "x2_it_spdvscr108";}
else if(j==SPELL_SCARE){sBP = "nw_it_sparscr210";}
else if(j==SPELL_SCINTILLATING_SPHERE){sBP = "x2_it_sparscr302";}
else if(j==SPELL_SEARING_LIGHT){sBP = "x2_it_spdvscr313";}
else if(j==SPELL_SEE_INVISIBILITY){sBP = "nw_it_sparscr205";}
else if(j==SPELL_SHADOW_SHIELD){sBP = "x2_it_sparscr703";}
else if(j==SPELL_SHAPECHANGE){sBP = "nw_it_sparscr910";}
else if(j==SPELL_SHELGARNS_PERSISTENT_BLADE){sBP = "x2_it_sparscr103";}
else if(j==SPELL_SHIELD){sBP = "x1_it_sparscr103";}
else if(j==SPELL_SHIELD_OF_FAITH){sBP = "x1_it_spdvscr105";}
else if(j==SPELL_SILENCE){sBP = "nw_it_spdvscr203";}
else if(j==SPELL_SLAY_LIVING){sBP = "x2_it_spdvscr506";}
else if(j==SPELL_SLEEP){sBP = "nw_it_sparscr108";}
else if(j==SPELL_SLOW){sBP = "nw_it_sparscr313";}
else if(j==SPELL_SOUND_BURST){sBP = "nw_it_spdvscr204";}
else if(j==SPELL_SPELL_MANTLE){sBP = "nw_it_sparscr701";}
else if(j==SPELL_SPELL_RESISTANCE){sBP = "x2_it_spdvscr507";}
else if(j==SPELL_SPIKE_GROWTH){sBP = "x1_it_spdvscr304";}
else if(j==SPELL_STINKING_CLOUD){sBP = "nw_it_sparscr305";}
else if(j==SPELL_STONE_BONES){sBP = "x2_it_sparscr204";}
else if(j==SPELL_STONE_TO_FLESH){sBP = "x1_it_sparscr604";}
else if(j==SPELL_STONEHOLD){sBP = "x2_it_spdvscr602";}
else if(j==SPELL_STONESKIN){sBP = "nw_it_sparscr403";}
else if(j==SPELL_STORM_OF_VENGEANCE){sBP = "x2_it_spdvscr903";}
else if(j==SPELL_SUMMON_CREATURE_I){sBP = "nw_it_sparscr105";}
else if(j==SPELL_SUMMON_CREATURE_II){sBP = "nw_it_sparscr203";}
else if(j==SPELL_SUMMON_CREATURE_III){sBP = "nw_it_sparscr306";}
else if(j==SPELL_SUMMON_CREATURE_IV){sBP = "nw_it_sparscr404";}
else if(j==SPELL_SUMMON_CREATURE_V){sBP = "nw_it_sparscr510";}
else if(j==SPELL_SUMMON_CREATURE_VI){sBP = "nw_it_sparscr605";}
else if(j==SPELL_SUMMON_CREATURE_VII){sBP = "nw_it_sparscr703";}
else if(j==SPELL_SUMMON_CREATURE_VIII){sBP = "nw_it_sparscr805";}
else if(j==SPELL_SUMMON_CREATURE_IX){sBP = "nw_it_sparscr904";}
else if(j==SPELL_SUNBEAM){sBP = "x2_it_spdvscr803";}
else if(j==SPELL_SUNBURST){sBP = "x1_it_spdvscr802";}
else if(j==SPELL_TASHAS_HIDEOUS_LAUGHTER){sBP = "x1_it_sparscr202";}
else if(j==SPELL_TENSERS_TRANSFORMATION){sBP = "nw_it_sparscr614";}
else if(j==SPELL_TIME_STOP){sBP = "nw_it_sparscr911";}
else if(j==SPELL_TRUE_SEEING){sBP = "nw_it_sparscr606";}
else if(j==SPELL_TRUE_STRIKE){sBP = "x1_it_sparscr104";}
else if(j==SPELL_UNDEATH_TO_DEATH){sBP = "x2_it_sparscr601";}
else if(j==SPELL_UNDEATHS_ETERNAL_FOE){sBP = "x1_it_spdvscr901";}
else if(j==SPELL_VAMPIRIC_TOUCH){sBP = "nw_it_sparscr311";}
else if(j==SPELL_VINE_MINE){sBP = "x2_it_spdvscr503";}
else if(j==SPELL_VIRTUE){sBP = "x2_it_spdvscr002";}
else if(j==SPELL_WAIL_OF_THE_BANSHEE){sBP = "nw_it_sparscr909";}
else if(j==SPELL_WALL_OF_FIRE){sBP = "nw_it_sparscr407";}
else if(j==SPELL_WEB){sBP = "nw_it_sparscr204";}
else if(j==SPELL_WEIRD){sBP = "nw_it_sparscr907";}
else if(j==SPELL_WORD_OF_FAITH){sBP = "x2_it_spdvscr701";}
else if(j==SPELL_WOUNDING_WHISPERS){sBP = "x1_it_sparscr302";}
else{SetLocalString(oItem,"Bonus",IntToString(k));DelayCommand(2.0,SetItemCharges(oItem,20));DelayCommand(2.0,SetName(oItem,GetName(oItem)+" of "+sName));DelayCommand(2.0,ExecuteScript("bonus",oItem));}

oNew = CreateItemOnObject(sBP,oPC);SetStolenFlag(oNew,TRUE);DestroyObject(oItem);
   }
DelayCommand(2.0,FloatingTextStringOnCreature("enchantment successful",oPC));
DelayCommand(2.0,GiveXPToCreature(oPC,10));DelayCommand(2.0,FloatingTextStringOnCreature("10 xps",oPC));
  }
else
  {
FloatingTextStringOnCreature("you don't have this spell memorised",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
////////////////////////////////////////////////////////////////////////////////
// Bonus Feat
if(iChoice1==1)
  {
     if(iChoice2==1) {iMagic = IP_CONST_FEAT_ALERTNESS;}
else if(iChoice2==2) {iMagic = IP_CONST_FEAT_AMBIDEXTROUS;}
else if(iChoice2==3) {iMagic = IP_CONST_FEAT_ARMOR_PROF_HEAVY;}
else if(iChoice2==4) {iMagic = IP_CONST_FEAT_ARMOR_PROF_LIGHT;}
else if(iChoice2==5) {iMagic = IP_CONST_FEAT_ARMOR_PROF_MEDIUM;}
else if(iChoice2==6) {iMagic = IP_CONST_FEAT_CLEAVE;}
else if(iChoice2==7) {iMagic = IP_CONST_FEAT_COMBAT_CASTING;}
else if(iChoice2==8) {iMagic = IP_CONST_FEAT_DISARM;}
else if(iChoice2==9) {iMagic = IP_CONST_FEAT_DODGE;}
else if(iChoice2==10){iMagic = IP_CONST_FEAT_EXTRA_TURNING;}
else if(iChoice2==11){iMagic = IP_CONST_FEAT_KNOCKDOWN;}
else if(iChoice2==12){iMagic = IP_CONST_FEAT_MOBILITY;}
else if(iChoice2==13){iMagic = IP_CONST_FEAT_POINTBLANK;}
else if(iChoice2==14){iMagic = IP_CONST_FEAT_POWERATTACK;}
else if(iChoice2==15){iMagic = IP_CONST_FEAT_RAPID_SHOT;}
else if(iChoice2==16){iMagic = IP_CONST_FEAT_SHIELD_PROFICIENCY;}
else if(iChoice2==17){iMagic = IP_CONST_FEAT_SPELLPENETRATION;}
else if(iChoice2==18){iMagic = IP_CONST_FEAT_TWO_WEAPON_FIGHTING;}
else if(iChoice2==19){iMagic = IP_CONST_FEAT_WEAPFINESSE;}
else if(iChoice2==20){iMagic = IP_CONST_FEAT_WEAPON_PROF_EXOTIC;}
else if(iChoice2==21){iMagic = IP_CONST_FEAT_WEAPON_PROF_MARTIAL;}
else if(iChoice2==22){iMagic = IP_CONST_FEAT_WEAPON_PROF_SIMPLE;}
else if(iChoice2==23){iMagic = IP_CONST_FEAT_WHIRLWIND;}
  }
////////////////////////////////////////////////////////////////////////////////
// Bonus Skill
else if(iChoice1==2)
  {
     if(iChoice2==1) {iMagic = SKILL_ANIMAL_EMPATHY;}
else if(iChoice2==2) {iMagic = SKILL_APPRAISE;}
else if(iChoice2==3) {iMagic = SKILL_BLUFF;}
else if(iChoice2==4) {iMagic = SKILL_CONCENTRATION;}
else if(iChoice2==5) {iMagic = SKILL_CRAFT_ARMOR;}
else if(iChoice2==6) {iMagic = SKILL_CRAFT_TRAP;}
else if(iChoice2==7) {iMagic = SKILL_CRAFT_WEAPON;}
else if(iChoice2==8) {iMagic = SKILL_DISABLE_TRAP;}
else if(iChoice2==9) {iMagic = SKILL_DISCIPLINE;}
else if(iChoice2==10){iMagic = SKILL_HEAL;}
else if(iChoice2==11){iMagic = SKILL_HIDE;}
else if(iChoice2==12){iMagic = SKILL_INTIMIDATE;}
else if(iChoice2==13){iMagic = SKILL_LISTEN;}
else if(iChoice2==14){iMagic = SKILL_LORE;}
else if(iChoice2==15){iMagic = SKILL_MOVE_SILENTLY;}
else if(iChoice2==16){iMagic = SKILL_OPEN_LOCK;}
else if(iChoice2==17){iMagic = SKILL_PARRY;}
else if(iChoice2==18){iMagic = SKILL_PERFORM;}
else if(iChoice2==19){iMagic = SKILL_PERSUADE;}
else if(iChoice2==20){iMagic = SKILL_PICK_POCKET;}
else if(iChoice2==21){iMagic = SKILL_RIDE;}
else if(iChoice2==22){iMagic = SKILL_SEARCH;}
else if(iChoice2==23){iMagic = SKILL_SET_TRAP;}
else if(iChoice2==24){iMagic = SKILL_SPELLCRAFT;}
else if(iChoice2==25){iMagic = SKILL_SPOT;}
else if(iChoice2==26){iMagic = SKILL_TAUNT;}
else if(iChoice2==27){iMagic = SKILL_TUMBLE;}
else if(iChoice2==28){iMagic = SKILL_USE_MAGIC_DEVICE;}
  }
////////////////////////////////////////////////////////////////////////////////
// Immunity
else if(iChoice1==3)
  {
     if(iChoice2==1) {iMagic = IP_CONST_IMMUNITYMISC_BACKSTAB;}
else if(iChoice2==2) {iMagic = IP_CONST_IMMUNITYMISC_CRITICAL_HITS;}
else if(iChoice2==3) {iMagic = IP_CONST_IMMUNITYMISC_DEATH_MAGIC;}
else if(iChoice2==4) {iMagic = IP_CONST_IMMUNITYMISC_DISEASE;}
else if(iChoice2==5) {iMagic = IP_CONST_IMMUNITYMISC_FEAR;}
else if(iChoice2==6) {iMagic = IP_CONST_IMMUNITYMISC_KNOCKDOWN;}
else if(iChoice2==7) {iMagic = IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN;}
else if(iChoice2==8) {iMagic = IP_CONST_IMMUNITYMISC_MINDSPELLS;}
else if(iChoice2==9) {iMagic = IP_CONST_IMMUNITYMISC_PARALYSIS;}
else if(iChoice2==10){iMagic = IP_CONST_IMMUNITYMISC_POISON;}
  }
////////////////////////////////////////////////////////////////////////////////
iResult = d20(1)+iCraftType+iIntelligence+iClassBonus;if(iResult>=iDC){SetLocalString(oTarget,"Bonus",sBP+" "+IntToString(iMagic));ExecuteScript("bonus",oTarget);iXP = iXP+iXPBonus;GiveXPToCreature(oPC,iXP);sResult = "success";}else{sResult = "failure";if(GetItemStackSize(oTarget)>1){SetItemStackSize(oTarget,GetItemStackSize(oTarget)-1);}else{DestroyObject(oTarget);}}FloatingTextStringOnCreature(IntToString(iResult)+" vs "+IntToString(iDC)+" : "+sResult,oPC,FALSE);if(iXP>0){FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);}if(GetItemStackSize(oItem)>1){SetItemStackSize(oItem,GetItemStackSize(oItem)-1);}else{DestroyObject(oItem);}
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalObject(oPC,"Item");DeleteLocalObject(oTarget,"Item");
////////////////////////////////////////////////////////////////////////////////
}
