////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
int i;string sSound;string sSName;
////////////////////////////////////////////////////////////////////////////////
int iTotalSounds = 63; // Total sounds
//
while(i<iTotalSounds)
 {
i++;
// Creatures
     if(i==1) {sSound = "c_elemair_bat2";sSName = "Air elemental";}
else if(i==2) {sSound = "c_bulette_bat1";sSName = "Bulette";}
else if(i==3) {sSound = "c_x0cockatr_atk1";sSName = "Cockatrice";}
else if(i==4) {sSound = "c_demon_bat1";sSName = "Demon";}
else if(i==5) {sSound = "c_dragnold_bat2";sSName = "Dragon";}
else if(i==6) {sSound = "c_goblin_atk2";sSName = "Goblin";}
else if(i==7) {sSound = "c_goldem_atk2";sSName = "Golem Elemental";}
else if(i==8) {sSound = "c_golmbone_bat1";sSName = "Golem Bone";}
else if(i==9) {sSound = "c_golmmith_slct";sSName = "Golem Mithril";}
else if(i==10){sSound = "c_hobgob_bat2";sSName = "Hobgoblin";}
else if(i==11){sSound = "c_horror_bat2";sSName = "Horror";}
else if(i==12){sSound = "c_kobold_bat1";sSName = "Kobold";}
else if(i==13){sSound = "as_an_koboldwee";sSName = "Kobold Weepee";}
else if(i==14){sSound = "c_lich_bat2";sSName = "Lich";}
else if(i==15){sSound = "c_mephit_atk2";sSName = "Mephit laugh";}
else if(i==16){sSound = "c_mephit_atk3";sSName = "Mephit fear";}
else if(i==17){sSound = "c_mindalhon_atk3";sSName = "Mindflayer";}
else if(i==18){sSound = "c_slaadpow_bat2";sSName = "Slaad";}
else if(i==19){sSound = "c_x0sphinx_atk2";sSName = "Sphinx";}
else if(i==20){sSound = "c_treant_atk3";sSName = "Treant";}
else if(i==21){sSound = "c_trog_bat1";sSName = "Troglodyte";}
else if(i==22){sSound = "c_umberhlk_bat1";sSName = "Umber hulk";}
else if(i==23){sSound = "c_vrock_atk1";sSName = "Vrock";}
else if(i==24){sSound = "as_an_wererat1";sSName = "Wererat";}
else if(i==25){sSound = "c_wolfwint_bat1";sSName = "Winter wolf";}
// Undeads
else if(i==26){sSound = "as_hr_x2ghost4";sSName = "Ghost far";}
else if(i==27){sSound = "as_hr_x2ghost7";sSName = "Ghost closest";}
else if(i==28){sSound = "as_hr_x2ghost10";sSName = "Ghost close";}
else if(i==29){sSound = "c_mummycom_bat1";sSName = "Mummy";}
else if(i==30){sSound = "c_shadow_bat2";sSName = "Shadow";}
else if(i==31){sSound = "c_skeleton_bat2";sSName = "Skeleton";}
else if(i==32){sSound = "c_wraith_bat1";sSName = "Wraith";}
else if(i==33){sSound = "c_zombwar_bat1";sSName = "Zombie close";}
// Cave sounds
     if(i==34){sSound = "as_an_batflap2";sSName = "Bat";}
else if(i==35){sSound = "as_an_batsflap2";sSName = "Bats";}
else if(i==36){sSound = "as_an_bearwolf3";sSName = "Bear wolf";}
else if(i==37){sSound = "as_pl_crptvoice1";sSName = "Crypt";}
else if(i==38){sSound = "as_an_dragonror1";sSName = "Dragon";}
else if(i==39){sSound = "as_pl_lafspook3";sSName = "Laughs";}
else if(i==40){sSound = "as_an_lizrdhiss1";sSName = "Lizard";}
else if(i==41){sSound = "as_an_mephgrunt3";sSName = "Mephit";}
else if(i==42){sSound = "as_an_ogregrunt2";sSName = "Ogre";}
else if(i==43){sSound = "as_an_orcgrunt3";sSName = "Orc";}
else if(i==44){sSound = "as_pl_screamm3";sSName = "Scream man";}
else if(i==45){sSound = "as_pl_screamf4";sSName = "Scream woman";}
else if(i==46){sSound = "as_an_x2spdlrg2";sSName = "Spider close";}
else if(i==47){sSound = "as_an_x2spdlrg7";sSName = "Spider far";}
else if(i==48){sSound = "as_pl_zombiem3";sSName = "Zombies far";}
// Civilisation
else if(i==49){sSound = "al_pl_x2bongolp1";sSName = "Bongo";}
else if(i==50){sSound = "al_pl_x2bongolp2";sSName = "Bongo rythm";}
else if(i==51){sSound = "al_pl_x2tablalp";sSName = "Tabla";}
else if(i==52){sSound = "al_pl_x2wardrum1";sSName = "War drums";}
else if(i==53){sSound = "al_pl_x2wardrum2";sSName = "War drums fast";}
// Nature/Weather
else if(i==54){sSound = "as_wt_gustcavrn1";sSName = "Cave gust";}
else if(i==55){sSound = "as_wt_gustchasm1";sSName = "Chasm gust";}
else if(i==56){sSound = "as_wt_gusforst1";sSName = "Forest gust";}
else if(i==57){sSound = "as_na_lavaburst1";sSName = "Lava";}
else if(i==58){sSound = "as_na_rockcavlg1";sSName = "Rock";}
else if(i==59){sSound = "as_na_x2lowrum2";sSName = "Low rum loud";}
else if(i==60){sSound = "as_na_x2lowrum4";sSName = "Low rum reverb";}
else if(i==61){sSound = "as_wt_thunderds3";sSName = "Thunder roll";}
else if(i==62){sSound = "as_wt_thundercl3";sSName = "Thunder clap far";}
else if(i==63){sSound = "as_wt_thunderds2";sSName = "Thunder clap close";}
//
SetLocalString(OBJECT_SELF,"Sound"+IntToString(i),sSound);
SetLocalString(OBJECT_SELF,"SoundName"+IntToString(i),sSName);
 }
////////////////////////////////////////////////////////////////////////////////
}
