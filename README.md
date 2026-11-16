# Speedtest Tracker on Railway

This repo packages [Speedtest Tracker](https://github.com/alexjustesen/speedtest-tracker) for Railway. Speedtest Tracker runs Ookla speed tests on a schedule or on demand and keeps the history, charts and alerts in a web dashboard.

## What the template deploys

- **Speedtest Tracker v1.15.1**, built from this repo's `Dockerfile`, which pins the LinuxServer.io image the upstream docs use: `lscr.io/linuxserver/speedtest-tracker:v1.15.1-ls181@sha256:b7833e43bcf53859efd08605a48740a5cfa741916019373e4dbe730fc59bedf0`.
- One service with a volume at `/config` for the SQLite database, logs and keys. No separate database is needed.
- A public Railway domain on port 80, with the health check on `/api/healthcheck`.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `ADMIN_EMAIL` | (you enter it) | Email of the first admin account. Used only on the first start |
| `ADMIN_PASSWORD` | `${{secret(24)}}` | Password of the first admin account, generated at deploy. Read it in the service's Variables tab, then change it in the app's profile page. Used only on the first start |
| `APP_KEY` | `${{secret(32)}}` | Laravel encryption key. Keep it: changing it makes stored secrets unreadable |
| `APP_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Public URL used in links and notifications |
| `ASSET_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Base URL for static files, so they load over https behind Railway's proxy |
| `PORT` | `80` | Port the app listens on, used by Railway's domain and health check |

The `Dockerfile` also sets `DB_CONNECTION=sqlite`, `FORCE_HTTPS=true`, `APP_NAME` and `ADMIN_NAME`. Every setting in the [environment variable list](https://docs.speedtest-tracker.dev/getting-started/environment-variables) can be added as a service variable, for example:

- `SPEEDTEST_SCHEDULE`: a cron expression for automatic tests, such as `0 */6 * * *` (every 6 hours). Without it, tests only run when you start them from the dashboard.
- `PRUNE_RESULTS_OLDER_THAN`: delete results older than this many days.
- `DISPLAY_TIMEZONE`, `PUBLIC_DASHBOARD`, `SPEEDTEST_SERVERS`.

**Note on what it measures.** On Railway, the tests measure the internet connection of the Railway server the app runs on, not your home connection. Railway's network is fast (a test from this template measured 7.7 Gbps down and 2.5 Gbps up), so one test can upload gigabytes, and Railway bills outbound traffic. Pick a modest schedule.

## Updates

Railway tells everyone who deployed this template when a change is merged to `main` here, and each deployer chooses when to apply it. Updates bump the pinned image in the `Dockerfile`; see [CHANGELOG.md](CHANGELOG.md) before applying one. Your data stays on the `/config` volume.

## License

The wrapper in this repo is MIT. Speedtest Tracker is MIT licensed by its authors; the image is built by LinuxServer.io.
