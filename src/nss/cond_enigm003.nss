int StartingConditional()
{
object oPC = GetPCSpeaker();
object oItem = GetFirstItemInInventory(oPC);
//
object oEnigm = GetLocalObject(OBJECT_SELF,"oEnigm");
string sEnigms = GetLocalString(oEnigm,"Var");
int iEnigm1 = StringToInt(GetStringLeft(sEnigms,FindSubString(sEnigms,"_")));
string sResult = GetLocalString(oEnigm,"Result");
string sSuccess = GetStringRight(sEnigms,8);
int i;int j;
//
if(iEnigm1==3)
 {
j=1;
if(sSuccess=="&Success")
  {
i++;
  }
 }
//
else if(iEnigm1==4)
 {
j = GetLocalInt(oEnigm,"Items");
while(GetIsObjectValid(oItem))
  {
if((GetResRef(oItem)==sResult)&&(GetLocalInt(oItem,"Enigm")==1))
   {
if(GetItemStackSize(oItem)>1){i = i+GetItemStackSize(oItem);}else{i++;}
   }
oItem = GetNextItemInInventory(oPC);
  }
 }
//
if(i<j){return TRUE;}else{return FALSE;}
}
