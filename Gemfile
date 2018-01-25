source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "git@github.com:#{repo_name}.git"
end

# Server
gem 'puma', '~> 3.10.0'

# Rails
gem 'rails', '~> 5.1.4'

# Pipeline
gem 'sprockets-rails', '3.2.1', require: 'sprockets/railtie'
gem 'sprockets', '3.7.1'
gem 'uglifier', '~> 3.2.0'

# View
gem 'haml', '~> 5.0'

# Style
gem 'sass-rails', '~> 5.0'

# Cortex
gem 'cortex', github: 'cbdr/cortex'
gem 'cortex-plugins-core', '~> 3.0'

# Jobs
gem 'sidekiq', '~> 5.0.5'
gem 'sidekiq-failures', '~> 1.0.0'
gem 'sinatra', '~> 2.0.0'

# Data
gem 'pg', '~> 0.21.0'
gem 'redis-rails', '~> 5.0'

# JavaScript
gem 'react_on_rails', '9.0.3'
gem 'mini_racer'
gem 'webpacker'

# API
gem 'apollo-tracing', '~> 1.3.0'

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
  gem 'factory_girl_rails', '~> 4.8' # TODO: upgrade to factory_bot
  gem 'faker', '~> 1.8'
  gem 'phantomjs', '~> 2.1'
  gem 'jasmine-rails', '~> 0.14'

  # Documentation
  gem 'rails-erd'
end

group :development do
  # Debug
  gem 'better_errors'
  gem 'binding_of_caller'

  # Misc
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  # Rspec
  gem 'json_spec', '~> 1.1'
  gem 'rspec-sidekiq', '~> 3.0'
  gem 'shoulda-matchers', '~> 3.1'

  # Coverage
  gem 'simplecov'
  gem 'codeclimate-test-reporter'

  # Capybara for feature testing, Poltergeist for PhantomJS
  gem 'capybara'
  gem 'poltergeist'

  # Mocking/Faking
  gem 'mocha', '~> 1.3', require: false
  gem 'timecop', '~> 0.9'
  gem 'email_spec'

  # Javascript
  gem 'guard-jasmine', '~> 2.1'
  gem 'jasmine-core', '~> 2.8'

  # Data
  gem 'elasticsearch-extensions', '~> 0.0.26'
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm'
  gem 'sentry-raven'

  # Performance
  gem 'bootscale', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
