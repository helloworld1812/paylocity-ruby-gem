require 'paylocity_web_service/error'

module PaylocityWebService
  module Middleware
    # Faraday response middleware
    module Response

      # This class raises an exception based
      # HTTP status codes returned by the API
      class RaiseError < Faraday::Response::Middleware

        def initialize(app)
          super app
        end

        def call(env)
          @app.call(env).on_complete do |response|
            if error = PaylocityWebService::Error.from_response(response)
              raise error
            end
          end
        end
      end
    end
  end
end
