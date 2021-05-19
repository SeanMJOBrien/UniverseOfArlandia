//::///////////////////////////////////////////////
//:: Associate: Heartbeat
//:: NW_CH_AC1.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move towards master or wait for him
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:: Updated On: Jul 25, 2003 - Georg Zoeller
//:://////////////////////////////////////////////
#include "X0_INC_HENAI"
#include "X2_INC_SUMMSCALE"

#include "X2_INC_SPELLHOOK"
void main()
{   //SpawnScriptDebugger();
if((GetLocalInt(OBJECT_SELF,"Wait")==0)&&(GetLocalInt(OBJECT_SELF,"Tracking")==0))
 {


    // GZ: Fallback for timing issue sometimes preventing epic summoned creatures from leveling up to their master's level.
    // There is a timing issue with the GetMaster() function not returning the fof a creature
    // immediately after spawn. Some code which might appear to make no sense has been added
    // to the nw_ch_ac1 and x2_inc_summon files to work around this
    // This code is only run at the first hearbeat
    int nLevel =SSMGetSummonFailedLevelUp(OBJECT_SELF);
    if (nLevel != 0)
    {
        int nRet;
        if (nLevel == -1) // special shadowlord treatment
        {
          SSMScaleEpicShadowLord(OBJECT_SELF);
        }
        else if  (nLevel == -2)
        {
          SSMScaleEpicFiendishServant(OBJECT_SELF);
        }
        else
        {
            nRet = SSMLevelUpCreature(OBJECT_SELF, nLevel, CLASS_TYPE_INVALID);
            if (nRet == FALSE)
            {
                WriteTimestampedLogEntry("WARNING - nw_ch_ac1:: could not level up " + GetTag(OBJECT_SELF) + "!");
            }
        }

        // regardless if the actual levelup worked, we give up here, because we do not
        // want to run through this script more than once.
        SSMSetSummonLevelUpOK(OBJECT_SELF);
    }

    // Check if concentration is required to maintain this creature
    X2DoBreakConcentrationCheck();

    object oMaster = GetMaster();
    if(!GetAssociateState(NW_ASC_IS_BUSY))
    {

        //Seek out and disable undisabled traps
        object oTrap = GetNearestTrapToObject();
        if (bkAttemptToDisarmTrap(oTrap) == TRUE) return ; // succesful trap found and disarmed

        if(GetIsObjectValid(oMaster) &&
            GetCurrentAction(OBJECT_SELF) != ACTION_FOLLOW &&
            GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP &&
            GetCurrentAction(OBJECT_SELF) != ACTION_OPENLOCK &&
            GetCurrentAction(OBJECT_SELF) != ACTION_REST &&
            GetCurrentAction(OBJECT_SELF) != ACTION_ATTACKOBJECT)
        {
            if(
               !GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN))
              )
            {
                if (GetIsObjectValid(oMaster) == TRUE)
                {
                    if(GetDistanceToObject(oMaster) > 6.0)
                    {
                        if(GetAssociateState(NW_ASC_HAVE_MASTER))
                        {
                            if(!GetIsFighting(OBJECT_SELF))
                            {
                                if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                                {
                                    if(GetDistanceToObject(GetMaster()) > GetFollowDistance())
                                    {
                                        ClearActions(CLEAR_NW_CH_AC1_49);
                                        if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                        {
                                             if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                             {
                                                //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                                //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                             }
                                             if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                             {
                                                ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                             }
                                             //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                             ActionForceFollowObject(oMaster, GetFollowDistance());
                                        }
                                        else
                                        {
                                             //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                             ActionForceFollowObject(oMaster, GetFollowDistance());
                                             //ActionForceMoveToObject(GetMaster(), TRUE, GetFollowDistance(), 5.0);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if(GetIsObjectValid(oMaster))
                    {
                        if(GetCurrentAction(oMaster) != ACTION_REST)
                        {
                            ClearActions(CLEAR_NW_CH_AC1_81);
                            if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                            {
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                 {
                                    //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                    //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                 }
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                 {
                                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                 }
                                 //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                            else
                            {
                                 //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                        }
                    }
                }
            }
            else if(!GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetAssociateState(NW_ASC_MODE_STAND_GROUND))
            {
                //DetermineCombatRound();
            }

        }
        // * if I am dominated, ask for some help
        if (GetHasEffect(EFFECT_TYPE_DOMINATED, OBJECT_SELF) == TRUE && GetIsEncounterCreature(OBJECT_SELF) == FALSE)
        {
            SendForHelp();
        }

        if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(1001));
        }
    }
 }
// Animals & Henchs
object oPC = GetMaster(OBJECT_SELF);
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sMaster = GetLocalString(OBJECT_SELF,"Master");
int iNum = GetLocalInt(OBJECT_SELF,"HenchNum");
int iRand;

     if(GetTag(OBJECT_SELF)=="henchani009"){iRand = Random(5);if(iRand>3){PlaySound("as_an_cow1");}}
else if(GetTag(OBJECT_SELF)=="henchani010"){if(GetLocalInt(oGoldbag,"Cow"+IntToString(iNum))!=GetCalendarDay()){CreateItemOnObject("cr_milk",oPC);SetLocalInt(oGoldbag,"Cow"+IntToString(iNum),GetCalendarDay());FloatingTextStringOnCreature("Your cow made one big milk pot",oPC);}}
else if(GetTag(OBJECT_SELF)=="henchani012"){if((GetLocalInt(oPC,"Listen")==0)&&(GetLocalInt(oPC,"Search")==0)&&(GetLocalInt(oPC,"Spot")==0)){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillIncrease(SKILL_LISTEN,5),oPC);ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillIncrease(SKILL_SEARCH,5),oPC);ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillIncrease(SKILL_SPOT,5),oPC);SetLocalInt(oPC,"Listen",1);SetLocalInt(oPC,"Search",1);SetLocalInt(oPC,"Spot",1);SetLocalInt(oPC,"Dog",1);}}
else if(GetTag(OBJECT_SELF)=="henchani011"){if(GetLocalInt(oPC,"Concentration")==0){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillIncrease(SKILL_CONCENTRATION,5),oPC);SetLocalInt(oPC,"Concentration",1);}}
else if(GetStringLeft(GetTag(OBJECT_SELF),8)=="henchani"){iRand = Random(15);if(iRand>13){PlaySound("c_horsexxx_dead");}else if(iRand>11){PlaySound("c_horsexxx_slct");}}
// Henchs casern
else if((GetTag(OBJECT_SELF)=="hench000")&&(GetIsObjectValid(oPC))&&(GetTag(GetArea(oPC))!="")&&(GetCurrentHitPoints(OBJECT_SELF)>0)&&(GetLocalInt(OBJECT_SELF,"HenchRecall")!=1)){SetLocalObject(oPC,"Hench",OBJECT_SELF);SetLocalInt(oPC,"HenchAction",13);ExecuteScript("henchs",oPC);ExecuteScript("wear",OBJECT_SELF);}
}
