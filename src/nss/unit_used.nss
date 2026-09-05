// unit_used - OnUsed for a multi-unit rental door (tag "unitdoor").
// Opens the unit list. A DM configures the door with "Units" and "Unit<n>";
// see _unitrent.nss.
#include "_unitrent"

void main()
{
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) { return; }
    UnitRentOpen(oPC, OBJECT_SELF);
}
