source "https://rubygems.org"

gem "rails", "~> 8.0.0"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end
