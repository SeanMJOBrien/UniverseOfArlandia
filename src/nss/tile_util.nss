////////////////////////////////////////////////////////////////////////////////
// Universe of Arlandia - Tile Editing Utilities
//
// A portable wrapper around the NWN:EE engine tile functions (SetTile /
// GetTileID / GetTileOrientation / GetTileHeight) so any module can change
// area terrain tiles safely, including multi-tile "footprint" groups stamped
// as one unit with a chosen facing.
//
// Import with:
//   #include "tile_util"
//
// This file has NO include dependencies (engine functions only) and no tie to
// NWNX or the persistent-storage layer. Callers that want durable,
// cross-session tile edits are responsible for saving the strings the
// snapshot functions return (e.g. via SetPersistentString) themselves.
//
// A "footprint" is a plain delimited string, one record per tile, in the
// pattern's own unrotated ("facing 0") local frame:
//   "dCol,dRow,tileID,orientation,height|dCol,dRow,tileID,orientation,height|..."
// Build it with TileFootprint_AddTile(), then stamp it with a group facing via
// ApplyTileFootprint(); the offsets and per-tile orientations are rotated for
// you. A snapshot is just a footprint captured at facing 0 with absolute grid
// coordinates in the offset fields, so restoring is re-applying it at facing 0.
//
// Engine caveats worth remembering (from nwscript.nss doc comments):
//   - nTileID must be valid in the AREA'S OWN tileset (.set catalog).
//   - SetTile does NOT move non-creature placeables already on the tile - they
//     can end up floating/clipped.
//   - Creatures can get stuck if a tile becomes non-walkable.
//   - Grass / area-border tiles are only refreshed if you pass the matching
//     reload flag (bReloadGrass / bReloadBorder).
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Constants
////////////////////////////////////////////////////////////////////////////////

// World units per tile edge. Confirmed dominant convention across the codebase
// (area_transition.nss, build_area.nss, area_interests.nss, etc.); domains.nss's
// "*5" is a one-off outlier local to that file, not the house convention.
const float  TILE_SIZE       = 10.0;

// Mirrors the engine's -1-on-error return from GetTileID/Orientation/Height.
const int    TILE_INVALID    = -1;

// Delimiters for the footprint / snapshot record strings.
const string TILE_FIELD_SEP  = ",";   // between fields within one tile record
const string TILE_RECORD_SEP = "|";   // between tile records

////////////////////////////////////////////////////////////////////////////////
// Prototypes
////////////////////////////////////////////////////////////////////////////////

// --- Grid <-> world conversion ---
int      GetAreaTileColumns(object oArea);
int      GetAreaTileRows(object oArea);
vector   GetTileGridPosition(object oArea, vector vWorld);
vector   GetTileWorldPosition(object oArea, int iCol, int iRow);
location GetTileLocation(object oArea, int iCol, int iRow, float fFacing = 0.0);
int      FacingToOrientationStep(float fFacingDegrees);
float    OrientationStepToFacing(int nFacing);

// --- Bounds validation ---
int      IsTileInArea(object oArea, int iCol, int iRow);
int      IsWorldPositionInArea(object oArea, vector vWorld);
int      IsEdgeTile(object oArea, int iCol, int iRow);

// --- Single-tile safe wrappers ---
int      GetTileIDSafe(object oArea, int iCol, int iRow);
int      GetTileOrientationSafe(object oArea, int iCol, int iRow);
int      GetTileHeightSafe(object oArea, int iCol, int iRow);
int      SetTileSafe(object oArea, int iCol, int iRow, int nTileID, int nOrientation, int nHeight = 0, int bReloadGrass = FALSE, int bReloadBorder = FALSE);

// --- Footprint builder / query / apply ---
string   TileFootprint_AddTile(string sFootprint, int iOffsetCol, int iOffsetRow, int nTileID, int nOrientation, int nHeight = 0);
int      GetFootprintTileCount(string sFootprint);
int      IsFootprintClear(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint);
string   GetFootprintTiles(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint);
int      ApplyTileFootprint(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint, int bReloadGrass = FALSE, int bReloadBorder = FALSE);
int      ApplyTileFootprintAtLocation(location lOrigin, string sFootprint, int bReloadGrass = FALSE, int bReloadBorder = FALSE);

