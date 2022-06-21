# frozen_string_literal: true

begin
  require 'simplecov'
rescue LoadError
  # ignore
else
  SimpleCov.start do
    add_group 'Paylcoity Web Service', 'lib/paylocity_web_service'
    add_group 'Faraday Middleware', 'lib/faraday'
    add_group 'Specs', 'spec'
  end
end


# Set up Rails cache for testing
require 'rails'
Rails.cache = ActiveSupport::Cache.lookup_store(:memory_store)


require File.expand_path('../../lib/paylocity_web_service', __FILE__)

require 'rspec'
require 'pry'
require 'dotenv'
Dotenv.load('.env.test')


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

PaylocityWebService.configure do |config|
  config.client_id = ENV['SANDBOX_PAYLOCITY_CLIENT_ID']
  config.client_secret = ENV['SANDBOX_PAYLOCITY_CLIENT_SECRET']
  config.public_key = ENV['SANDBOX_PAYLOCITY_PUBLIC_KEY']
end
