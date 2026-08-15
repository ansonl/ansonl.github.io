source "https://rubygems.org"

gem "github-pages", group: :jekyll_plugins
gem "jekyll-remote-theme"
gem "jekyll-feed"
gem "jekyll-seo-tag"
gem "jekyll-sitemap"
gem "jekyll-paginate"
gem "jekyll-avatar"
gem "jekyll-gist"
gem "webrick", "~> 1.8"

# Ruby 3.3 ships logger 1.6, which added @level_override to Logger#level.
# Jekyll 3.9.3's LogAdapter builds its writer without Logger#initialize
# running, so that ivar is nil and every command dies in adjust_verbosity:
#   logger.rb:384:in `level': undefined method `[]' for nil
# Pin logger back until Jekyll 4 lands, which fixed this upstream.
gem "logger", "~> 1.5.3"
