# Deploying the website

Only `www/public/` is served. Everything else in the repo (tests, docs, `node_modules`,
the NWScript sources) stays outside the web root.

## One-time setup on the web server

1. Clone the repo somewhere that is **not** under the web root, e.g. `/srv/uoa`
   (`git clone git@github.com:SeanMJOBrien/UniverseOfArlandia.git /srv/uoa`; a read-only
   deploy key is enough).
2. Point the web server at the `public` folder, either by setting `DocumentRoot` to
   `/srv/uoa/www/public` or by symlinking: `ln -s /srv/uoa/www/public /var/www/html`
   (Apache needs `Options FollowSymLinks`).
3. Create the real config **outside the clone and the web root**:
   `sudo mkdir -p /etc/uoa && sudo cp /srv/uoa/docs/uoa.local.php.example /etc/uoa/uoa.local.php`,
   then edit it: database login, and `$dmlogin` as a bcrypt hash
   (`php -r 'echo password_hash("YourPassword", PASSWORD_DEFAULT), "\n";'`, keep the
   single quotes around the hash). `chmod 640` it, group = the web server user.
   If you cannot write to `/etc`, use `/srv/uoa/www/public/app/uoa.local.php` instead
   (git-ignored) or set `UOA_CONFIG` to any path.
4. Copy `planetCreator.php` (it is git-ignored) to `/srv/uoa/www/public/app/`.
5. Remove the old copies of the site from the previous web root, so nothing stale is served.
6. If the DM page "Inactive accounts" is used, the web server user needs read (and, for removal,
   write) access to the server vault folder (`UOA_VAULT`, default `/home/qlippoth/uoa/server/servervault`).

## Each update

```
/srv/uoa/tools/deploy_web.sh
```

It fast-forwards `main`, then checks every PHP file for syntax errors. Nothing else on the
server changes: the config lives outside the clone, and `git pull` never touches it.

## Notes

- Old addresses at the root (`/galaxy.php`, ...) no longer exist; pages are under `/app/`.
- The wikis and maps (`chronicles-wiki`, `tfn-wiki`, `hos1-wiki`, `erithorn-map`) are not in git.
  In Docker they are mapped by `Alias` lines in `docker/apache-uoa.conf`. On another server,
  put them anywhere and alias them the same way (or copy them into `www/public/`).
- Rotate the database password if it has ever appeared in a log or chat.
