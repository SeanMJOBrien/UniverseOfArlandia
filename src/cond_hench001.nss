#include "_module"
int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iHench = GetLocalInt(OBJECT_SELF,"Hench");
string sTag = GetLocalString(OBJECT_SELF,"Tag");
int iWait = GetLocalInt(OBJECT_SELF,"Wait");
int iClone = GetLocalInt(OBJECT_SELF,"Clone");
int iSummon = GetLocalInt(OBJECT_SELF,"Summon");
string sFamiliar4 = GetLocalString(oGoldbag,"Familiar4");
string sBP = GetResRef(OBJECT_SELF);

int iGrade = GetLocalInt(oGoldbag,"Grade");if(iGrade==1){iGrade = 2;}else if(iGrade==2){iGrade = 4;}else if(iGrade==3){iGrade = 7;}else if(iGrade==4){iGrade = 12;}else if(iGrade==5){iGrade = 20;}
int i=1;int j;object oHenchs = GetHenchman(oPC,i);while(GetIsObjectValid(oHenchs)){if(GetResRef(oHenchs)!=sFamiliar4){j++;}i++;oHenchs = GetHenchman(oPC,i);}j = j-GetLocalInt(oGoldbag,"Clones");
int k=1;int iHenchs;string sHench;while(k<iMaxHenchs){k++;sHench = GetLocalString(oGoldbag,IntToString(k)+"Hench");if(sHench!=""){iHenchs++;}}

if((iWait==0)&&(iHench>0)&&(iHenchs<iMaxHenchs)&&(sTag!="mission")&&(iClone==0)&&(iSummon==0)&&((j<iGrade)||(GetIsDM(oPC)))){return TRUE;}else{return FALSE;}
}
