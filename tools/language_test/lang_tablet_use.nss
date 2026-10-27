// lang_tablet_use - OnUsed (test module): the tablet "speaks" its text as a dialog.
// The placeable starts the conversation with the player, as talking signs do.
void main()
{
    object oUser = GetLastUsedBy();
    if (!GetIsObjectValid(oUser)) return;
    ActionStartConversation(oUser, "lang_tablet", TRUE, FALSE);
}
