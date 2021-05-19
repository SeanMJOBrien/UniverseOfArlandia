//DMFI Persistence wrapper functions
//This include file contains the wrapper functions for the
//persistent settings of the DMFI Wand and Widget package
//Advanced users can adapt this to the database system that
//they want to use for NWN.
//
//These functions use the Bioware database by default and use a primitive form
//of "caching" to avoid lots of database R/W

//Listen Pattern ** variable
//Change this to 0 to make the DMFI W&W more compatible with Jasperre's AI
const int LISTEN_PATTERN = 20600;

//Int functions
int GetDMFIPersistentInt(string sDBName, string sDBSetting, object oPlayer = OBJECT_INVALID)
{
    int iReturn = GetCampaignInt(sDBName, sDBSetting, oPlayer);
    return iReturn;
}

void SetDMFIPersistentInt(string sDBName, string sDBSetting, int iDBValue, object oPlayer = OBJECT_INVALID)
{
    SetCampaignInt(sDBName, sDBSetting, iDBValue, oPlayer);
}

//Float functions
float GetDMFIPersistentFloat(string sDBName, string sDBSetting, object oPlayer = OBJECT_INVALID)
{
    float fReturn = GetCampaignFloat(sDBName, sDBSetting, oPlayer);
    return fReturn;
}

void SetDMFIPersistentFloat(string sDBName, string sDBSetting, float fDBValue, object oPlayer = OBJECT_INVALID)
{
    SetCampaignFloat(sDBName, sDBSetting, fDBValue, oPlayer);
}

//String functions
string GetDMFIPersistentString(string sDBName, string sDBSetting, object oPlayer = OBJECT_INVALID)
{
    string sReturn = GetCampaignString(sDBName, sDBSetting, oPlayer);
    return sReturn;
}

void SetDMFIPersistentString(string sDBName, string sDBSetting, string sDBValue, object oPlayer = OBJECT_INVALID)
{
    SetCampaignString(sDBName, sDBSetting, sDBValue, oPlayer);
}
