module PaylocityWebService
  class Client
    module Employees
      def employees
        get("/api/v2/companies/#{company_id}/employees/")
      end

      def employee(employee_id)
        get("/api/v2/companies/#{company_id}/employees/#{employee_id}")
      end

      def create_employee(options={})
        post("/api/v2/companies/#{company_id}/employees", options)
      end
    end
  end
end
