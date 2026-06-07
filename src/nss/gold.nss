////////////////////////////////////////////////////////////////////////////////
void main(){object oPC = OBJECT_SELF;object oGoldbag = GetItemPossessedBy(oPC,"goldbag");int iVar = GetGold(oPC)/100;int iC;itemproperty tItem = GetFirstItemProperty(oGoldbag);
////////////////////////////////////////////////////////////////////////////////
if(GetIsPC(oPC)){
while(GetIsItemPropertyValid(tItem)){RemoveItemProperty(oGoldbag,tItem);tItem = GetNextItemProperty(oGoldbag);}
while(iC<iVar){DelayCommand(0.01,AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS),oGoldbag,0.0));iC++;}
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),oGoldbag,0.0);}}
////////////////////////////////////////////////////////////////////////////////
