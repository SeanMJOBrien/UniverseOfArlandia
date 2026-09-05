# Cluster Areas — old branch vs. shipped feature

Comparison of the `cluster-areas` branch (commits `47d0218`, `87c90a6`, `01c7a67`,
2026-07-01) against the DM cluster-area builder actually shipped on `main` today
(landed in `ce82010`, 2026-07-21, and documented in `docs/DM_WORLD_BUILDER_GUIDE.md`).
Written because a merge of `fix/horse-mount-pheno`/`player-dashboard` (both stacked on
top of `cluster-areas`) produced real conflicts in `area_transition.nss`,
`mod_enter.nss`, and `_string_utils.nss` — this document is the record of why
`cluster-areas` was excluded rather than resolved, and what (if anything) is worth
salvaging from it.

## Verdict

**Don't merge `cluster-areas`.** It's an earlier, independently-built implementation
of the same feature — "let a world coordinate resolve to a group of static, hand-built
areas" — that was later replaced wholesale by a different design. It predates the
shipped system by three weeks and was never wired into anything the shipped system
uses. Merging it now would add a second, dead DM menu path and a set of scripts that
don't talk to the cluster system actually in use.

## Side-by-side

| | `cluster-areas` branch (old) | Shipped on `main` (`dmb_inc.nss` etc.) |
|---|---|---|
| **DM entry point** | `dm.dlg.json` conversation — "Which option ?" → "Mark cluster coordinate." / "Register cluster area..." | In-game chat commands — `.wcluster`, `.warea`, `.wjump`, `.winfo` (`mod_chat.nss`) |
| **Registration flow** | Two-step, two-location: stand on the *target coordinate* to mark it pending (`conv_dm045.nss`), then walk to the *entry area* and register it into a slot (`conv_dm046.nss`) | One window (`.wcluster`), stays open across area changes — walk into each member area and click "Set to my area" per direction, then Save |
| **Slots** | 5: **Default**, North, South, East, West — Default is a required fallback used when a direction slot is blank | 4: North, East, South, West only — no dedicated fallback slot; unmapped direction blocks with "There is no exit this way," and direction-less arrivals use the first mapped direction in N/E/S/W order (`DmbFirstMappedDir`) |
| **Border crossing** | Manually placed trigger per outer edge, each needing an `OnEnter` script (`cluster_exit.nss`) plus two hand-set locals (`ClusterPlanet`, `ClusterArea`) | No per-area trigger setup — `area_transition.nss`'s existing edge-trigger dispatch checks `IsClusterMember`/`DmbClusterDirTag` generically; a member only needs its own internal doors |
| **pwdata key** | `<Planet>&<X_Y>&Cluster` | `<Planet>&<X_Y>&Cluster` (**same key**, see Collision below) |
| **pwdata value encoding** | `<DefaultTag>&001&<NorthTag>&002&<SouthTag>&003&<EastTag>&004&<WestTag>&005&` (`EncodedField`, 3-digit `&00N&` delimiters, 5 fields) | `<NorthTag>&1&<EastTag>&2&<SouthTag>&3&<WestTag>&4&` (`Between()`, 1-digit `&N&` delimiters, 4 fields) |
| **Coordinate math** | Refactored into a new shared helper, `AdvanceCoordAxis()` in `_string_utils.nss`, replacing 8 duplicated inline wrap-boundary ternary chains in `area_transition.nss` | Inline math left as-is in `area_transition.nss`; `dmb_inc.nss` has its own `DmbParseAxis`/`DmbParseCoord`/`DmbCoordString`/`DmbCoordInBounds` for the builder tool's own needs |
| **Entry point inside a member area** | Whatever spot the internal doors happen to leave you at | Optional `CLU_ENTRY_NORTH`/`_EAST`/`_SOUTH`/`_WEST`-tagged waypoint per member, else default edge position (`DmbEntryWaypoint`) |
| **Rebuild on reboot** | Not addressed in the branch — no boot-time restore script | `dmb_cluster_boot.nss`, run from `mod_load.nss`: rebuilds every member area's `Planet`/`Area`/`IsClusterMember` locals from the persisted `ClusterTot`/`Cluster<n>` index every boot |
| **Creature persistence** | Explicitly out of scope (see the branch's own `CLUSTER_AREAS.md` "Limitations") | Built later, this session: `dmb_clucre_inc/boot/save.nss` — Creator-tool creatures with `Persistent=1` survive restarts |
| **Docs** | `CLUSTER_AREAS.md` (repo root, uncommitted to `main`) | `docs/DM_WORLD_BUILDER_GUIDE.md` |
| **New files** | `cluster_exit.nss`, `conv_dm045.nss`, `conv_dm046.nss`, `CLUSTER_AREAS.md` | `dmb_inc.nss`, `dmb_cluster_boot.nss`, `dmb_clucre_*.nss`, `dmb_nui_inc.nss`, `dmb_nui_event.nss`, `dmb_galaxy_db.nss`, `mod_chat.nss` |

## Collision risk if ever revived

The two systems picked the **exact same pwdata key** (`<Planet>&<X_Y>&Cluster`) for
completely different, mutually unparsable value encodings — `EncodedField`'s 3-digit
`&00N&` delimiters vs. `Between()`'s 1-digit `&N&` delimiters, 5 fields vs. 4, and a
different field order (old: Default/N/S/E/W; new: N/E/S/W). If `cluster-areas`' code
were ever reactivated against a database that already has clusters registered through
the shipped `.wcluster` tool (or vice versa), each system would silently misparse the
other's records rather than erroring — `EncodedField`/`Between` degrade to empty-string
reads on a format mismatch, not a crash, so a "cluster" would resolve to a garbled or
blank set of directions instead of failing loudly. Any future revival of ideas from the
old branch must use a different key, not reuse `Cluster`.

## What's worth salvaging

- **`AdvanceCoordAxis()`** — a real, tested dedup of the coordinate-wrap-at-boundary
  logic that's still duplicated 8 times inline in the shipped `area_transition.nss`.
  Reasonable follow-up cleanup, independent of anything cluster-related.
- **Default-slot fallback concept** — the shipped system's "first mapped direction
  wins" fallback (`DmbFirstMappedDir`) is arguably weaker than an explicit Default
  slot for direction-less arrivals (`.wjump`, recall, airship). Worth considering as a
  small addition to `dmb_inc.nss`'s record format if direction-less-arrival placement
  becomes a real pain point — but as a new, additively-encoded field, not a port of
  the old 5-slot format.

Everything else — `cluster_exit.nss`, `conv_dm045.nss`, `conv_dm046.nss`,
`CLUSTER_AREAS.md`, the `dm.dlg.json` menu additions — duplicates functionality the
shipped `.w`-command system already covers more completely (reboot survival, creature
persistence, per-member entry waypoints, no manual trigger placement) and should be
left on the abandoned branch rather than merged.

## Recommendation for the branch itself

`cluster-areas`, `player-dashboard`, and `fix/horse-mount-pheno` are stacked
(`cluster-areas` ⊂ `player-dashboard` ⊂ `fix/horse-mount-pheno`). The four commits
with independent value (`1068b77` last-login tracking, `0f6987e` DM-gate the
`playerInfo.php` reset action, `838e847` bank-account plan doc, `2048f2c` horse-mount
phenotype fix) have been cherry-picked onto `main` directly, bypassing the superseded
base. The three original branches can be deleted once you've confirmed nothing else in
them is wanted — their commits are preserved in branch history until then.
