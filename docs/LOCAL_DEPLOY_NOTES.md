# Local deployment notes (2026-09-19)

Setting up the private, non-broadcasting local instance on Sean's Mac
(`seans-macbook-pro-local`). Two separate docker-compose projects:

- `~/Documents/GitHub/UniverseOfArlandia` — website + MySQL (`db`, `web`)
- `~/Downloads/uoa` — NWN game server (`nwserver`), a checkout of
  `urothis/nwnxee-docker-template`, carried over from the old Linux box

## Fixed

1. **Hak folder name mismatch** (`~/Downloads/uoa`). `docker-compose.yml`
   mounts `server/hak` into the container; the actual files were in
   `server/haks` (plural). Docker would have silently created an empty
   `hak` dir and the server would have started with zero haks loaded.
   Renamed `server/haks` -> `server/hak`.

2. **Dead SQL host** (`~/Downloads/uoa/config/nwserver.env`).
   `NWNX_SQL_HOST` pointed at `192.168.42.223`, the old box's LAN IP,
   unreachable from this Mac. Repointed at
   `host.docker.internal:3307` (via `NWNX_SQL_PORT`), which reaches the
   website stack's own MySQL container — one database for both the site
   and the game server, matching credentials already lined up
   (`uoa`/`uoa`).

3. **Unused/broken `db` service** (`~/Downloads/uoa/docker-compose.yml`).
   Postgres image with a MySQL volume path, nothing pointed at it since
   fix #2. Commented out.

4. **arm64 image pull failure**. `nwnxee/unified:09544eb` was only ever
   published for `linux/amd64`. Added `platform: linux/amd64` to the
   `nwserver` service so Docker Desktop runs it under emulation on
   Apple Silicon.

5. **Stale `db_data` volume**. First `docker compose up` on the website
   stack mounted a MySQL volume that predated the finalized `.env`
   values, so the `uoa` user's password didn't match. Wiped the volume
   (`docker volume rm universeofarlandia_db_data`) so MySQL
   re-initialized from current `.env`.

6. **`DM_PASSWORD_HASH` `$` interpolation**. Compose treats `$` in `.env`
   values as variable interpolation; a raw bcrypt hash needs every `$`
   doubled (`$$`) to come through literally.

7. **DM login form had no real submit button** (`www/index.php`). Only a
   `<noscript>`-wrapped one existed, relying on implicit Enter-to-submit,
   which doesn't reliably fire (confirmed live via browser automation: no
   POST was even sent). Added a normal visible submit button, matching
   the player-login form beside it. Committed
   (`f491eca`).

8. **Missing `web_players` table**. `player_auth.php` has referenced this
   table since it was written, but the migration that creates it
   (`docker/mysql-init/02-web-players.sql`) was never actually committed
   — `.gitignore`'s blanket `*.sql` rule silently caught it, so every
   fresh install hit a fatal `mysqli_stmt_bind_param()` error the moment
   a player tried to log in. Added the migration, carved out a
   `.gitignore` exception for `docker/mysql-init/*.sql` (schema source,
   not a dump/credential), and applied it to the live DB by hand.
   Committed (`f491eca`).

## Open: map shows no explored areas despite live gameplay

Symptom: after logging in as a registered player (CD key `UP7M73CG`),
the site shows zero discovered tiles, even though the character has
genuinely played (`pwdata` has live `WMap_Arland_X0` / `WMap_Arland_X1`
rows, written correctly by NWNX during this session).

Root cause (suspected, not yet confirmed): `player_characters()` in
`www/player_auth.php` needs a `WebChars_<cdkey>` row
(`player='~', tag='uoa'`) to map a CD key to its characters; without it,
`player_discovered_tiles()` returns nothing regardless of `WMap_` data.

`_webmap.nss`'s header comment claims module-level rows (`WebChars_`,
`WebCode_`, and by extension `Galaxy`) are stored as `player='~',
tag='uoa'` — but the actual write path
(`aps_include.nss::SetPersistentString`) uses `tag=GetTag(oObject)` for
non-PC objects, i.e. whatever the *live deployed module's* `Tag`
property actually is, not a hardcoded string. `src/ifo/module.ifo.json`
does say `Mod_Tag: 'uoa'`, but `build_deploy.sh` deliberately never
syncs `module.ifo` into the deployed `.mod` (its own comments: doing so
would revert live-only area state) — so if the live module's tag ever
drifted from `uoa` on the old server, every module-level write since
lands under a different `tag`, invisible to every PHP query here
(`www/player_auth.php`, `www/index.php`) that hardcodes `tag='uoa'`.
`WMap_` rows are unaffected because they're keyed by character name,
not module tag.

**Plan, once confirmed** (`SELECT player, tag, name FROM pwdata WHERE
name LIKE 'WebChars%'` against the live DB — pending):

1. If the live module's tag differs from `uoa`: patch the *deployed*
   `.mod`'s `module.ifo` directly (extract with `nwn_gff`, fix
   `Mod_Tag`, repack) rather than rebuilding from `src/`, since a full
   rebuild would need the NWScript build toolchain
   (`nwnsc`/`nasher`/`nwn_erf`/`nwn_gff`) that isn't set up on this Mac
   yet — `build_deploy.sh` here still has the old box's hardcoded
   `/home/qlippoth/...` paths.
2. Alternatively (lower-risk, no module rebuild): change the PHP side
   to read whatever tag the module is actually using instead of a
   hardcoded `'uoa'` literal — but that only helps future writes; any
   `WebChars_`/`WebCode_` rows already written under the wrong tag are
   still orphaned and would need a manual `UPDATE pwdata SET
   tag='uoa' WHERE ...` cleanup.
3. Either way: setting up the NWScript build toolchain on this Mac is
   its own follow-up (see the earlier machine-portability review) and
   becomes necessary the moment any script fix, including this one,
   needs to ship as a rebuilt module rather than a live DB patch.
