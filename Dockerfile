# Speedtest Tracker for Railway
# Upstream: https://github.com/alexjustesen/speedtest-tracker
# Image: LinuxServer.io build, the one the official docs use.
FROM lscr.io/linuxserver/speedtest-tracker:v1.15.1-ls181@sha256:b7833e43bcf53859efd08605a48740a5cfa741916019373e4dbe730fc59bedf0

# Fixed settings. Every one can be overridden with a service variable.
# SQLite lives in /config (mount a volume there).
ENV DB_CONNECTION=sqlite \
    APP_NAME="Speedtest Tracker" \
    ADMIN_NAME=Admin

# nginx in the image listens on 80 (and 443 with a self-signed cert).
# Railway's domain and health check use port 80 via the PORT variable.
EXPOSE 80

# The image's own s6-overlay entrypoint (/init) starts nginx, PHP-FPM,
# the queue worker and the scheduler.
ENTRYPOINT ["/init"]
