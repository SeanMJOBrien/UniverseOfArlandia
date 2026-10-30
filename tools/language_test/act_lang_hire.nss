// act_lang_hire - dialog action (test module): the speaker joins the player as a henchman.
void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsObjectValid(oPC)) return;
    AddHenchman(oPC, OBJECT_SELF);
}
