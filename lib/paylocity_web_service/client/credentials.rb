module PaylocityWebService
  class Client
    module Credentials
      def create_client_credential(options={})
        post("/api/v2/credentials/secrets", options)
      end
    end
  end
end
