require File.expand_path('../../spec_helper', __FILE__)

RSpec.describe PaylocityWebService::Client::Employees do
  describe '#employees' do
    it 'should return an array' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.employees

      expect(result.status).to eq(200)
      expect(result.body).to be_a(Array)
    end
  end

  describe '#employee' do
    it 'should return a hash' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      employee_id = @client.employees.body.first['employeeId']
      result = @client.employee(employee_id)

      expect(result.status).to eq(200)
      expect(result.body).to be_a(Hash)
    end
  end

  describe '#create_staging_employee' do
    it 'should return a hash' do
      @client = PaylocityWebService::Client.new(company_id: ENV['SANDBOX_PAYLOCITY_DEMO_COMPANY_ID'])
      result = @client.create_staging_employee(
        firstName: 'John',
        lastName: 'Doe'
      )

      expect(result.status).to eq(201)
    end
  end
end