int StartingConditional()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oCreatures = GetFirstObjectInArea(oArea);
int i;

while(GetIsObjectValid(oCreatures))
 {
if((GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oCreatures)>=90)&&(GetCurrentHitPoints(oCreatures)>0)){i++;}
oCreatures = GetNextObjectInArea(oArea);
 }

if(i>3){return TRUE;}else{return FALSE;}
}
