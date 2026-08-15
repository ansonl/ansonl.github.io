#!/usr/bin/env sh
# Local preview. Pass extra flags through, e.g.
#   ./jekyllServe.sh --drafts --livereload
#   ./jekyllServe.sh --host 0.0.0.0        # expose on the LAN
#
# Do not add --incremental: Jekyll only records include dependencies while it
# is on, and resets them per regenerated file, so it serves stale HTML.
bundle exec jekyll serve "$@"
