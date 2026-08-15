#!/bin/sh
# Local development server.
#
# --incremental is deliberately NOT used. It is currently a no-op for HTML
# anyway: every page's dependency list contains theme files under a per-build
# Dir.mktmpdir path that no longer exists on the next run, so every dependent
# page is force-regenerated regardless. Once the theme is vendored those paths
# become stable and incremental starts genuinely skipping pages - at which
# point Jekyll's Regenerator records include dependencies only while
# incremental is active and resets them per regenerated file, which produces
# stale HTML. Full builds are ~50s; take the 50s.
#
# --limit_posts is also unusable here: _store/0-toyota-corolla-cross-hybrid-
# spare-wheel-holder.md uses {% post_url 2024-05-23-... %}, and post_url raises
# a build error rather than degrading when its target is excluded.

bundle exec jekyll serve --drafts --host 0.0.0.0 --profile

# Variants (run one of these instead of the line above):
#
# WSL, with live reload:
#   bundle exec jekyll serve --force-polling --livereload
#
# Production environment - matches what actually deploys. Notably pages-gem
# only forces `sass: style: compressed` when JEKYLL_ENV=production, though
# _config.yml now pins that explicitly so dev and prod CSS agree either way:
#   JEKYLL_ENV=production bundle exec jekyll serve --force-polling
#
# One-off clean build into a scratch dir, for diffing against a baseline:
#   rm -rf .jekyll-cache .jekyll-metadata
#   JEKYLL_ENV=production bundle exec jekyll build -d /tmp/jekyll-check
