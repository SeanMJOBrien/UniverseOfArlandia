#include "inc_adventurer"
void main()
{
// cond_hench001 (the conditional gating this entry) already sets this token
// before the entry's text renders - see the comment there. This action-taken
// pass just refreshes it for whatever the token is next read by (e.g. a
// level-up mid-conversation via conv_hench026 before this same node reopens).
SetCustomToken(10472,GetAdventurerGreetingLine(OBJECT_SELF));
}
