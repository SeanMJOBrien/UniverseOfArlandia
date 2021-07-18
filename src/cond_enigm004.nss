////////////////////////////////////////////////////////////////////////////////
int StartingConditional(){
////////////////////////////////////////////////////////////////////////////////
object oEnigm = GetLocalObject(OBJECT_SELF,"oEnigm");
string sEnigms = GetLocalString(oEnigm,"Var");
int iEnigm1 = StringToInt(GetStringLeft(sEnigms,FindSubString(sEnigms,"_")));
int iEnigm2 = StringToInt(GetStringRight(sEnigms,GetStringLength(sEnigms)-FindSubString(sEnigms,"_")-1));
string sResult = GetLocalString(oEnigm,"Result");
string sAnswer = GetLocalString(OBJECT_SELF,"Word");
int iC1;int iC2;int iC3;int iC4;int i1;int i2;int i3;int i4;string s1;string s2;string s3;int iAnswer;int i;
////////////////////////////////////////////////////////////////////////////////
if(iEnigm1==1)
 {
////////////////////////////////////////////////////////////////////////////////
if(iEnigm2==1)
  {
iC1 = FindSubString(sAnswer,GetLocalString(oEnigm,"Number1"));
iC2 = FindSubString(sAnswer,GetLocalString(oEnigm,"Number2"));
iC3 = FindSubString(sAnswer,GetLocalString(oEnigm,"Number3"));
i1 = StringToInt(GetSubString(sAnswer,0,1));
s1 = GetSubString(sAnswer,1,1);
i2 = StringToInt(GetSubString(sAnswer,2,1));
s2 = GetSubString(sAnswer,3,1);
i3 = StringToInt(GetSubString(sAnswer,4,1));
if((iC1==iC2)||(iC1==iC3)||(iC2==iC3)){iC1 = -1;}

     if((s1=="+")&&(s2=="+")){iAnswer = i1+i2+i3;}
else if((s1=="+")&&(s2=="-")){iAnswer = i1+i2-i3;}
else if((s1=="+")&&(s2=="*")){iAnswer = i1+i2*i3;}
else if((s1=="-")&&(s2=="+")){iAnswer = i1-i2+i3;}
else if((s1=="-")&&(s2=="-")){iAnswer = i1-i2-i3;}
else if((s1=="-")&&(s2=="*")){iAnswer = i1-i2*i3;}
else if((s1=="*")&&(s2=="+")){iAnswer = i1*i2+i3;}
else if((s1=="*")&&(s2=="-")){iAnswer = i1*i2-i3;}
else if((s1=="*")&&(s2=="*")){iAnswer = i1*i2*i3;}

if((IntToString(iAnswer)==sResult)&&(iC1!=-1)&&(iC2!=-1)&&(iC3!=-1)){i++;}
  }
////////////////////////////////////////////////////////////////////////////////
else if(iEnigm2==2)
  {
iC1 = FindSubString(sAnswer,GetLocalString(oEnigm,"Number1"));
iC2 = FindSubString(sAnswer,GetLocalString(oEnigm,"Number2"));
iC3 = FindSubString(sAnswer,GetLocalString(oEnigm,"Number3"));
iC4 = FindSubString(sAnswer,GetLocalString(oEnigm,"Number4"));
i1 = StringToInt(GetSubString(sAnswer,0,1));
s1 = GetSubString(sAnswer,1,1);
i2 = StringToInt(GetSubString(sAnswer,2,1));
s2 = GetSubString(sAnswer,3,1);
i3 = StringToInt(GetSubString(sAnswer,4,1));
s3 = GetSubString(sAnswer,5,1);
i4 = StringToInt(GetSubString(sAnswer,6,1));
if((iC1==iC2)||(iC1==iC3)||(iC1==iC4)||(iC2==iC3)||(iC2==iC4)||(iC3==iC4)){iC1 = -1;}

     if((s1=="+")&&(s2=="+")&&(s3=="+")){iAnswer = i1+i2+i3+i4;}
else if((s1=="+")&&(s2=="+")&&(s3=="-")){iAnswer = i1+i2+i3-i4;}
else if((s1=="+")&&(s2=="+")&&(s3=="*")){iAnswer = i1+i2+i3*i4;}
else if((s1=="+")&&(s2=="-")&&(s3=="+")){iAnswer = i1+i2-i3+i4;}
else if((s1=="+")&&(s2=="-")&&(s3=="-")){iAnswer = i1+i2-i3-i4;}
else if((s1=="+")&&(s2=="-")&&(s3=="*")){iAnswer = i1+i2-i3*i4;}
else if((s1=="+")&&(s2=="*")&&(s3=="+")){iAnswer = i1+i2*i3+i4;}
else if((s1=="+")&&(s2=="*")&&(s3=="-")){iAnswer = i1+i2*i3-i4;}
else if((s1=="+")&&(s2=="*")&&(s3=="*")){iAnswer = i1+i2*i3*i4;}
else if((s1=="-")&&(s2=="+")&&(s3=="+")){iAnswer = i1-i2+i3+i4;}
else if((s1=="-")&&(s2=="+")&&(s3=="-")){iAnswer = i1-i2+i3-i4;}
else if((s1=="-")&&(s2=="+")&&(s3=="*")){iAnswer = i1-i2+i3*i4;}
else if((s1=="-")&&(s2=="-")&&(s3=="+")){iAnswer = i1-i2-i3+i4;}
else if((s1=="-")&&(s2=="-")&&(s3=="-")){iAnswer = i1-i2-i3-i4;}
else if((s1=="-")&&(s2=="-")&&(s3=="*")){iAnswer = i1-i2-i3*i4;}
else if((s1=="-")&&(s2=="*")&&(s3=="+")){iAnswer = i1-i2*i3+i4;}
else if((s1=="-")&&(s2=="*")&&(s3=="-")){iAnswer = i1-i2*i3-i4;}
else if((s1=="-")&&(s2=="*")&&(s3=="*")){iAnswer = i1-i2*i3*i4;}
else if((s1=="*")&&(s2=="+")&&(s3=="+")){iAnswer = i1*i2+i3+i4;}
else if((s1=="*")&&(s2=="+")&&(s3=="-")){iAnswer = i1*i2+i3-i4;}
else if((s1=="*")&&(s2=="+")&&(s3=="*")){iAnswer = i1*i2+i3*i4;}
else if((s1=="*")&&(s2=="-")&&(s3=="+")){iAnswer = i1*i2-i3+i4;}
else if((s1=="*")&&(s2=="-")&&(s3=="-")){iAnswer = i1*i2-i3-i4;}
else if((s1=="*")&&(s2=="-")&&(s3=="*")){iAnswer = i1*i2-i3*i4;}
else if((s1=="*")&&(s2=="*")&&(s3=="+")){iAnswer = i1*i2*i3+i4;}
else if((s1=="*")&&(s2=="*")&&(s3=="-")){iAnswer = i1*i2*i3-i4;}
else if((s1=="*")&&(s2=="*")&&(s3=="*")){iAnswer = i1*i2*i3*i4;}

if((IntToString(iAnswer)==sResult)&&(iC1!=-1)&&(iC2!=-1)&&(iC3!=-1)&&(iC4!=-1)){i++;}
  }
////////////////////////////////////////////////////////////////////////////////
else if(sAnswer==sResult){i++;}
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
else if(sAnswer==sResult){i++;}
////////////////////////////////////////////////////////////////////////////////
if(i>0){return TRUE;}else{return FALSE;}
////////////////////////////////////////////////////////////////////////////////
}
