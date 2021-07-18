////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iStep = GetLocalInt(OBJECT_SELF,"Step");
//
object oBox;string sPlanetDest;string sAreaDest;string sName;int i;
////////////////////////////////////////////////////////////////////////////////
// List domains holders
if(iChoice1==0)
  {
while(i<10)
 {
i++;
sPlanetDest = GetLocalString(OBJECT_SELF,"MailPlanet"+IntToString((iStep*10)+i));
sAreaDest = GetLocalString(OBJECT_SELF,"MailArea"+IntToString((iStep*10)+i));
sName = GetLocalString(OBJECT_SELF,"MailName"+IntToString((iStep*10)+i));

if(sName!=""){DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));}else{SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
SetCustomToken(10650+i,sName+" ("+sPlanetDest+" - "+sAreaDest+")");
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Open mail store
else
 {
iStep = iStep-1;
sPlanetDest = GetLocalString(OBJECT_SELF,"MailPlanet"+IntToString((iStep*10)+iChoice1));
sAreaDest = GetLocalString(OBJECT_SELF,"MailArea"+IntToString((iStep*10)+iChoice1));
sName = GetLocalString(OBJECT_SELF,"MailName"+IntToString((iStep*10)+iChoice1));

oBox = CreateObject(OBJECT_TYPE_PLACEABLE,"mailbox_inv",GetLocation(oPC));

SetLocalString(oBox,"MailPlanet",sPlanetDest);
SetLocalString(oBox,"MailArea",sAreaDest);

AssignCommand(oPC,DoPlaceableObjectAction(oBox,PLACEABLE_ACTION_USE));
 }
////////////////////////////////////////////////////////////////////////////////
}
