#include "aps_include"
// _domainuser - approved users of someone else's domain (TASK-35).
//
// A domain is a world coordinate whose Interests record carries a Master (the
// owner's character name, written by domains.nss:1676). This adds a per-domain
// allow-list of OTHER characters the owner has approved.
//
// An approved user may:
//   - take resources from the domain's extractors
//   - rent, enter and decorate a property in the domain
// An approved user may NOT build or destroy anything, in this or any domain.
// That split is the whole point of the feature, and it is NOT enforced by this
// file - it lives in which dialog replies get which condition script. See
// TASK-35 for the exact reply list.
//
// Storage: one pwdata row per domain, holding an &-wrapped list of approved
// character names, e.g. "&Alice&Bob&". Names are matched with their delimiters
// attached so "Al" never matches "Alice".
//
// Character NAME is used as the identifier because that is what the domain
// system already keys on everywhere (Master strings, cond_domain004/005/019).
// It inherits that scheme's fragility - see TASK-33 - and if domain ownership
// ever moves to a stable id, this list must move with it in the same change.
// The one place a name is NOT enough is the same-account shortcut below, which
// has to compare accounts rather than characters, and so uses the public CD key
// (the same identifier _webmap.nss indexes characters under).

const string DOMAINUSER_SEP = "&";

// pwdata key for a domain coordinate's approved-user list.
string DomainUsersKey(string sPlanet, string sArea)
{
    return sPlanet + "&" + sArea + "&DomainUsers";
}

// The raw &-wrapped list, or "" when nobody is approved.
string DomainUsersList(string sPlanet, string sArea)
{
    return GetPersistentString(GetModule(), DomainUsersKey(sPlanet, sArea));
}

// Is sName on this domain's approved list?
int DomainIsApprovedName(string sName, string sPlanet, string sArea)
{
    if (sName == "") { return FALSE; }
    string sList = DomainUsersList(sPlanet, sArea);
    if (sList == "") { return FALSE; }
    return (FindSubString(sList, DOMAINUSER_SEP + sName + DOMAINUSER_SEP) != -1);
}

// Add a character to the domain's approved list. No-op if already present.
void DomainAddUser(string sName, string sPlanet, string sArea)
{
    if (sName == "") { return; }
    if (DomainIsApprovedName(sName, sPlanet, sArea)) { return; }
    string sList = DomainUsersList(sPlanet, sArea);
    if (sList == "") { sList = DOMAINUSER_SEP; }
    SetPersistentString(GetModule(), DomainUsersKey(sPlanet, sArea), sList + sName + DOMAINUSER_SEP);
}

// Remove a character from the domain's approved list.
void DomainRemoveUser(string sName, string sPlanet, string sArea)
{
    if (!DomainIsApprovedName(sName, sPlanet, sArea)) { return; }
    string sList = DomainUsersList(sPlanet, sArea);
    string sCut = DOMAINUSER_SEP + sName + DOMAINUSER_SEP;
    int iAt = FindSubString(sList, sCut);
    string sLeft = GetStringLeft(sList, iAt);
    string sRight = GetStringRight(sList, GetStringLength(sList) - iAt - GetStringLength(sCut));
    string sNew = sLeft + DOMAINUSER_SEP + sRight;
    if (sNew == DOMAINUSER_SEP) { sNew = ""; }
    SetPersistentString(GetModule(), DomainUsersKey(sPlanet, sArea), sNew);
}

// Two PCs are on the same account when they share a public CD key. This is what
// lets a player approve their own alt without a second person online: they are
// literally both sides of the transaction.
int DomainSameAccount(object oPC1, object oPC2)
{
    if ((!GetIsObjectValid(oPC1)) || (!GetIsObjectValid(oPC2))) { return FALSE; }
    string sKey1 = GetPCPublicCDKey(oPC1);
    if (sKey1 == "") { return FALSE; }
    return (sKey1 == GetPCPublicCDKey(oPC2));
}

// May oPC use (not build in) the domain at this coordinate? True for the owner,
// for anyone on the approved list, and for DMs.
//
// sMaster is the domain's owner name, as already read from the placeable's
// "Master" local or the Interests record by the calling condition script.
int DomainCanUse(object oPC, string sPlanet, string sArea, string sMaster)
{
    if (!GetIsObjectValid(oPC)) { return FALSE; }
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) { return TRUE; }
    string sName = GetName(oPC);
    if ((sMaster != "") && (sMaster == sName)) { return TRUE; }
    return DomainIsApprovedName(sName, sPlanet, sArea);
}

// May oPC build or destroy in this domain? Owner and DMs only, ever - an
// approved user never gains construction rights, here or anywhere else.
// Kept as its own function so the distinction is explicit at every call site
// rather than implied by which flavour of name compare someone wrote.
int DomainCanBuild(object oPC, string sMaster)
{
    if (!GetIsObjectValid(oPC)) { return FALSE; }
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) { return TRUE; }
    return ((sMaster != "") && (sMaster == GetName(oPC)));
}

// The domain coordinate an area belongs to. Inside a structure interior,
// transitions2.nss stores the outer world coordinate as "AreaExit" while
// "Area" carries the interior's own suffixed key, so prefer AreaExit and fall
// back to Area for the outdoor domain tile itself.
string DomainAreaOf(object oArea)
{
    string sExit = GetLocalString(oArea, "AreaExit");
    if (sExit != "") { return sExit; }
    return GetLocalString(oArea, "Area");
}
