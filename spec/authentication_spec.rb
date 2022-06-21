# frozen_string_literal: true
require File.expand_path('../spec_helper', __FILE__)

RSpec.describe PaylocityWebService::Authentication do
  describe '#access_token' do
    it 'should return a string' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.access_token
      expect(result).to be_a(String)
    end

    it 'should read token from cache' do
      fake_response = OpenStruct.new(
        status: 200,
        body: {
          access_token: 'fake_token',
          expires_in: 3600
        }.to_json
      ) 

      allow(Faraday).to receive(:post).and_return(fake_response)
      expect(Faraday).to receive(:post).once

      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      @client.cache_store.clear
      @client.access_token
      @client.access_token
    end
  end

  describe '#refresh_token' do
    it 'should return write token to cache' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      @client.cache_store.clear

      result = @client.refresh_token
      expect(!result.nil?).to be(true)
      expect(!@client.cache_store.read(@client.access_token_cache_key).nil?).to be(true)
    end
  end

  describe '#access_token_cache_key' do
    it 'should return a string' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.access_token_cache_key
      expect(result).to eq("PaylocityCompany/#{ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID']}/AccessToken/#{ENV['SANDBOX_PAYLOCITY_ENDPOINT']}")
    end

    it 'should raise an error when company_id is missing' do
      @client = PaylocityWebService::Client.new
      expect { @client.access_token_cache_key }.to raise_error(StandardError)
    end
  end

  describe '#cache_store' do
    it 'should return a cache store' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.cache_store
      expect(result).to be_a(ActiveSupport::Cache::MemoryStore)
    end
  end
end
