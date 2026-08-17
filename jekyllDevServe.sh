#!/usr/bin/env sh
# Local preview for writing, with everything a draft loop needs already on.
# Use jekyllProdServe.sh to see what actually ships. Pass extra flags through:
#   ./jekyllDevServe.sh --livereload
#   ./jekyllDevServe.sh --host 0.0.0.0      # expose on the LAN
#
# --drafts on its own renders only the drafts without `published: false` in
# their front matter, which silently hides two of the four in _drafts, so
# --unpublished is needed to preview those. Neither flag has a --no- variant
# (only --watch does), so this script is preview-only: never build a deploy
# with it. CI runs a plain `bundle exec jekyll build`, which stays unaffected.
#
# --force_polling is required because the repo sits on /mnt/c, which WSL2
# mounts as v9fs, and v9fs delivers no inotify events. Without it the watcher
# starts, prints "Auto-regeneration: enabled", and then never fires for the
# rest of the session. Polling takes ~8s to notice a change and the rebuild
# behind it ~35s. Drop this flag if the build ever stops reaching across the
# WSL/Windows boundary -- either repo on the WSL filesystem, where a
# regeneration takes about 3s, or Jekyll running natively on Windows with wdm.
#
# Do not add --incremental. On Jekyll 4.4 include and layout dependencies do
# propagate (both were verified rebuilding every dependent page), but tags.md,
# archive.md and the lunr index run their own loops over site.tags/site.posts,
# and Jekyll has no dependency to track for those. They silently keep serving
# the previous build's content while individual posts update around them, and
# a --config change updates nothing at all. There is no speed argument either:
# a warm full rebuild measured 1.7s against incremental's 1.6s.
bundle exec jekyll serve --drafts --unpublished --force_polling "$@"
