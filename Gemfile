# frozen_string_literal: true
source "https://rubygems.org"

# All dependencies from the gemspec and Gemfile will be installed by `bundle install`.
# https://bundler.io/rubygems.html#using-bundler-while-developing-a-gem
gemspec

# The following gems are required for local development and will not be included by `gem install mygem` or `bundle add mygem`.
group :development, :test do
  gem 'awesome_print', require: 'ap'
  gem 'pry'
  gem 'rubocop'
  gem 'rake'
  gem 'bundler'
  gem "rspec", "~> 3.0"
  gem 'webmock', '~> 3.8', '>= 3.8.2'
end
