require File.expand_path('../../spec_helper', __FILE__)

RSpec.describe PaylocityWebService::Client::Companies do 
  describe '#company_schema' do
    it 'should return a hash' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.company_schema
      expect(result.status).to eq(200)
      expect(result.body).to be_a(Hash)
    end
  end

  describe '#company_codes' do
    it 'should return a hash' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.company_codes('costCenter1')
      expect(result.status).to eq(200)
      expect(result.body).to be_a(Array)
    end
  end

  describe 'company_connected?' do
    it 'should return true' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.company_connected?
      expect(result).to eq(true)
    end

    it 'should return false' do
      @client = PaylocityWebService::Client.new(company_id: '12345')
      result = @client.company_connected?
      expect(result).to eq(false)
    end
  end
end