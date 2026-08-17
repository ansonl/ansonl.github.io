#!/usr/bin/env sh
# Serve exactly what CI publishes, for checking a change before it ships.
# Use jekyllDevServe.sh while writing. Runs unchanged on Linux, on WSL, and on
# Windows from Git Bash. Pass extra flags through:
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
# Do not add --incremental; see jekyllDevServe.sh for why it serves stale
# aggregate pages on this site.

# Polling is needed only when the build runs under WSL against a Windows
# drive, where inotify never fires; see jekyllDevServe.sh for the detail.
if [ -r /proc/version ] && grep -qi microsoft /proc/version; then
  case "$PWD" in
    /mnt/*) set -- --force_polling "$@" ;;
  esac
fi

JEKYLL_ENV=production bundle exec jekyll serve "$@"
