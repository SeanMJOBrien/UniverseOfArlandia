int StartingConditional()
{
int iChoice5 = GetLocalInt(OBJECT_SELF,"ChoiceDone5");
int iChoice6 = GetLocalInt(OBJECT_SELF,"ChoiceDone6");
int iChoice7 = GetLocalInt(OBJECT_SELF,"ChoiceDone7");
int iChoice8 = GetLocalInt(OBJECT_SELF,"ChoiceDone8");
int iChoice21 = GetLocalInt(OBJECT_SELF,"ChoiceDone21");

if((iChoice5==0)||(iChoice6==0)||(iChoice7==0)||(iChoice8==0)||(iChoice21==0)){return TRUE;}else{return FALSE;}
}
