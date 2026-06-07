void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iPrice;string s;

SetLocalInt(OBJECT_SELF,"ChoiceDone1",1);SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);

s = "Alchemist";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Animaler";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Architect";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Armorsmith";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Banker";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Blacksmith";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Bookseller";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Caster";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Engineer";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Foodmaker";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Healer";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Jeweler";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Tailor";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Taverner";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Trainer";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
s = "Weaponsmith";if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice));}
}
