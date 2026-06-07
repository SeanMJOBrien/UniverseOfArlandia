#include "dmfi_db_inc"
void dmw_CleanUp(object oMySpeaker)
{
   int nCount;
   int nCache;
   DeleteLocalObject(oMySpeaker, "dmfi_univ_target");
   DeleteLocalLocation(oMySpeaker, "dmfi_univ_location");
   DeleteLocalObject(oMySpeaker, "dmw_item");
   DeleteLocalString(oMySpeaker, "dmw_repamt");
   DeleteLocalString(oMySpeaker, "dmw_repargs");
   nCache = GetLocalInt(oMySpeaker, "dmw_playercache");
   for(nCount = 1; nCount <= nCache; nCount++)
   {
      DeleteLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCount));
   }
   DeleteLocalInt(oMySpeaker, "dmw_playercache");
   nCache = GetLocalInt(oMySpeaker, "dmw_itemcache");
   for(nCount = 1; nCount <= nCache; nCount++)
   {
      DeleteLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount));
   }
   DeleteLocalInt(oMySpeaker, "dmw_itemcache");
   for(nCount = 1; nCount <= 10; nCount++)
   {
      DeleteLocalString(oMySpeaker, "dmw_dialog" + IntToString(nCount));
      DeleteLocalString(oMySpeaker, "dmw_function" + IntToString(nCount));
      DeleteLocalString(oMySpeaker, "dmw_params" + IntToString(nCount));
   }
   DeleteLocalString(oMySpeaker, "dmw_playerfunc");
   DeleteLocalInt(oMySpeaker, "dmw_started");
}


