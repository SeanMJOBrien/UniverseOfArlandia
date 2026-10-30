// act_lang_dismiss - dialog action (test module): the speaker stops following the player.
void main()
{
    object oPC = GetPCSpeaker();
    if (!GetIsObjectValid(oPC)) return;
    RemoveHenchman(oPC, OBJECT_SELF);
}
