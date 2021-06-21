require 'paylocity_web_service/connection'
require 'paylocity_web_service/authentication'
require 'paylocity_web_service/configuration'
require 'paylocity_web_service/error'
require 'paylocity_web_service/client/companies'
require 'paylocity_web_service/client/employees'
require 'paylocity_web_service/client/credentials'

module PaylocityWebService
  class Client
    include PaylocityWebService::Authentication
    include PaylocityWebService::Configuration
    include PaylocityWebService::Connection
    include PaylocityWebService::Encryption
    include PaylocityWebService::Client::Employees
    include PaylocityWebService::Client::Companies
    include PaylocityWebService::Client::Credentials

    def initialize(options={})
      options = PaylocityWebService.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

  end
end
