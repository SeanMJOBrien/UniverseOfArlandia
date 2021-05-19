void main()
{
object oPC = GetLocalObject(OBJECT_SELF,"PC");
string sTag = GetLocalString(OBJECT_SELF,"DragonTag");
string sName = GetLocalString(OBJECT_SELF,"DragonName");
int iHP = GetLocalInt(OBJECT_SELF,"DragonHP");
string sVar = GetLocalString(OBJECT_SELF,"Variables");
int iStop = GetLocalInt(OBJECT_SELF,"Stop");
int iPersistent = GetLocalInt(OBJECT_SELF,"Persistent");
int iFaction = GetLocalInt(OBJECT_SELF,"Faction");
int iAction = GetLocalInt(OBJECT_SELF,"Action");
object oNew;string sBP;

if(iAction==2)
 {
SetLocalInt(OBJECT_SELF,"Action",3);DelayCommand(0.5,ExecuteScript("dragons",OBJECT_SELF));
 }
else
 {
     if(sTag=="mn_dragon001"){sBP = "mn_dragon006";}else if(sTag=="mn_dragon006"){sBP = "mn_dragon001";}
else if(sTag=="mn_dragon002"){sBP = "mn_dragon007";}else if(sTag=="mn_dragon007"){sBP = "mn_dragon002";}
else if(sTag=="mn_dragon003"){sBP = "mn_dragon008";}else if(sTag=="mn_dragon008"){sBP = "mn_dragon003";}
else if(sTag=="mn_dragon004"){sBP = "mn_dragon009";}else if(sTag=="mn_dragon009"){sBP = "mn_dragon004";}
else if(sTag=="mn_dragon005"){sBP = "mn_dragon010";}else if(sTag=="mn_dragon010"){sBP = "mn_dragon005";}

oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,GetLocation(OBJECT_SELF));

SetLocalObject(oPC,"oOther",oNew);
SetLocalString(oNew,"Variables",sVar);
SetLocalInt(oNew,"Stop",iStop);
SetLocalInt(oNew,"Persistent",iPersistent);
SetName(oNew,sName);
if(iFaction==1){ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);}else if(iFaction==2){ChangeToStandardFaction(oNew,STANDARD_FACTION_DEFENDER);}else if(iFaction==3){ChangeToStandardFaction(oNew,STANDARD_FACTION_HOSTILE);}else{ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);}

if((iAction==1)&&(GetCurrentHitPoints(oNew)!=iHP)){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetCurrentHitPoints(oNew)-iHP),oNew);}
else if(iAction==3){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oNew)+11),oNew);}
SetIsDestroyable(TRUE,TRUE,TRUE);DestroyObject(OBJECT_SELF);
 }
}
