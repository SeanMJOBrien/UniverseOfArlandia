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

## Resolved: map showed no explored areas (2026-09-19, Linux box)

Symptom: after logging in as a registered player (CD key `UP7M73CG`),
the site showed zero discovered tiles even though the characters had
genuinely played.

The suspected cause recorded earlier — a module `Tag` that had drifted
away from `uoa`, orphaning every module-level `pwdata` row — turned out
to be wrong. The confirming query against the live database returns
exactly what the PHP side expects:

```
player  tag   name                val
~       uoa   WebChars_UP7M73CG   qlippoth&1&Therani Foehammer&2&qlippoth&1&...
```

Every module-level row carries `tag='uoa'`, and the live NWNX log shows
the same tag on every write. Neither `_webmap.nss` nor
`www/player_auth.php` needed a change, and no module rebuild was
required. Two environment faults caused the empty map instead.

### 1. The website read a different database than the game server writes

The Linux box runs two MySQL-family servers:

- host MariaDB on `3306` — the live database. `nwserver`
  (`~/uoa/config/nwserver.env`, `NWNX_SQL_HOST=192.168.42.223`) writes
  here, and it holds every `WebChars_` and `WMap_` row.
- the compose `db` container, published on `3307` — a stale copy whose
  newest row was written 2026-06-30, with no `WebChars_` or `WMap_`
  rows at all.

`universeofarlandia_web_1` had been created with `DB_HOST=db`, so the
site read the stale container while the game wrote to MariaDB. The
repo's `.env` already said `DB_HOST=192.168.42.223`, but the running
container predated it.

Fix: `.env` now sets `DB_HOST` and `DB_PORT` explicitly, with a comment
tying them to `nwserver.env`, and the container was recreated to pick
them up. `docker-compose` 1.29.2 fails on this Docker engine with
`KeyError: 'ContainerConfig'` while merging the anonymous
`node_modules` volume; `docker-compose up -d --renew-anon-volumes web`
works around it. The `db` service is now unused by the site — leave it
or remove it, but do not point the site back at it.

### 2. `web_players` was missing from the live database

`docker/mysql-init/*.sql` runs only when the `db` container initializes
an empty volume, so it never touched the host MariaDB. The table was
created there by hand from `docker/mysql-init/02-web-players.sql`.
Any future schema file needs the same manual application.

### Verification

With a session holding `player_cdkey=UP7M73CG`, `app/galaxy.php` renders 32
Arland tiles and 1 Galaxia tile, matching the 32 and 1 `WMap_` entries
in the live database; an anonymous request on the same planets renders
none and shows the login notice.

One behaviour worth knowing, unchanged and intentional: the Space map
still reveals a star system to everyone when field `&004&` of its
`Space<X>_<Y>` row is `1`, so an anonymous visitor sees the charted
systems while planet surfaces stay private.
