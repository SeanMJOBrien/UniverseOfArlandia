////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetExitingObject();
string sTag = GetTag(OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
// Domain baths
if(sTag=="trig_baths"){DeleteLocalInt(oPC,"InBath");}
////////////////////////////////////////////////////////////////////////////////
}
