void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iAppOrig = GetLocalInt(oGoldbag,"AppOrig");
int iStart = GetLocalInt(oGoldbag,"Start");
int iRace = GetLocalInt(oGoldbag,"Race");

if((iAppOrig!=0)&&(GetAppearanceType(oPC)!=iAppOrig-1)&&(iStart==0))
 {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),oPC);
SetCreatureAppearanceType(oPC,iAppOrig-1);
if(iRace==16){SetCreatureBodyPart(CREATURE_PART_HEAD,GetLocalInt(oPC,"HeadOrig")-1,oPC);}
 }
ExecuteScript("conv_dm_varempty",OBJECT_SELF);
}
