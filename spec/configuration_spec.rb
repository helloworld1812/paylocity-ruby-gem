# frozen_string_literal: true
require File.expand_path('../spec_helper', __FILE__)

RSpec.describe PaylocityWebService::Configuration do
  describe ".client" do
    it "should be a PaylocityWebService::Client" do
      expect(PaylocityWebService.client.is_a?(PaylocityWebService::Client)).to be true
    end
  end

  describe "#endpoint" do
    it "should return the default endpoint" do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      expect( @client.endpoint).to eq(PaylocityWebService::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe "#endpoint=" do
    it "should set the endpoint" do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      @client.endpoint = 'https://customedpoint.com'
      expect(@client.endpoint).to eq('https://customedpoint.com')
    end
  end

  describe "#user_agent" do
    it "should return the default user agent" do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      expect(@client.user_agent).to eq(PaylocityWebService::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe "#user_agent=" do
    it "should set the user_agent" do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      @client.user_agent = 'Custom User Agent - Bot'
      expect(@client.user_agent).to eq('Custom User Agent - Bot')
    end
  end
end
