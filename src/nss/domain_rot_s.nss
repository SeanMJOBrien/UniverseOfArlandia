#include "aps_include"
#include "_string_utils"
// Rotates the structure whose flag this is used on to face South - the
// domain system's default/unrotated orientation (iRot 0).
void main()
{
    DomainSetRotation(OBJECT_SELF, GetPCSpeaker(), 0);
}
