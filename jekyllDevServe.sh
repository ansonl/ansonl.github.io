#!/usr/bin/env sh
# Local preview for writing, with everything a draft loop needs already on.
# Use jekyllProdServe.sh to see what actually ships. Runs unchanged on Linux,
# on WSL, and on Windows from Git Bash. Pass extra flags through:
#   ./jekyllDevServe.sh --livereload
#   ./jekyllDevServe.sh --host 0.0.0.0      # expose on the LAN
#
# --drafts on its own renders only the drafts without `published: false` in
# their front matter, which silently hides two of the four in _drafts, so
# --unpublished is needed to preview those. Neither flag has a --no- variant
# (only --watch does), so this script is preview-only: never build a deploy
# with it. CI runs a plain `bundle exec jekyll build`, which stays unaffected.
#
# Do not add --incremental. On Jekyll 4.4 include and layout dependencies do
# propagate (both were verified rebuilding every dependent page), but tags.md,
# archive.md and the lunr index run their own loops over site.tags/site.posts,
# and Jekyll has no dependency to track for those. They silently keep serving
# the previous build's content while individual posts update around them, and
# a --config change updates nothing at all. There is no speed argument either:
# a warm full rebuild measured 1.7s against incremental's 1.6s.

# A build running under WSL against a Windows drive receives no inotify events
# at all -- the watcher starts, prints "Auto-regeneration: enabled", and then
# never fires for the rest of the session. Polling is the only way to watch
# there, and it is pure overhead everywhere else, so it is enabled for exactly
# that case: WSL (microsoft in /proc/version) with the repo under /mnt. Native
# Windows watches through wdm, and Linux and WSL on their own filesystem watch
# natively. Detection means moving the repo needs no edit here.
if [ -r /proc/version ] && grep -qi microsoft /proc/version; then
  case "$PWD" in
    /mnt/*) set -- --force_polling "$@" ;;
  esac
fi

bundle exec jekyll serve --drafts --unpublished "$@"