// --- Snapshot / restore ---
string   SnapshotTile(object oArea, int iCol, int iRow);
string   SnapshotFootprint(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint);
int      RestoreTileSnapshot(object oArea, string sSnapshot, int bReloadGrass = FALSE, int bReloadBorder = FALSE);

// --- Private helpers ---
int      _RotateOrientationStep(int nOrientation, int nFacing);
vector   _RotateOffset(int iOffsetCol, int iOffsetRow, int nFacing);
string   _GetFootprintRecord(string sFootprint, int iIndex);
int      _RecordField(string sRecord, int iField);
int      _NormalizeFacing(int nFacing);

////////////////////////////////////////////////////////////////////////////////
// Grid <-> world conversion
////////////////////////////////////////////////////////////////////////////////

// Number of tiles the area is wide (X) / high (Y). Engine GetAreaSize already
// returns tile counts, not world units.
int GetAreaTileColumns(object oArea)
{
    return GetAreaSize(AREA_WIDTH, oArea);
}
int GetAreaTileRows(object oArea)
{
    return GetAreaSize(AREA_HEIGHT, oArea);
}

// World position -> containing tile, packed as .x=column, .y=row (whole-number
// floats; caller applies FloatToInt). .z is unused (0.0).
vector GetTileGridPosition(object oArea, vector vWorld)
{
    int iCol = FloatToInt(vWorld.x / TILE_SIZE);
    int iRow = FloatToInt(vWorld.y / TILE_SIZE);
    return Vector(IntToFloat(iCol), IntToFloat(iRow), 0.0);
}

// Tile (col,row) -> world-space CENTER of that tile. Centering avoids the
// boundary-rounding ambiguity that would arise if the corner were floored back
// to a tile index by the engine.
vector GetTileWorldPosition(object oArea, int iCol, int iRow)
{
    float fX = IntToFloat(iCol) * TILE_SIZE + TILE_SIZE / 2.0;
    float fY = IntToFloat(iRow) * TILE_SIZE + TILE_SIZE / 2.0;
    return Vector(fX, fY, 0.0);
}

// Tile (col,row) -> location, for direct use with SetTile()/GetTileID()/etc.
// fFacing is irrelevant to tile identity; it defaults to 0.0 because Location()
// requires an orientation argument.
location GetTileLocation(object oArea, int iCol, int iRow, float fFacing = 0.0)
{
    return Location(oArea, GetTileWorldPosition(oArea, iCol, iRow), fFacing);
}

// Round a world facing angle (degrees, CCW from +X, as GetFacing() returns) to
// the nearest 90-degree tile-orientation step, 0-3.
int FacingToOrientationStep(float fFacingDegrees)
{
    return _NormalizeFacing(FloatToInt(fFacingDegrees / 90.0 + 0.5));
}

// Inverse of FacingToOrientationStep: orientation step 0-3 -> facing degrees.
float OrientationStepToFacing(int nFacing)
{
    return IntToFloat(_NormalizeFacing(nFacing)) * 90.0;
}

////////////////////////////////////////////////////////////////////////////////
// Bounds validation
////////////////////////////////////////////////////////////////////////////////

// TRUE if (iCol,iRow) is a real tile in oArea. The single guard every write /
// read funnels through before touching the engine.
int IsTileInArea(object oArea, int iCol, int iRow)
{
    if (!GetIsObjectValid(oArea)) return FALSE;
    if ((iCol < 0) || (iRow < 0)) return FALSE;
    return ((iCol < GetAreaTileColumns(oArea)) && (iRow < GetAreaTileRows(oArea)));
}

int IsWorldPositionInArea(object oArea, vector vWorld)
{
    vector vTile = GetTileGridPosition(oArea, vWorld);
    return IsTileInArea(oArea, FloatToInt(vTile.x), FloatToInt(vTile.y));
}

// TRUE if the tile borders the area's outer edge. Geometric heuristic only (it
// does not know about grass placement) - use it to decide whether to pass
// bReloadBorder when editing an edge tile.
int IsEdgeTile(object oArea, int iCol, int iRow)
{
    if (!IsTileInArea(oArea, iCol, iRow)) return FALSE;
    return ((iCol == 0) || (iRow == 0) ||
            (iCol == GetAreaTileColumns(oArea) - 1) ||
            (iRow == GetAreaTileRows(oArea) - 1));
}

