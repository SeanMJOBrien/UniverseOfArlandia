void main()
{
object oPC = GetPCSpeaker();
int i;

while(i<20)
 {
i++;
DeleteLocalInt(OBJECT_SELF,"Choice"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"Var"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"Rand"+IntToString(i));
SetCustomToken(10000+i,"");
SetCustomToken(10020+i,"");
SetCustomToken(10040+i,"");
SetCustomToken(10060+i,"");
SetCustomToken(10080+i,"");
SetCustomToken(10100+i,"");
SetCustomToken(10120+i,"");
SetCustomToken(10140+i,"");
SetCustomToken(10160+i,"");
SetCustomToken(10180+i,"");
SetCustomToken(10200+i,"");
 }
SetCustomToken(10000,"");

if((GetLocalInt(OBJECT_SELF,"Player")==4)&&(GetLocalInt(OBJECT_SELF,"Wins")<0)){TakeGoldFromCreature(-GetLocalInt(OBJECT_SELF,"Wins"),oPC,TRUE);}
if(GetLocalInt(OBJECT_SELF,"GP")>0){TakeGoldFromCreature(GetLocalInt(OBJECT_SELF,"GP"),oPC,TRUE);}

DeleteLocalInt(OBJECT_SELF,"Page");
DeleteLocalInt(OBJECT_SELF,"Step");
DeleteLocalInt(OBJECT_SELF,"Recall");
DeleteLocalInt(OBJECT_SELF,"Upgrade");
DeleteLocalInt(OBJECT_SELF,"Win");
DeleteLocalInt(OBJECT_SELF,"Wins");
DeleteLocalInt(OBJECT_SELF,"Losts");
DeleteLocalString(OBJECT_SELF,"Result");
DeleteLocalInt(OBJECT_SELF,"GP");
DeleteLocalInt(OBJECT_SELF,"Diff");
DeleteLocalInt(oPC,"Success");

object oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetStringLeft(GetTag(oItems),4)=="card"){DestroyObject(oItems);}oItems = GetNextItemInInventory(oPC);}

if(GetPlotFlag(OBJECT_SELF)==FALSE){SetPlotFlag(OBJECT_SELF,TRUE);}
}
