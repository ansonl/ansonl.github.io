#!/usr/bin/env sh
# Production build -- the same command CI publishes with. Pass extra flags
# through, e.g.
#   ./jekyllBuild.sh --profile              # per-template render timings
#   ./jekyllBuild.sh -d /tmp/site-check     # build somewhere other than _site
#
# JEKYLL_ENV has to be set explicitly. `jekyll build` defaults to development,
# and the theme gates its Disqus embed on `jekyll.environment == "production"`,
# so a plain local build silently drops comments from ~200 pages. That is the
# only output difference: the theme's other production gate is Google
# Analytics, which _config.yml leaves unset, and sass.style is pinned to
# compressed so the CSS no longer depends on the environment either.
#
# Deliberately no --drafts/--unpublished. jekyllDevServe.sh carries those for
# previewing, and they must never reach output that could be published.
#
# Keep this in step with .github/workflows/pages.yml, which runs the same
# command; local output should stay diffable against what Actions uploads.
JEKYLL_ENV=production bundle exec jekyll build "$@"
