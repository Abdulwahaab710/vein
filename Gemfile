# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '>= 6.0'
gem 'rails-i18n'
gem 'redis', '~> 4.0'
gem 'sass-rails'
gem 'sidekiq'
gem 'turbolinks'
gem 'twilio-ruby', '~> 5.22.1'
gem 'uglifier', '>= 1.3.0'
gem 'uikit-rails'

group :development, :test do
  gem 'brakeman'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end

group :test do
  gem 'codecov', require: false
end
