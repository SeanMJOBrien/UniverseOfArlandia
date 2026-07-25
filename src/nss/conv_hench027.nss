void main()
{
object oHench = OBJECT_SELF;
string sLine = "What can I do for you ?";

if(GetTag(oHench)=="adventurer")
 {
int nClass1 = GetClassByPosition(1,oHench);
int nClass2 = GetClassByPosition(2,oHench);
int nClass3 = GetClassByPosition(3,oHench);
string s1 = IntToString(GetLevelByPosition(1,oHench))+" "+GetStringByStrRef(StringToInt(Get2DAString("classes","Name",nClass1)))+" seasons";
string sAll = s1;

if(nClass2!=CLASS_TYPE_INVALID)
  {
string s2 = IntToString(GetLevelByPosition(2,oHench))+" "+GetStringByStrRef(StringToInt(Get2DAString("classes","Name",nClass2)))+" seasons";
if(nClass3!=CLASS_TYPE_INVALID)
   {
string s3 = IntToString(GetLevelByPosition(3,oHench))+" "+GetStringByStrRef(StringToInt(Get2DAString("classes","Name",nClass3)))+" seasons";
sAll = s1+", "+s2+" and "+s3;
   }
else
   {
sAll = s1+" and "+s2;
   }
  }

sLine = "Are you looking to hire? I have "+sAll+".";
 }

SetCustomToken(10472,sLine);
}