////////////////////////////////////////////////////////////////////////////////
// Single-tile safe wrappers
////////////////////////////////////////////////////////////////////////////////

// Read the tile ID / orientation / height, returning TILE_INVALID (without
// calling the engine) if (iCol,iRow) is out of bounds.
int GetTileIDSafe(object oArea, int iCol, int iRow)
{
    if (!IsTileInArea(oArea, iCol, iRow)) return TILE_INVALID;
    return GetTileID(GetTileLocation(oArea, iCol, iRow));
}
int GetTileOrientationSafe(object oArea, int iCol, int iRow)
{
    if (!IsTileInArea(oArea, iCol, iRow)) return TILE_INVALID;
    return GetTileOrientation(GetTileLocation(oArea, iCol, iRow));
}
int GetTileHeightSafe(object oArea, int iCol, int iRow)
{
    if (!IsTileInArea(oArea, iCol, iRow)) return TILE_INVALID;
    return GetTileHeight(GetTileLocation(oArea, iCol, iRow));
}

// Change a single tile. Validates the area and bounds first; returns FALSE and
// does nothing if either fails (avoids undefined behaviour at/beyond the edge).
// Grass/border reload default OFF - most edits are interior and don't need them.
int SetTileSafe(object oArea, int iCol, int iRow, int nTileID, int nOrientation, int nHeight = 0, int bReloadGrass = FALSE, int bReloadBorder = FALSE)
{
    if (!IsTileInArea(oArea, iCol, iRow)) return FALSE;

    int nFlags = SETTILE_FLAG_RECOMPUTE_LIGHTING;
    if (bReloadGrass)  nFlags = nFlags | SETTILE_FLAG_RELOAD_GRASS;
    if (bReloadBorder) nFlags = nFlags | SETTILE_FLAG_RELOAD_BORDER;

    SetTile(GetTileLocation(oArea, iCol, iRow), nTileID, _NormalizeFacing(nOrientation), nHeight, nFlags);
    return TRUE;
}

////////////////////////////////////////////////////////////////////////////////
// Footprint builder / query / apply
////////////////////////////////////////////////////////////////////////////////

// Append one tile to a footprint string and return the result. Offsets and
// orientation are in the footprint's own local, unrotated (facing 0) frame.
string TileFootprint_AddTile(string sFootprint, int iOffsetCol, int iOffsetRow, int nTileID, int nOrientation, int nHeight = 0)
{
    string sRecord = IntToString(iOffsetCol) + TILE_FIELD_SEP +
                     IntToString(iOffsetRow) + TILE_FIELD_SEP +
                     IntToString(nTileID)    + TILE_FIELD_SEP +
                     IntToString(nOrientation) + TILE_FIELD_SEP +
                     IntToString(nHeight);
    if (sFootprint == "") return sRecord;
    return sFootprint + TILE_RECORD_SEP + sRecord;
}

// Number of tile records in a footprint / snapshot string.
int GetFootprintTileCount(string sFootprint)
{
    if (sFootprint == "") return 0;
    int iCount = 1;
    int iPos = FindSubString(sFootprint, TILE_RECORD_SEP);
    while (iPos != -1)
    {
        iCount++;
        sFootprint = GetStringRight(sFootprint, GetStringLength(sFootprint) - iPos - 1);
        iPos = FindSubString(sFootprint, TILE_RECORD_SEP);
    }
    return iCount;
}

// Dry-run: TRUE only if every tile the footprint would touch (after rotating by
// nFacing about the origin) is in-bounds. No engine writes.
int IsFootprintClear(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint)
{
    if (!GetIsObjectValid(oArea)) return FALSE;
    nFacing = _NormalizeFacing(nFacing);

    int iCount = GetFootprintTileCount(sFootprint);
    int i;
    for (i = 0; i < iCount; i++)
    {
        string sRec = _GetFootprintRecord(sFootprint, i);
        vector vOff = _RotateOffset(_RecordField(sRec, 0), _RecordField(sRec, 1), nFacing);
        if (!IsTileInArea(oArea, iOriginCol + FloatToInt(vOff.x), iOriginRow + FloatToInt(vOff.y)))
            return FALSE;
    }
    return TRUE;
}

