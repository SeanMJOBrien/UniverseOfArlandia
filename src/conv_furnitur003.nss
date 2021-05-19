void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oFurniture = GetLocalObject(oPC,"Furniture");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");
string sTag = GetTag(oFurniture);
vector vLoc = GetPosition(oPC);
location lLoc;

     if(iChoice==1){lLoc = Location(oArea,Vector(vLoc.x+0.0,vLoc.y+1.0,vLoc.z),270.0);}
else if(iChoice==2){lLoc = Location(oArea,Vector(vLoc.x+0.8,vLoc.y+0.8,vLoc.z),225.0);}
else if(iChoice==3){lLoc = Location(oArea,Vector(vLoc.x+1.0,vLoc.y+0.0,vLoc.z),180.0);}
else if(iChoice==4){lLoc = Location(oArea,Vector(vLoc.x+0.8,vLoc.y-0.8,vLoc.z),135.0);}
else if(iChoice==5){lLoc = Location(oArea,Vector(vLoc.x+0.0,vLoc.y-1.0,vLoc.z),90.0);}
else if(iChoice==6){lLoc = Location(oArea,Vector(vLoc.x-0.8,vLoc.y-0.8,vLoc.z),45.0);}
else if(iChoice==7){lLoc = Location(oArea,Vector(vLoc.x-1.0,vLoc.y+0.0,vLoc.z),0.0);}
else if(iChoice==8){lLoc = Location(oArea,Vector(vLoc.x-0.8,vLoc.y+0.8,vLoc.z),315.0);}

CreateObject(OBJECT_TYPE_PLACEABLE,GetStringRight(sTag,GetStringLength(sTag)-1),lLoc);
DestroyObject(oFurniture);
}
