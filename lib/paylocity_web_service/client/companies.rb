module PaylocityWebService
  class Client
    module Companies
      CodeResources = %W(costcenter1 costcenter2 costcenter3 deductions earnings taxes paygrade positions)

      def company_schema
        get("/api/v2/companies/#{company_id}/openapi")
      end

      # Available Code Resources:
      # - costcenter1
      # - costcenter2
      # - costcenter3
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
    end
  end
end
