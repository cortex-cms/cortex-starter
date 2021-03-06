source 'https://rubygems.org'
ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "git@github.com:#{repo_name}.git"
end

# Server
gem 'puma', '~> 3.12.0'

# Rails
gem 'rails', '~> 5.1.6'

# Pipeline
gem 'sprockets-rails', '3.2.1', require: 'sprockets/railtie'
gem 'sprockets', '3.7.2'
gem 'uglifier', '~> 3.2.0'

# View
gem 'haml', '~> 5.0'

# Style
gem 'sass-rails', '~> 5.0'

# Cortex
gem 'cortex', '~> 0.1'
gem 'cortex-plugins-core', '~> 3.2'

# Jobs
gem 'sidekiq', '~> 5.1.3'
gem 'sidekiq-failures', '~> 1.0.0'
gem 'sinatra', '~> 2.0.3'

# Data
gem 'pg', '>= 0.18', '< 2.0'
gem 'redis-rails', '~> 5.0'

# JavaScript
gem 'react_on_rails', '9.0.3'
gem 'mini_racer'
gem 'webpacker', '3.2.2'

# API
gem 'apollo-tracing', '~> 1.6.0'

group :development, :test do
  # Environment
  gem 'dotenv-rails', require: 'dotenv/rails-now'

  # Cache/Sidekiq
  gem 'redis-namespace'

  # Debug
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-remote'
  gem 'pry-stack_explorer'

  # Specs/Helpers
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.10'
  gem 'faker', '~> 1.9'
  gem 'phantomjs', '~> 2.1'
  gem 'jasmine-rails', '~> 0.14'

  # Documentation
  gem 'rails-erd'
end

group :development do
  # Debug
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rack-mini-profiler'

  # Misc
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  # Rspec
  gem 'json_spec', '~> 1.1'
  gem 'shoulda-matchers', '~> 3.1'
  gem "rspec_junit_formatter"

  # Coverage
  gem 'simplecov', require: false

  # Capybara for feature testing, Poltergeist for PhantomJS
  gem 'capybara'
  gem 'poltergeist'

  # Mocking/Faking
  gem 'mocha', '~> 1.7', require: false
  gem 'timecop', '~> 0.9'
  gem 'email_spec'

  # Javascript
  gem 'guard-jasmine', '~> 2.1'
  gem 'jasmine-core', '~> 2.99'

  # Data
  gem 'elasticsearch-extensions', '~> 0.0.30'
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm'
  gem 'sentry-raven'

  # Performance
  gem 'bootsnap', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
