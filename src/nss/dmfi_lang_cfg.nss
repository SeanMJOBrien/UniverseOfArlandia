// dmfi_lang_cfg - settings of the language system.
// ---
// Every setting has an explicit value here. A module variable of the same name
// (toolset: Module Properties, Variables, or SetLocalInt on GetModule())
// overrides the value without a rebuild:
//   on/off settings   1 = on, 2 = off, 0 or unset = the value in this file
//   number settings   a value above 0, 0 or unset = the value in this file
// Changing a value in this file needs a rebuild of the scripts.

// --- Advancement by listening
// Master switch. Off: nothing is earned by listening, from anyone, and trainer
// NPCs and act_lang_exp give nothing either. Books, tutoring and .teach still work.
const int LANGCFG_EXP_ENABLED = FALSE;
const string LANGCFG_VAR_EXP_ENABLED = "lang_exp_on";

// With the switch on: points are earned only from other player characters (and
// DMs), not from ordinary NPCs, so a character cannot level a language by talking
// to NPCs. Exceptions: an NPC with the local int lang_trainer = 1 (it gives points
// in its own language like a player would), and the dialog action act_lang_exp.
const int LANGCFG_EXP_PC_ONLY = FALSE;
const string LANGCFG_VAR_EXP_PC_ONLY = "lang_exp_pc_only";

// Points to leave level n: n * n * this.
const int LANGCFG_EXP_UNIT = 20;
const string LANGCFG_VAR_EXP_UNIT = "lang_exp_unit";

// Seconds between points for one listener and language.
const int LANGCFG_EXP_COOLDOWN = 30;
const string LANGCFG_VAR_EXP_COOLDOWN = "lang_exp_cooldown";

// --- Language slots
// TRUE: the Intelligence limit on starting new languages is removed for every
// source (books, tutors). FALSE: one new language per point of Intelligence modifier.
const int LANGCFG_SLOTS_IGNORE = FALSE;
const string LANGCFG_VAR_SLOTS_IGNORE = "lang_slots_ignore";

// --- Tutoring by player characters (.tutor)
// A character fluent in a language can offer one lesson to a nearby character.
// The learner accepts or declines. An accepted lesson raises the learner by one
// level (starting a new language needs a free slot unless slots are ignored) and
// cannot raise the learner above the teacher's own level.
const int LANGCFG_TUTOR_ENABLED = FALSE;
const string LANGCFG_VAR_TUTOR_ENABLED = "lang_tutor_on";

// Seconds before the same learner can take another lesson in the same language.
const int LANGCFG_TUTOR_COOLDOWN = 3600;
const string LANGCFG_VAR_TUTOR_COOLDOWN = "lang_tutor_cooldown";

// Metres between teacher and learner.
const int LANGCFG_TUTOR_RANGE = 5;
const string LANGCFG_VAR_TUTOR_RANGE = "lang_tutor_range";

// --- NWNX Chat (speech bubbles per listener)
// With the NWNX Chat plugin loaded, each listener gets their own chat line and
// speech bubble with what they understand. Without the plugin, or with this
// off, the NWScript behavior is used: a scrambled bubble plus a translation
// message. The plugin is detected at module load; this only turns its use off.
const int LANGCFG_NWNX_ENABLED = TRUE;
const string LANGCFG_VAR_NWNX_ENABLED = "lang_nwnx_on";

// With the plugin in use the translations already arrive as the bubble and chat
// line. TRUE also feeds them to the .lang window log; FALSE hides the log and
// its check box, since it would repeat the chat.
const int LANGCFG_NWNX_WINDOW_LOG = FALSE;
const string LANGCFG_VAR_NWNX_WINDOW_LOG = "lang_nwnx_log";

// --- Readers

int LangCfgFlag(string sVar, int bFile)
{
    int iValue = GetLocalInt(GetModule(), sVar);
    if (iValue == 1) return TRUE;
    if (iValue == 2) return FALSE;
    return bFile;
}

int LangCfgInt(string sVar, int iFile)
{
    int iValue = GetLocalInt(GetModule(), sVar);
    if (iValue > 0) return iValue;
    return iFile;
}

int LangCfgExpEnabled()    { return LangCfgFlag(LANGCFG_VAR_EXP_ENABLED, LANGCFG_EXP_ENABLED); }
int LangCfgExpPcOnly()     { return LangCfgFlag(LANGCFG_VAR_EXP_PC_ONLY, LANGCFG_EXP_PC_ONLY); }
int LangCfgExpUnit()       { return LangCfgInt(LANGCFG_VAR_EXP_UNIT, LANGCFG_EXP_UNIT); }
int LangCfgExpCooldown()   { return LangCfgInt(LANGCFG_VAR_EXP_COOLDOWN, LANGCFG_EXP_COOLDOWN); }
int LangCfgSlotsIgnore()   { return LangCfgFlag(LANGCFG_VAR_SLOTS_IGNORE, LANGCFG_SLOTS_IGNORE); }
int LangCfgTutorEnabled()  { return LangCfgFlag(LANGCFG_VAR_TUTOR_ENABLED, LANGCFG_TUTOR_ENABLED); }
int LangCfgTutorCooldown() { return LangCfgInt(LANGCFG_VAR_TUTOR_COOLDOWN, LANGCFG_TUTOR_COOLDOWN); }
int LangCfgTutorRange()    { return LangCfgInt(LANGCFG_VAR_TUTOR_RANGE, LANGCFG_TUTOR_RANGE); }
int LangCfgNwnxEnabled()    { return LangCfgFlag(LANGCFG_VAR_NWNX_ENABLED, LANGCFG_NWNX_ENABLED); }
int LangCfgNwnxWindowLog() { return LangCfgFlag(LANGCFG_VAR_NWNX_WINDOW_LOG, LANGCFG_NWNX_WINDOW_LOG); }
