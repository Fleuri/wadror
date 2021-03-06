source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'simplecov', :require => false
  gem 'webmock'
  gem 'rspec-rails', '~> 2.0'
  gem 'selenium-webdriver'
  gem 'database_cleaner', '< 1.1.0'
end

group :production do
  gem 'pg'
  gem 'rails_stdout_logging'
end
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'debugger', :group => :development

gem 'bcrypt-ruby', '~> 3.0.0'

gem 'httparty'

gem "rails-settings-cached", "0.2.4"

=begin
gem 'therubyracer', :platform => :ruby
gem 'less-rails'
gem 'twitter-bootstrap-rails'
=end

gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
