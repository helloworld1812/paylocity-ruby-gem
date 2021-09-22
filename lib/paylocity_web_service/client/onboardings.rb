module PaylocityWebService
  class Client
    module Onboardings
      def create_employee(options={})
        post("/api/v1/companies/#{company_id}/onboarding/employees", options)
      end
    end
  end
end
