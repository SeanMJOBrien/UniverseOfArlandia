#include "_guild"
#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sGuild = GetLocalString(oGoldbag,"Guild");
int iGuild = (GuildTicksLeft(oGoldbag)/576)+1;
string s;

if(sGuild!=""){s = "Member of "+sGuild+"'s guild ("+IntToString(iGuild)+" days remaining).\n";}

SetCustomToken(10603,s);
}
