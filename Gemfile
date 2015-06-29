# -*- coding: utf-8 -*-
source 'https://rubygems.org'
ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass'
gem 'coffee-rails'

# Needed for default layouts
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'underscore-rails'

gem 'devise'
gem 'haml-rails'
gem 'cancan'

gem 'quiet_assets'
gem 'dotenv'

# Admin Interface
gem 'rails_admin'

group :production do
  gem 'rails_12factor'
  gem 'pg'  
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'thin'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
end

#testing with minitest
group :test do
  gem 'selenium-webdriver'
  gem 'mocha'
  gem 'simplecov'
  gem 'webmock'
  gem 'minitest-spec-rails'
  gem 'minitest-rails-capybara'
  gem 'capybara-webkit'
end

# Sphinx - versions as of 09/14, http://pat.github.io/thinking-sphinx/installing_thinking_sphinx/ts3.html
gem 'mysql2', :platform => :ruby
gem 'thinking-sphinx', '~> 3.1.0'
