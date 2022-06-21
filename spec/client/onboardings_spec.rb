require File.expand_path('../../spec_helper', __FILE__)

RSpec.describe PaylocityWebService::Client::Onboardings do
  describe '#onboard_employee' do
    it 'should create an onboardee' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.onboard_employee(
        firstName: 'John',
        lastName: 'Doe',
        userName: SecureRandom.hex(10),
        personalEmailAddress: SecureRandom.hex + '@example.com',
      )

      expect(result.status).to eq(201)
    end
  end
end
