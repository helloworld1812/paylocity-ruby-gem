module PaylocityWebService
  class Client
    module Credentials
      def create_client_credential
        post("/api/v2/credentials/secrets")
      end
    end
  end
end
