source "https://rubygems.org"

ruby "3.4.4"

gem "rails", "~> 8.1.3"
gem "propshaft"
gem "puma", ">= 6.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "sqlite3", ">= 2.1"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
end

group :production do
  gem "pg"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
