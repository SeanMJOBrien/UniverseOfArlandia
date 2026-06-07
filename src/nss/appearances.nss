void main()
{
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iRace = GetRacialType(oPC);
int iOrig;

     if(iRace==RACIAL_TYPE_DWARF){iOrig = APPEARANCE_TYPE_DWARF;}
else if(iRace==RACIAL_TYPE_ELF){iOrig = APPEARANCE_TYPE_ELF;}
else if(iRace==RACIAL_TYPE_GNOME){iOrig = APPEARANCE_TYPE_GNOME;}
else if(iRace==RACIAL_TYPE_HALFELF){iOrig = APPEARANCE_TYPE_HALF_ELF;}
else if(iRace==RACIAL_TYPE_HALFLING){iOrig = APPEARANCE_TYPE_HALFLING;}
else if(iRace==RACIAL_TYPE_HALFORC){iOrig = APPEARANCE_TYPE_HALF_ORC;}
else if(iRace==RACIAL_TYPE_HUMAN){iOrig = APPEARANCE_TYPE_HUMAN;}

SetCreatureAppearanceType(oPC,iOrig);
SetPhenoType(GetLocalInt(oGoldbag,"Phenotype"),oPC);
SetFootstepType(FOOTSTEP_TYPE_DEFAULT,oPC);
}
