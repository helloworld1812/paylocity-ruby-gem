module PaylocityWebService
  class Client
    module Companies
      CodeResources = %W(costCenter1 costCenter2 costCenter3 deductions earnings taxes paygrade positions)

      def company_schema
        get("/api/v2/companies/#{company_id}/openapi")
      end

      # Available Code Resources:
      # - costCenter1
      # - costCenter2
      # - costCenter3
      # - deductions
      # - earnings
      # - taxes
      # - paygrade
      # - positions
      def company_codes(code_resource)
        get("/api/v2/companies/#{company_id}/codes/#{code_resource}")
      end

      def code_resources
        CodeResources
      end

      # Paylocity hasn't provide a way to check the connectivity of the API, we have to fire a request to check it.
      def company_connected
        return true if company_codes('costCenter1').status == 200
        return true if company_schema.code == 200
        false
      rescue => e
        false 
      end
    end
  end
end
