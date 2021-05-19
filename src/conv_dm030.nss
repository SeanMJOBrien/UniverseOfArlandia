////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
int i;int j;int k;
////////////////////////////////////////////////////////////////////////////////
     if(iChoice3==2){j = 0; k = 25;iStep = j+((iStep-3)*10);}
else if(iChoice3==3){j = 25;k = 33;iStep = j+((iStep-3)*10);}
else if(iChoice3==4){j = 33;k = 48;iStep = j+((iStep-3)*10);}
else if(iChoice3==5){j = 48;k = 53;iStep = j+((iStep-3)*10);}
else if(iChoice3==6){j = 53;k = 63;iStep = j+((iStep-3)*10);}

while(i<10)
 {
i++;
if(iStep+i<=k)
  {
SetCustomToken(20190+i,GetLocalString(oModule,"SoundName"+IntToString(iStep+i)));
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
  }
else
  {
SetCustomToken(20190+i,"");
SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
