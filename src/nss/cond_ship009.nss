#include "_spacenav"
// "Break off course." - only while a manual flight is running. Clearing the
// flag is the reliable way to stop: breaking off by walking away only cancels
// the current leg, leaving the flight to resume at the next tile boundary.
int StartingConditional()
{
    return (GetLocalString(GetPCSpeaker(), SPACENAV_FLY_TO) != "");
}
