// area_tmpl_boot - cache each area-clone-source template's object reference
// at module load, before any player can trigger a CopyArea() clone.
// ---
// transitions.nss resolves a tile's clone source via
// GetObjectByTag(sNewArea+"000") every single time a player travels there.
// CopyArea() clones keep the exact same Tag as their source (confirmed via
// the [transitions] log line: every rural-tile clone anywhere in the game
// reports tag=rural000, forever, identical to the master template's own
// tag) - so the moment even one such clone is alive when a DIFFERENT
// coordinate's CopyArea() request comes in, GetObjectByTag("rural000") can
// resolve to that live, already-populated clone instead of the true master
// template, and the new clone silently inherits a full copy of whatever
// the wrong "template" already contained (e.g. a player-built domain's
// structures - this is exactly how Findell's School ended up duplicated at
// an unrelated coordinate one tile over from the real domain, right after
// repeated test relogins kept a fully-built rural000-tagged clone alive at
// the same moment an adjacent tile was first visited).
//
// Run from mod_load.nss. At this point in boot no player has logged in yet,
// so no clone of any template can possibly exist - GetFirstArea()/
// GetNextArea() only walks the module's static area list, guaranteeing
// each "<type>000"-tagged object found here is unambiguously the one true
// master. transitions.nss consults this cache first and only falls back to
// a live GetObjectByTag() if a tag isn't found here (e.g. a template added
// without a server restart).
void main()
{
    object oModule = GetModule();
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea))
    {
        string sTag = GetTag(oArea);
        if (GetStringRight(sTag, 3) == "000")
        {
            SetLocalObject(oModule, "AreaTemplate_" + sTag, oArea);
        }
        oArea = GetNextArea();
    }
}
