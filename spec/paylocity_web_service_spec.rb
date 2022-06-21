# frozen_string_literal: true
require File.expand_path('../spec_helper', __FILE__)

RSpec.describe PaylocityWebService do
  after do
    PaylocityWebService.reset
  end

  describe ".client" do
    it "should be a PaylocityWebService::Client" do
      expect(PaylocityWebService.client.is_a?(PaylocityWebService::Client)).to be true
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      expect(PaylocityWebService.endpoint).to eq(PaylocityWebService::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      PaylocityWebService.endpoint = 'https://apisandbox.paylocity.com'
      expect(PaylocityWebService.endpoint).to eq('https://apisandbox.paylocity.com')
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      expect(PaylocityWebService.user_agent).to eq(PaylocityWebService::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      PaylocityWebService.user_agent = 'Custom User Agent - Bot'
      expect(PaylocityWebService.user_agent).to eq('Custom User Agent - Bot')
    end
  end

  describe ".configure" do
    PaylocityWebService::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        PaylocityWebService.configure do |config|
          config.send("#{key}=", key)
          expect(PaylocityWebService.send(key)).to eq(key)
        end
      end
    end
  end
end