void main()
{
    object oUser = OBJECT_SELF;
    object oItem = GetLocalObject(oUser, "dmfi_item");
    object oOther = GetLocalObject(oUser, "dmfi_target");
    location lLocation = GetLocalLocation(oUser, "dmfi_location");
    string sItemTag = GetTag(oItem);

//initialize the listening commands reminder
    if (GetLocalInt(GetModule(), "dmfi_voice_initial")!=1 && (GetLocalInt(oUser, "dmfi_reminded")!=1)
        &&(GetIsDM(oUser) || GetIsDMPossessed(oUser)))
    {
        SetLocalInt(oUser, "dmfi_reminded", 1);
        SendMessageToAllDMs("Target a creature with Voice Widget to initialize system.");
        FloatingTextStringOnCreature("Target a creature with Voice Widget to initialize system", oUser);
    }

//*************************************INITIALIZATION CODE***************************************
//***************************************RUNS ONE TIME ***************************************

//voice stuff is module wide

    if (GetLocalInt(GetModule(), "dmfi_initialized") != 1)
    {
        SetLocalInt(GetModule(), "dmfi_initialized", 1);
        int iLoop = 20610;
        string sText;
        while (iLoop < 20680)
        {
            sText = GetDMFIPersistentString("dmfi", "hls" + IntToString(iLoop));
            SetCustomToken(iLoop, sText);
            iLoop++;
        }
        SendMessageToAllDMs("Voice custom tokens initialized.");
    }


//remainder of settings are user based

    if ((GetLocalInt(oUser, "dmfi_initialized")!=1) && (GetIsDM(oUser) || GetIsDMPossessed(oUser)))
    {
    //if you have campaign variables set - use those settings
        if (GetDMFIPersistentInt("dmfi", "Settings", oUser)==1)
        {
            FloatingTextStringOnCreature("Settings Restored", oUser, FALSE);
            SetLocalInt(oUser, "dmfi_initialized", 1);

            int n = GetDMFIPersistentInt("dmfi", "dmfi_alignshift", oUser);
            SetCustomToken(20781, IntToString(n));
            SetLocalInt(oUser, "dmfi_alignshift", n);
            SendMessageToPC(oUser, "Settings: Alignment shift: "+IntToString(n));


            n = GetDMFIPersistentInt("dmfi", "dmfi_safe_factions", oUser);
            SetLocalInt(oUser, "dmfi_safe_factions", n);
            SendMessageToPC(oUser, "Settings: Factions (1 is DMFI Safe Faction): "+IntToString(n));

            n = GetDMFIPersistentInt("dmfi", "dmfi_damagemodifier", oUser);
            SetLocalInt(oUser, "dmfi_damagemodifier",n);
            SendMessageToPC(oUser, "Settings: Damage Modifier: "+IntToString(n));

            n = GetDMFIPersistentInt("dmfi","dmfi_buff_party",oUser);
            SetLocalInt(oUser, "dmfi_buff_party", n);
            if (n==1)
                SetCustomToken(20783, "Party");
            else
                SetCustomToken(20783, "Single Target");

            SendMessageToPC(oUser, "Settings: Buff Party (1 is Party): "+IntToString(n));

            string sLevel = GetDMFIPersistentString("dmfi", "dmfi_buff_level", oUser);
            SetCustomToken(20782, sLevel);
            SetLocalString(oUser, "dmfi_buff_level", sLevel);
            SendMessageToPC(oUser, "Settings: Buff Level: "+ sLevel);

            n = GetDMFIPersistentInt("dmfi", "dmfi_dicebag", oUser);
            SetLocalInt(oUser, "dmfi_dicebag", n);

            string sText;
            if (n==0)
            {
                SetCustomToken(20681, "Private");
                sText = "Private";
            }
            else  if (n==1)
            {
                SetCustomToken(20681, "Global");
                sText = "Global";
            }
            else if (n==2)
            {
                SetCustomToken(20681, "Local");
                sText = "Local";
            }
            else if (n==3)
            {
                SetCustomToken(20681, "DM Only");
                sText = "DM Only";
            }
            SendMessageToPC(oUser, "Settings: Dicebag Reporting: "+sText);

            n = GetDMFIPersistentInt("dmfi", "dmfi_dice_no_animate", oUser);
            SetLocalInt(oUser, "dmfi_dice_no_animate", n);
            SendMessageToPC(oUser, "Settings: Roll Animations (1 is OFF): "+IntToString(n));

            float f = GetDMFIPersistentFloat("dmfi", "dmfi_reputation", oUser);
            SetLocalFloat(oUser, "dmfi_reputation", f);
            SendMessageToPC(oUser, "Settings: Reputation Adjustment: "+FloatToString(f));

            f = GetDMFIPersistentFloat("dmfi", "dmfi_effectduration", oUser);
            SetLocalFloat(oUser, "dmfi_effectduration", f);
            SendMessageToPC(oUser, "Settings: Effect Duration: "+FloatToString(f));

            f = GetDMFIPersistentFloat("dmfi", "dmfi_sound_delay", oUser);
            SetLocalFloat(oUser, "dmfi_sound_delay", f);
            SendMessageToPC(oUser, "Settings: Sound Delay: "+FloatToString(f));

            f = GetDMFIPersistentFloat("dmfi", "dmfi_beamduration", oUser);
            SetLocalFloat(oUser, "dmfi_beamduration", f);
            SendMessageToPC(oUser, "Settings: Beam Duration: "+FloatToString(f));

            f = GetDMFIPersistentFloat("dmfi", "dmfi_stunduration", oUser);
            SetLocalFloat(oUser, "dmfi_stunduration", f);
            SendMessageToPC(oUser, "Settings: Stun Duration: "+FloatToString(f));

            f = GetDMFIPersistentFloat("dmfi", "dmfi_saveamount", oUser);
            SetLocalFloat(oUser, "dmfi_saveamount", f);
            SendMessageToPC(oUser, "Settings: Save Adjustment: "+FloatToString(f));

            f = GetDMFIPersistentFloat("dmfi", "dmfi_effectdelay", oUser);
            SetLocalFloat(oUser, "dmfi_effectdelay", f);
            SendMessageToPC(oUser, "Settings: Effect Delay: "+FloatToString(f));


        }
        else
        {
            FloatingTextStringOnCreature("Default Settings Initialized", oUser, FALSE);
            //Setting FOUR campaign variables so 1st use will be slow.
            //Recommend initializing your preferences with no players or
            //while there is NO fighting.
            SetLocalInt(oUser, "dmfi_initialized", 1);
            SetDMFIPersistentInt("dmfi", "Settings", 1, oUser);

            SetCustomToken(20781, "5");
            SetLocalInt(oUser, "dmfi_alignshift", 5);
            SetDMFIPersistentInt("dmfi", "dmfi_alignshift", 5, oUser);
            SendMessageToPC(oUser, "Settings: Alignment shift: 5");

            SetCustomToken(20783, "Single Target");
            SetLocalInt(oUser, "dmfi_buff_party", 0);
            SetDMFIPersistentInt("dmfi", "dmfi_buff_party", 0, oUser);
            SendMessageToPC(oUser, "Settings: Buff set to Single Target: ");

            SetCustomToken(20782, "Low");
            SetLocalString(oUser, "dmfi_buff_level", "LOW");
            SetDMFIPersistentString("dmfi", "dmfi_buff_level", "LOW", oUser);
            SendMessageToPC(oUser, "Settings: Buff Level set to LOW: ");

            SetLocalInt(oUser, "dmfi_dicebag", 0);
            SetCustomToken(20681, "Private");
            SetDMFIPersistentInt("dmfi", "dmfi_dicebag", 0, oUser);
            SendMessageToPC(oUser, "Settings: Dicebag Rolls set to PRIVATE");

            SetLocalInt(oUser, "", 0);
            SetDMFIPersistentInt("dmfi", "dmfi_safe_factions", 0, oUser);
            SendMessageToPC(oUser, "Settings: Factions set to BW base behavior");

            SetLocalFloat(oUser, "dmfi_reputation", 5.0);
            SetCustomToken(20784, "5");
            SetDMFIPersistentFloat("dmfi", "dmfi_reputation", 5.0, oUser);
            SendMessageToPC(oUser, "Settings: Reputation adjustment: 5");

            SetDMFIPersistentFloat("dmfi", "dmfi_effectduration", 60.0, oUser);
            SetLocalFloat(oUser, "dmfi_effectduration", 60.0);
            SetDMFIPersistentFloat("dmfi", "dmfi_sound_delay", 0.2, oUser);
            SetLocalFloat(oUser, "dmfi_sound_delay", 0.2);
            SetDMFIPersistentFloat("dmfi", "dmfi_beamduration", 5.0, oUser);
            SetLocalFloat(oUser, "dmfi_beamduration", 5.0);
            SetDMFIPersistentFloat("dmfi", "dmfi_stunduration", 1000.0,  oUser);
            SetLocalFloat(oUser, "dmfi_stunduration", 1000.0);
            SetDMFIPersistentFloat("dmfi", "dmfi_saveamount", 5.0, oUser);
            SetLocalFloat(oUser, "dmfi_saveamount", 5.0);
            SetDMFIPersistentFloat("dmfi", "dmfi_effectdelay", 1.0, oUser);
            SetLocalFloat(oUser, "dmfi_effectdelay", 1.0);

            SendMessageToPC(oUser, "Settings: Effect Duration: 60.0");
            SendMessageToPC(oUser, "Settings: Effect Delay: 1.0");
            SendMessageToPC(oUser, "Settings: Beam Duration: 5.0");
            SendMessageToPC(oUser, "Settings: Stun Duration: 1000.0");
            SendMessageToPC(oUser, "Settings: Sound Delay: 0.2");
            SendMessageToPC(oUser, "Settings: Save Adjustment: 5.0");
        }
    }
//********************************END INITIALIZATION***************************



    dmw_CleanUp(oUser);

    if (GetStringLeft(sItemTag,8) == "hlslang_")
    {
        //Jump any existing Voice attached to the user
        if (GetIsObjectValid(GetLocalObject(oUser, "dmfi_MyVoice")))
        {
            AssignCommand(GetLocalObject(oUser, "dmfi_MyVoice"), ClearAllActions());
            AssignCommand(GetLocalObject(oUser, "dmfi_MyVoice"), ActionJumpToObject(oUser));
            FloatingTextStringOnCreature("Your current Voice has been jumped to you.", oUser, FALSE);
        }
        else //If none exists, create a new voice set to autofollow the user
        {
            //Create the Voice
            object oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", GetLocation(oUser));
            //Set the Voice to Autofollow the User
            AssignCommand(oVoice, ActionForceFollowObject(oUser, 3.0f));
            //Set Ownership of the Voice to the User
            SetLocalObject(oUser, "dmfi_MyVoice", oVoice);
            FloatingTextStringOnCreature("A new Voice has been created.", oUser, FALSE);
        }

        //Set the Voice to interpret language of the appropriate widget
        string ssLanguage = GetStringRight(sItemTag, GetStringLength(sItemTag) - 8);
        SetLocalInt(oUser, "hls_MyLanguage", StringToInt(ssLanguage));
        SetLocalString(oUser, "hls_MyLanguageName", GetName(oItem));
        DelayCommand(1.0f, FloatingTextStringOnCreature("You are speaking " + GetName(oItem) + ". Type /dm [(what you want to say in brackets)]", oUser, FALSE));
        return;
    }

    if (GetStringLeft(sItemTag, 8) == "dmfi_pc_")
    {
        if (GetStringLeft(sItemTag, 12) == "dmfi_pc_rest")
        {
            CreateObject(OBJECT_TYPE_PLACEABLE, "dmfi_rest" + GetStringRight(sItemTag, 3), GetLocation(oUser));
            return;
        }
        if (sItemTag == "dmfi_pc_follow")
        {
            if (GetIsObjectValid(oOther))
            {
                FloatingTextStringOnCreature("Now following "+ GetName(oOther),oUser, FALSE);
                DelayCommand(2.0f, AssignCommand(oUser, ActionForceFollowObject(oOther, 2.0f)));
            }
            return;
        }
        SetLocalObject(oUser, "dmfi_univ_target", oUser);
        SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
        SetLocalString(oUser, "dmfi_univ_conv", GetStringRight(sItemTag, GetStringLength(sItemTag) - 5));
        AssignCommand(oUser, ClearAllActions());
        AssignCommand(oUser, ActionStartConversation(OBJECT_SELF, "dmfi_universal", TRUE));
        return;
    }

    if (GetStringLeft(sItemTag, 5) == "dmfi_")
    {
        int iPass = FALSE;

        if (GetIsDM(oUser) || GetIsDMPossessed(oUser))
            iPass = TRUE;

        if (!GetIsPC(oUser))
            iPass = TRUE;

        if (!iPass)
        {
            FloatingTextStringOnCreature("You cannot use this item." ,oUser, FALSE);
            SendMessageToAllDMs(GetName(oUser)+ " is attempting to use a DM item.");
            return;
        }

        if (sItemTag == "dmfi_exploder")
        {
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_afflict"))) CreateItemOnObject("dmfi_afflict", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_dicebag"))) CreateItemOnObject("dmfi_dicebag", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_pc_dicebag"))) CreateItemOnObject("dmfi_pc_dicebag", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_pc_follow"))) CreateItemOnObject("dmfi_pc_follow", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_pc_emote"))) CreateItemOnObject("dmfi_pc_emote", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_server"))) CreateItemOnObject("dmfi_server", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_emote"))) CreateItemOnObject("dmfi_emote", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_encounter"))) CreateItemOnObject("dmfi_encounte", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_faction"))) CreateItemOnObject("dmfi_faction", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_fx"))) CreateItemOnObject("dmfi_fx", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_music"))) CreateItemOnObject("dmfi_music", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_sound"))) CreateItemOnObject("dmfi_sound", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_voice"))) CreateItemOnObject("dmfi_voice", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_xp"))) CreateItemOnObject("dmfi_xp", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_500xp"))) CreateItemOnObject("dmfi_500xp", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_en_ditto"))) CreateItemOnObject("dmfi_en_ditto", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_mute"))) CreateItemOnObject("dmfi_mute", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_peace"))) CreateItemOnObject("dmfi_peace", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_voicewidget"))) CreateItemOnObject("dmfi_voicewidget", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_remove"))) CreateItemOnObject("dmfi_remove", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_dmw"))) CreateItemOnObject("dmfi_dmw", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_target"))) CreateItemOnObject("dmfi_target", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_buff"))) CreateItemOnObject("dmfi_buff", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_dmbook"))) CreateItemOnObject("dmfi_dmbook", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_playerbook"))) CreateItemOnObject("dmfi_playerbook", oOther);
            if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_jail_widget"))) CreateItemOnObject("dmfi_jail_widget", oOther);
            return;
        }
        if (sItemTag == "dmfi_peace")
        {   //This widget sets all creatures in the area to a neutral stance and clears combat.
            object oArea = GetFirstObjectInArea(GetArea(oUser));
            object oP;
            while (GetIsObjectValid(oArea))
            {
                if (GetObjectType(oArea) == OBJECT_TYPE_CREATURE && !GetIsPC(oArea))
                {
                    AssignCommand(oArea, ClearAllActions());
                    oP = GetFirstPC();
                    while (GetIsObjectValid(oP))
                    {
                        if (GetArea(oP) == GetArea(oUser))
                        {
                            ClearPersonalReputation(oArea, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 25, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 91, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 91, oP);
                            SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 91, oP);
                        }
                        oP = GetNextPC();
                    }
                    AssignCommand(oArea, ClearAllActions());
                }
                oArea = GetNextObjectInArea(GetArea(oUser));
            }
        }
        if (sItemTag == "dmfi_voicewidget")
        {
            object oVoice;
            //Jump any existing Voice attached to the user
            if (GetIsObjectValid(GetLocalObject(oUser, "dmfi_MyVoice")))
            {
                AssignCommand(GetLocalObject(oUser, "dmfi_MyVoice"), ClearAllActions());
                AssignCommand(GetLocalObject(oUser, "dmfi_MyVoice"), ActionJumpToObject(oUser));
                FloatingTextStringOnCreature("Your current Voice has been jumped to you.", oUser, FALSE);
            }
            else //If none exists, create a new voice set to autofollow the user
            {
                //Create the Voice
                object oVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", GetLocation(oUser));
                //Set the Voice to Autofollow the User
                AssignCommand(oVoice, ActionForceFollowObject(oUser, 3.0f));
                //Set Ownership of the Voice to the User
                SetLocalObject(oUser, "dmfi_MyVoice", oVoice);
                FloatingTextStringOnCreature("A new Voice has been created.", oUser, FALSE);
            }
            if (GetIsObjectValid(oOther))
            {
                SetListening(oOther, TRUE);
                SetListenPattern(oOther, "**", LISTEN_PATTERN);
                SetLocalInt(oOther, "hls_Listening", 1); //listen to all text
                SetLocalObject(oUser, "dmfi_VoiceTarget", oOther);

                FloatingTextStringOnCreature("You have targeted " + GetName(oOther) + " with the Voice Widget", oUser, FALSE);
                //if(!GetIsObjectValid(GetItemPossessedBy(oOther, "dmfi_voicewidget"))) CreateItemOnObject("dmfi_voicewidget", oOther);

                if (GetLocalInt(GetModule(), "dmfi_voice_initial")!=1)
                {
                    SetLocalInt(GetModule(), "dmfi_voice_initial", 1);
                    SendMessageToAllDMs("Listening Initialized:  .commands, .skill checks, and much more now available.");
                    DelayCommand(4.0, FloatingTextStringOnCreature("Listening Initialized:  .commands, .skill checks, and more available", oUser));
                }
                return;
            }
            else
            {
                //Jump any existing Voice attached to the user
                if (GetIsObjectValid(GetLocalObject(oUser, "dmfi_StaticVoice")))
                {
                    DestroyObject(GetLocalObject(oUser, "dmfi_StaticVoice"));
                }
                //Create the StationaryVoice
                object oStaticVoice = CreateObject(OBJECT_TYPE_CREATURE, "dmfi_voice", GetLocation(oUser));
                //Set Ownership of the Voice to the User
                SetLocalObject(oUser, "dmfi_StaticVoice", oVoice);
                SetLocalObject(oUser, "dmfi_VoiceTarget", oStaticVoice);
                DelayCommand(1.0f, FloatingTextStringOnCreature("A Stationary Voice has been created.", oUser, FALSE));
                return;
            }
            return;
        }
        if (sItemTag == "dmfi_mute")
        {
            SetLocalObject(oUser, "dmfi_univ_target", oUser);
            SetLocalString(oUser, "dmfi_univ_conv", "voice");
            SetLocalInt(oUser, "dmfi_univ_int", 8);
            ExecuteScript("dmfi_execute", oUser);
            return;
        }
        //encounter ditto widget
        if (sItemTag == "dmfi_en_ditto")
        {
            SetLocalObject(oUser, "dmfi_univ_target", oOther);
            SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
            SetLocalString(oUser, "dmfi_univ_conv", "encounter");
            SetLocalInt(oUser, "dmfi_univ_int", GetLocalInt(oUser, "EncounterType"));
            ExecuteScript("dmfi_execute", oUser);
            return;
        }
        //Change target widget
        if (sItemTag == "dmfi_target")
        {
            SetLocalObject(oUser, "dmfi_univ_target", oOther);
            FloatingTextStringOnCreature("DMFI Target set to " + GetName(oOther),oUser);
        }
        //Destroy object widget
        if (sItemTag == "dmfi_remove")
        {
            object oKillMe;
            //Targeting Self
            if (oUser == oOther)
            {
                oKillMe = GetNearestObject(OBJECT_TYPE_PLACEABLE, oUser);
                FloatingTextStringOnCreature("Destroyed " + GetName(oKillMe) + "(" + GetTag(oKillMe) + ")", oUser, FALSE);
                DelayCommand(0.1f, DestroyObject(oKillMe));
            }
            else if (GetIsObjectValid(oOther)) //Targeting something else
            {
                FloatingTextStringOnCreature("Destroyed " + GetName(oOther) + "(" + GetTag(oOther) + ")", oUser, FALSE);
                DelayCommand(0.1f, DestroyObject(oOther));
            }
            else //Targeting the ground
            {
                int iReport = 0;
                oKillMe = GetFirstObjectInShape(SHAPE_SPHERE, 2.0f, lLocation, FALSE, OBJECT_TYPE_ALL);
                while (GetIsObjectValid(oKillMe))
                {
                    iReport++;
                    DestroyObject(oKillMe);
                    oKillMe = GetNextObjectInShape(SHAPE_SPHERE, 2.0f, lLocation, FALSE, OBJECT_TYPE_ALL);
                }
                FloatingTextStringOnCreature("Destroyed " + IntToString(iReport) + " objects.", oUser, FALSE);
            }
            return;
        }
        if (sItemTag == "dmfi_500xp")
        {
            SetLocalObject(oUser, "dmfi_univ_target", oOther);
            SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
            SetLocalString(oUser, "dmfi_univ_conv", "xp");
            SetLocalInt(oUser, "dmfi_univ_int", 53);
            ExecuteScript("dmfi_execute", oUser);
            return;
        }
        if (sItemTag == "dmfi_jail_widget")
        {
            if (GetIsObjectValid(oOther) && !GetIsDM(oOther) && oOther != oUser)
            {
                object oJail = GetObjectByTag("dmfi_jail");
                if (!GetIsObjectValid(oJail))
                    oJail = GetObjectByTag("dmfi_jail_default");
                AssignCommand(oOther, ClearAllActions());
                AssignCommand(oOther, JumpToObject(oJail));
                SendMessageToPC(oUser, GetName(oOther) + " (" + GetPCPublicCDKey(oOther) + ")/IP: " + GetPCIPAddress(oOther) + " - has been sent to Jail.");
            }
            return;
        }

        if (sItemTag == "dmfi_encounter")
        {

            if (GetIsObjectValid(GetWaypointByTag("DMFI_E1")))
                SetCustomToken(20771, GetName(GetWaypointByTag("DMFI_E1")));
            else
                SetCustomToken(20771, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E2")))
                SetCustomToken(20772, GetName(GetWaypointByTag("DMFI_E2")));
            else
                SetCustomToken(20772, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E3")))
                SetCustomToken(20773, GetName(GetWaypointByTag("DMFI_E3")));
            else
                SetCustomToken(20773, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E4")))
                SetCustomToken(20774, GetName(GetWaypointByTag("DMFI_E4")));
            else
                SetCustomToken(20774, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E5")))
                SetCustomToken(20775, GetName(GetWaypointByTag("DMFI_E5")));
            else
                SetCustomToken(20775, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E6")))
                SetCustomToken(20776, GetName(GetWaypointByTag("DMFI_E6")));
            else
                SetCustomToken(20776, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E7")))
                SetCustomToken(20777, GetName(GetWaypointByTag("DMFI_E7")));
            else
                SetCustomToken(20777, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E8")))
                SetCustomToken(20778, GetName(GetWaypointByTag("DMFI_E8")));
            else
                SetCustomToken(20778, "Encounter Invalid");
            if (GetIsObjectValid(GetWaypointByTag("DMFI_E9")))
                SetCustomToken(20779, GetName(GetWaypointByTag("DMFI_E9")));
            else
                SetCustomToken(20779, "Encounter Invalid");
        }
        if (sItemTag == "dmfi_afflict")
        {
            int nDNum;

            nDNum = GetLocalInt(oUser, "dmfi_damagemodifier");
            SetCustomToken(20780, IntToString(nDNum));
        }


        SetLocalObject(oUser, "dmfi_univ_target", oOther);
        SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
        SetLocalString(oUser, "dmfi_univ_conv", GetStringRight(sItemTag, GetStringLength(sItemTag) - 5));
        AssignCommand(oUser, ClearAllActions());
        AssignCommand(oUser, ActionStartConversation(OBJECT_SELF, "dmfi_universal", TRUE, FALSE));
    }
}
