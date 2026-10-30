// lang_tablet_use - OnUsed (test module): the tablet "speaks" its text as a dialog.
// The placeable starts the conversation with the player, as talking signs do.
void main()
{
    object oUser = GetLastUsedBy();
    if (!GetIsObjectValid(oUser)) return;
    // Test module only: shows that the script ran, so a missing dialog can be told apart from a missing click.
    SendMessageToPC(oUser, "You study the tablet.");
    ActionStartConversation(oUser, "lang_tablet", TRUE, FALSE);
}
