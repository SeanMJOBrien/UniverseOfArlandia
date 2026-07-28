#include "aps_include"
#include "_string_utils"
// Rotates the structure whose flag this is used on to face North (compass
// mapping derived from RotateFacing90's additive rotation over the engine's
// DIRECTION_* facing values, given the domain system's default/unrotated
// orientation is South: South=0, East=1, North=2, West=3).
void main()
{
    DomainSetRotation(OBJECT_SELF, GetPCSpeaker(), 2);
}