// Same computation as ApplyTileFootprint but returns the resulting ABSOLUTE
// tiles (col,row + post-rotation tileID/orientation/height) as a footprint-
// shaped string for logging / DM inspection / keep-out checks. No writes.
string GetFootprintTiles(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint)
{
    nFacing = _NormalizeFacing(nFacing);
    string sOut = "";

    int iCount = GetFootprintTileCount(sFootprint);
    int i;
    for (i = 0; i < iCount; i++)
    {
        string sRec = _GetFootprintRecord(sFootprint, i);
        vector vOff = _RotateOffset(_RecordField(sRec, 0), _RecordField(sRec, 1), nFacing);
        int iAbsCol = iOriginCol + FloatToInt(vOff.x);
        int iAbsRow = iOriginRow + FloatToInt(vOff.y);
        int nOrient = _RotateOrientationStep(_RecordField(sRec, 3), nFacing);
        sOut = TileFootprint_AddTile(sOut, iAbsCol, iAbsRow, _RecordField(sRec, 2), nOrient, _RecordField(sRec, 4));
    }
    return sOut;
}

// Stamp a footprint at (iOriginCol,iOriginRow) rotated by nFacing (0-3).
// All-or-nothing: if any target tile would be out of bounds, nothing is written
// and it returns FALSE (no half-stamped pad running off the map edge). Grass /
// border are reloaded once at the end (not per tile) if requested.
int ApplyTileFootprint(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint, int bReloadGrass = FALSE, int bReloadBorder = FALSE)
{
    if (!IsFootprintClear(oArea, iOriginCol, iOriginRow, nFacing, sFootprint)) return FALSE;
    nFacing = _NormalizeFacing(nFacing);

    int iCount = GetFootprintTileCount(sFootprint);
    int i;
    for (i = 0; i < iCount; i++)
    {
        string sRec = _GetFootprintRecord(sFootprint, i);
        vector vOff = _RotateOffset(_RecordField(sRec, 0), _RecordField(sRec, 1), nFacing);
        int nOrient = _RotateOrientationStep(_RecordField(sRec, 3), nFacing);
        // Suppress per-tile grass/border reloads; do them once below.
        SetTileSafe(oArea, iOriginCol + FloatToInt(vOff.x), iOriginRow + FloatToInt(vOff.y),
                    _RecordField(sRec, 2), nOrient, _RecordField(sRec, 4), FALSE, FALSE);
    }

    if (bReloadGrass)  ReloadAreaGrass(oArea);
    if (bReloadBorder) ReloadAreaBorder(oArea);
    return TRUE;
}

// Convenience overload deriving area / origin tile / facing from a location
// (e.g. a PC's position or a placed anchor object) instead of raw grid indices.
int ApplyTileFootprintAtLocation(location lOrigin, string sFootprint, int bReloadGrass = FALSE, int bReloadBorder = FALSE)
{
    object oArea = GetAreaFromLocation(lOrigin);
    vector vOrigin = GetTileGridPosition(oArea, GetPositionFromLocation(lOrigin));
    int nFacing = FacingToOrientationStep(GetFacingFromLocation(lOrigin));
    return ApplyTileFootprint(oArea, FloatToInt(vOrigin.x), FloatToInt(vOrigin.y), nFacing, sFootprint, bReloadGrass, bReloadBorder);
}

////////////////////////////////////////////////////////////////////////////////
// Snapshot / restore
//
// A snapshot is a footprint captured at facing 0 whose offset fields already
// hold ABSOLUTE grid coordinates - so RestoreTileSnapshot just re-applies it as
// a footprint at origin (0,0) with facing 0.
////////////////////////////////////////////////////////////////////////////////

// Capture one tile's current state as a single footprint record. Returns "" if
// the tile is out of bounds (a sentinel meaning "nothing to restore here").
string SnapshotTile(object oArea, int iCol, int iRow)
{
    if (!IsTileInArea(oArea, iCol, iRow)) return "";
    return TileFootprint_AddTile("", iCol, iRow,
                                 GetTileIDSafe(oArea, iCol, iRow),
                                 GetTileOrientationSafe(oArea, iCol, iRow),
                                 GetTileHeightSafe(oArea, iCol, iRow));
}

