void main()
{
object oPC = GetPCSpeaker();

if(GetLocalString(oPC,"Appareance20231")==""){SetCustomToken(20231,"Custom 1.");}else{SetCustomToken(20231,GetLocalString(oPC,"Appareance20231")+".");}
if(GetLocalString(oPC,"Appareance20232")==""){SetCustomToken(20232,"Custom 2.");}else{SetCustomToken(20232,GetLocalString(oPC,"Appareance20232")+".");}
if(GetLocalString(oPC,"Appareance20233")==""){SetCustomToken(20233,"Custom 3.");}else{SetCustomToken(20233,GetLocalString(oPC,"Appareance20233")+".");}
if(GetLocalString(oPC,"Appareance20234")==""){SetCustomToken(20234,"Custom 4.");}else{SetCustomToken(20234,GetLocalString(oPC,"Appareance20234")+".");}
if(GetLocalString(oPC,"Appareance20235")==""){SetCustomToken(20235,"Custom 5.");}else{SetCustomToken(20235,GetLocalString(oPC,"Appareance20235")+".");}
if(GetLocalString(oPC,"Appareance20236")==""){SetCustomToken(20236,"Custom 6.");}else{SetCustomToken(20236,GetLocalString(oPC,"Appareance20236")+".");}
}
