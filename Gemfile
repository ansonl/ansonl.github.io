source "https://rubygems.org"

# Jekyll 4 is NOT what GitHub's managed Pages builder runs (it is pinned to
# 3.10.0 via the github-pages gem). This site builds itself in GitHub Actions
# and uploads the result, so the version is ours to choose.
gem "jekyll", "~> 4.4"

gem "jekyll-remote-theme"
gem "jekyll-feed"
gem "jekyll-seo-tag"
gem "jekyll-sitemap"
gem "jekyll-paginate"
gem "jekyll-gist"
gem "webrick", "~> 1.8"

# Pinned to the 1.x line on purpose. The upstream theme's SCSS uses lighten(),
# darken() and slash division, which Dart Sass deprecates and Dart Sass 2 will
# reject outright -- and the theme has been unmaintained since 2021, so nobody
# is going to fix it. Without this pin, a sass-embedded 2.0 release would break
# the deploy unattended. Roughly 247 deprecation warnings are silenced by
# sass.quiet_deps; all of them originate upstream, none in this repo's own SCSS.
gem "sass-embedded", "~> 1.0"