// Capture every tile a footprint is about to overwrite. Call BEFORE
// ApplyTileFootprint; hand the returned string to RestoreTileSnapshot to undo.
// Out-of-bounds tiles are skipped.
string SnapshotFootprint(object oArea, int iOriginCol, int iOriginRow, int nFacing, string sFootprint)
{
    nFacing = _NormalizeFacing(nFacing);
    string sOut = "";

    int iCount = GetFootprintTileCount(sFootprint);
    int i;
    for (i = 0; i < iCount; i++)
    {
        string sRec = _GetFootprintRecord(sFootprint, i);
        vector vOff = _RotateOffset(_RecordField(sRec, 0), _RecordField(sRec, 1), nFacing);
        string sTile = SnapshotTile(oArea, iOriginCol + FloatToInt(vOff.x), iOriginRow + FloatToInt(vOff.y));
        if (sTile == "") continue;
        if (sOut == "") sOut = sTile;
        else            sOut = sOut + TILE_RECORD_SEP + sTile;
    }
    return sOut;
}

// Restore tiles previously captured by SnapshotTile/SnapshotFootprint.
int RestoreTileSnapshot(object oArea, string sSnapshot, int bReloadGrass = FALSE, int bReloadBorder = FALSE)
{
    return ApplyTileFootprint(oArea, 0, 0, 0, sSnapshot, bReloadGrass, bReloadBorder);
}

////////////////////////////////////////////////////////////////////////////////
// Private helpers
////////////////////////////////////////////////////////////////////////////////

// Clamp any integer to a 0-3 tile facing/orientation step (handles negatives).
int _NormalizeFacing(int nFacing)
{
    nFacing = nFacing % 4;
    if (nFacing < 0) nFacing += 4;
    return nFacing;
}

// Rotate a tile's own orientation by the group facing (both 0-3, CCW).
int _RotateOrientationStep(int nOrientation, int nFacing)
{
    return _NormalizeFacing(nOrientation + nFacing);
}

// Rotate an (col,row) offset about the origin by nFacing steps of 90 deg CCW.
// Standard CCW rotation (x,y)->(-y,x) per step; result packed in .x/.y.
vector _RotateOffset(int iOffsetCol, int iOffsetRow, int nFacing)
{
    int iCol; int iRow;
    switch (_NormalizeFacing(nFacing))
    {
        case 1:  iCol = -iOffsetRow; iRow =  iOffsetCol; break; //  90
        case 2:  iCol = -iOffsetCol; iRow = -iOffsetRow; break; // 180
        case 3:  iCol =  iOffsetRow; iRow = -iOffsetCol; break; // 270
        default: iCol =  iOffsetCol; iRow =  iOffsetRow; break; //   0
    }
    return Vector(IntToFloat(iCol), IntToFloat(iRow), 0.0);
}

// Return the iIndex-th (0-based) tile record from a footprint string.
string _GetFootprintRecord(string sFootprint, int iIndex)
{
    int i;
    for (i = 0; i < iIndex; i++)
    {
        int iPos = FindSubString(sFootprint, TILE_RECORD_SEP);
        if (iPos == -1) return "";
        sFootprint = GetStringRight(sFootprint, GetStringLength(sFootprint) - iPos - 1);
    }
    int iEnd = FindSubString(sFootprint, TILE_RECORD_SEP);
    if (iEnd != -1) sFootprint = GetStringLeft(sFootprint, iEnd);
    return sFootprint;
}

// Return the iField-th (0-based) comma-separated field of a tile record as int.
// Fields: 0=col/dCol 1=row/dRow 2=tileID 3=orientation 4=height.
int _RecordField(string sRecord, int iField)
{
    // Walk past the preceding fields.
    int i;
    for (i = 0; i < iField; i++)
    {
        int iPos = FindSubString(sRecord, TILE_FIELD_SEP);
        if (iPos == -1) return 0;
        sRecord = GetStringRight(sRecord, GetStringLength(sRecord) - iPos - 1);
    }
    // The wanted field is now at the front; strip any trailing fields.
    int iEnd = FindSubString(sRecord, TILE_FIELD_SEP);
    if (iEnd != -1) sRecord = GetStringLeft(sRecord, iEnd);
    return StringToInt(sRecord);
}
