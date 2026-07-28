#include "aps_include"
#include "_string_utils"
// Rotates the structure whose flag this is used on to face East (see
// domain_rot_n.nss for the compass-to-iRot mapping derivation).
void main()
{
    DomainSetRotation(OBJECT_SELF, GetPCSpeaker(), 1);
}
