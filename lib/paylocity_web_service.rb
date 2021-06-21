# frozen_string_literal: true

require_relative "paylocity_web_service/version"
require_relative 'paylocity_web_service/error'
require_relative 'paylocity_web_service/connection'
require_relative 'paylocity_web_service/configuration'
require_relative 'paylocity_web_service/authentication'
require_relative 'paylocity_web_service/client'

module PaylocityWebService
  extend PaylocityWebService::Configuration

  class << self
    def client
      @client || PaylocityWebService::Client.new(options)
    end
  end
end
