int StartingConditional()
{
object oPC = GetPCSpeaker();
int iDomainRule = GetLocalInt(oPC,"DomainRule");

if(iDomainRule>0){return TRUE;}else{return FALSE;}
}
