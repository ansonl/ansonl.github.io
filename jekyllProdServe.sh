#!/usr/bin/env sh
# Serve exactly what CI publishes, for checking a change before it ships.
# Use jekyllDevServe.sh while writing. Pass extra flags through:
#   ./jekyllProdServe.sh --livereload
#   ./jekyllProdServe.sh --host 0.0.0.0     # expose on the LAN
#
# JEKYLL_ENV has to be set explicitly. `jekyll serve` defaults to development,
# and the theme gates its Disqus embed on `jekyll.environment == "production"`,
# so a plain local serve silently drops comments from ~190 pages. That is the
# only output difference: the theme's other production gate is Google
# Analytics, which _config.yml leaves unset, and sass.style is pinned to
# compressed so the CSS no longer depends on the environment either.
#
# Deliberately no --drafts/--unpublished, which is the whole point of having
# this split from jekyllDevServe.sh -- what renders here is what ships.
#
# --force_polling is required because the repo sits on /mnt/c, which WSL2
# mounts as v9fs, and v9fs delivers no inotify events. Without it the watcher
# starts, prints "Auto-regeneration: enabled", and then never fires for the
# rest of the session. Drop it if the build ever stops reaching across the
# WSL/Windows boundary; see jekyllDevServe.sh for the timings.
#
# Do not add --incremental; see jekyllDevServe.sh for why it serves stale
# aggregate pages on this site.
JEKYLL_ENV=production bundle exec jekyll serve --force_polling "$@"
