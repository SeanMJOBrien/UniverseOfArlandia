#include "_module"
void main()
{
object oArea = GetArea(OBJECT_SELF);
object oCreature = GetFirstObjectInArea(oArea);
int iConfig = GetLocalInt(OBJECT_SELF,"Config");
int i;

if(iConfig==0)
 {
while(GetIsObjectValid(oCreature))
  {
if((GetCurrentHitPoints(oCreature)>0)&&(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oCreature)>=90)){i++;}
oCreature = GetNextObjectInArea(oArea);
  }
if(i>=iChestFull)
  {
SpeakString("Still empty");
  }
 }
}
