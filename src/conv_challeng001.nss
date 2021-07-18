////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLevel = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
string sTag = GetTag(OBJECT_SELF);
//
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
object oDoor = GetNearestObjectByTag("door_challenge");
//
object oNew;string sSpawn;int iSpell = Random(3)+1;
////////////////////////////////////////////////////////////////////////////////
// Monster challenges
if(sTag=="altar_challenges")
 {
     if(iLevel<11){sSpawn = "mn_statueanim001";}
else if(iLevel<16){sSpawn = "mn_gorochem001";}
else              {sSpawn = "mn_golem004";}

     if(iSpell==1){iSpell = SPELL_FIREBALL;}
else if(iSpell==2){iSpell = SPELL_HAMMER_OF_THE_GODS;}
else if(iSpell==3){iSpell = SPELL_LIGHTNING_BOLT;}

oNew = CreateObject(OBJECT_TYPE_CREATURE,sSpawn,GetLocation(OBJECT_SELF));DelayCommand(3.0,AssignCommand(oNew,ActionAttack(oPC)));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellImmunity(iSpell),oNew);

SetLocalObject(OBJECT_SELF,"FireMonster",oNew);
SetLocalObject(OBJECT_SELF,"PC",oPC);
SetLocalInt(OBJECT_SELF,"Firing",iSpell+1);
SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));
SetLocalInt(oModule,sPlanet+sArea+GetName(oPC)+"MC",1);

SetLocalInt(oGoldbag,"Challenge",1);
 }
////////////////////////////////////////////////////////////////////////////////
// Training session
else if(sTag=="trainer")
 {
SetLocalInt(oPC,"Training",1);
SetLocalInt(oModule,sPlanet+"_"+sArea+"_"+GetName(oPC),1);
TakeGoldFromCreature(50,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
}
