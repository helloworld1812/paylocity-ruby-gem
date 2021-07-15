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

      def create_staging_employee(options={})
        post("/api/v2/weblinkstaging/companies/#{company_id}/employees/newemployees", options)
      end
    end
  end
end
