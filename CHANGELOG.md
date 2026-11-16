# Changelog

## Unreleased (2026-11-16)

- README: add the Deploy on Railway button for the published template `speedtest-tracker-1`. No change to the app or its image.

## 1.15.1 (2026-11-16)

- First release: Speedtest Tracker v1.15.1 (`lscr.io/linuxserver/speedtest-tracker:v1.15.1-ls181`, pinned by digest), SQLite on a `/config` volume, generated `APP_KEY` and admin password, health check on `/api/healthcheck`, `FORCE_HTTPS=true` and an `ASSET_URL` variable so every link uses https behind Railway's proxy.
