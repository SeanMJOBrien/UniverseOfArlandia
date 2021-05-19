void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sName = GetName(oPC);
int iAreaX = (GetAreaSize(AREA_WIDTH,oArea)*10)/2;
int iAreaY = (GetAreaSize(AREA_HEIGHT,oArea)*10)/2;
float fPX = IntToFloat(iAreaX);
float fPY = IntToFloat(iAreaY);
float fPZ = 0.0;if(GetStringLeft(GetTag(oArea),8)=="tropical"){fPZ = 1.0;}else if((GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")){fPZ = 5.0;}
object oPla;int iNB;location lLoc;string sBP;

iNB++;sBP = "domaincontrol";lLoc = Location(oArea,Vector(fPX+0.0,fPY-3.0,fPZ+0.0),90.0);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPC,"DomainPla"+IntToString(iNB),oPla);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);SetLocalString(oPla,"Master",sName);SetName(oPla,sName+"'s Domain");
iNB++;sBP = "statuedomain";lLoc = Location(oArea,Vector(fPX+30.0,fPY-30.0,fPZ+0.0),90.0);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPC,"DomainPla"+IntToString(iNB),oPla);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);SetLocalString(oPla,"Master",sName);
iNB++;sBP = "statuedomain";lLoc = Location(oArea,Vector(fPX+30.0,fPY+30.0,fPZ+0.0),90.0);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPC,"DomainPla"+IntToString(iNB),oPla);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);SetLocalString(oPla,"Master",sName);
iNB++;sBP = "statuedomain";lLoc = Location(oArea,Vector(fPX-30.0,fPY-30.0,fPZ+0.0),90.0);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPC,"DomainPla"+IntToString(iNB),oPla);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);SetLocalString(oPla,"Master",sName);
iNB++;sBP = "statuedomain";lLoc = Location(oArea,Vector(fPX-30.0,fPY+30.0,fPZ+0.0),90.0);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc);SetLocalObject(oPC,"DomainPla"+IntToString(iNB),oPla);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION),lLoc);SetLocalString(oPla,"Master",sName);

DeleteLocalInt(oPC,"PlaceDomain");
}
