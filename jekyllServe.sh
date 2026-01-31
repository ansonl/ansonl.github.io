#!/bin/sh
bundle exec jekyll serve --drafts --host 0.0.0.0 --incremental --profile

#WSL ubuntu
bundle exec jekyll serve --force-polling --livereload --incremental

#WSL ubuntu PROD for google analytics test
JEKYLL_ENV=production bundle exec jekyll serve --force-polling --incremental

JEKYLL_ENV=production bundle exec jekyll serve --force-polling --incremental --limit_posts 5