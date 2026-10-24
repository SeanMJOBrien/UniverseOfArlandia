// lang_tablet_use - OnUsed (test module): the tablet "speaks" its text as a dialog.
void main()
{
    object oUser = GetLastUsedBy();
    if (!GetIsObjectValid(oUser)) return;
    AssignCommand(oUser, ActionStartConversation(OBJECT_SELF));
}
