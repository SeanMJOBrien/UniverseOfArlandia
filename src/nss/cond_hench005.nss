int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iHench = GetLocalInt(OBJECT_SELF,"HenchNum");
string sStay = GetLocalString(oGoldbag,IntToString(iHench)+"StayHench");
string sFamiliar4 = GetLocalString(oGoldbag,"Familiar4");
object oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);

int iGrade = GetLocalInt(oGoldbag,"Grade");if(iGrade==1){iGrade = 2;}else if(iGrade==2){iGrade = 4;}else if(iGrade==3){iGrade = 7;}else if(iGrade==4){iGrade = 12;}else if(iGrade==5){iGrade = 20;}
int i=1;int j;object oHenchs = GetHenchman(oPC,i);while(GetIsObjectValid(oHenchs)){if((GetResRef(oHenchs)!=sFamiliar4)&&(oHenchs!=oFamiliar4)&&(GetLocalInt(oHenchs,"Mission")==0)){j++;}i++;oHenchs = GetHenchman(oPC,i);}j = j-GetLocalInt(oGoldbag,"Clones");if(GetLocalInt(oPC,"Mounted")==1){j++;}

if(((sStay!="")||((GetResRef(OBJECT_SELF)=="hench000")&&(!GetIsObjectValid(GetMaster()))))&&(j<iGrade)&&(GetResRef(OBJECT_SELF)!=sFamiliar4)){return TRUE;}else{return FALSE;}
}
