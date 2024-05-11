#!/bin/sh
bundle exec jekyll serve --drafts --host 0.0.0.0 --incremental --profile

#WSL ubuntu
bundle exec jekyll serve --force-polling --livereload