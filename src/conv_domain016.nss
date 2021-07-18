////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
//
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
int iChoice4 = GetLocalInt(OBJECT_SELF,"Choice4");
int iStep2 = GetLocalInt(OBJECT_SELF,"Step2");
int iResultPerPage = 20;
//
string sVar;string sTag;string sName;int i;
////////////////////////////////////////////////////////////////////////////////
// List resources
if(iChoice4==0)
 {
i=0;while(i<iResultPerPage){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);SetCustomToken(10170+i,"");SetCustomToken(10180+i,"");}
i=0;
while(i<iResultPerPage)
  {
i++;
sVar = GetLocalString(oModule,"CR_"+IntToString(i+(iStep2*iResultPerPage)));
sTag = GetStringLeft(sVar,FindSubString(sVar,"&1&"));
sName = GetStringRight(sVar,GetStringLength(sVar)-FindSubString(sVar,"&1&")-3);

SetCustomToken(10310+i,sName);
if(sName!="")
   {
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
SetLocalString(OBJECT_SELF,"ItemBP"+IntToString(i),sTag);
SetLocalString(OBJECT_SELF,"ItemName"+IntToString(i),sName);
SetLocalString(OBJECT_SELF,"ItemTag1"+IntToString(i),sTag);
SetLocalString(OBJECT_SELF,"ItemTag2"+IntToString(i),sTag);
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Set resource type
else
 {
sTag = GetLocalString(OBJECT_SELF,"ItemBP"+IntToString(iChoice3));
sName = GetLocalString(OBJECT_SELF,"ItemName"+IntToString(iChoice3));

if(iChoice4>2){SetLocalString(OBJECT_SELF,"ItemTag1"+IntToString(iChoice3),IntToString(iChoice4-1)+sTag);SetLocalString(OBJECT_SELF,"ItemTag2"+IntToString(iChoice3),IntToString(iChoice4-1)+sTag);}

     if(iChoice4==2){sName = "Improved "+sName;}
else if(iChoice4==3){sName = "Quality "+sName;}
else if(iChoice4==4){sName = "Precious "+sName;}
sTag = IntToString(iChoice4)+sTag;

SetLocalString(OBJECT_SELF,"ItemBP"+IntToString(iChoice3),sTag);
SetLocalString(OBJECT_SELF,"ItemName"+IntToString(iChoice3),sName);

SetLocalInt(OBJECT_SELF,"Step",GetLocalInt(OBJECT_SELF,"Step")-1);
DeleteLocalInt(OBJECT_SELF,"Choice4");
 }
////////////////////////////////////////////////////////////////////////////////
}
