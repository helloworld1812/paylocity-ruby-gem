module PaylocityWebService
  class Error < StandardError
    # Returns the appropriate PaylocityWebService::Error subclass based
    # on status and response message
    #
    # @param [Hash] response HTTP response
    # @return [PaylocityWebService::Error]
    def self.from_response(response)
      case response[:status]
      when 400
        raise PaylocityWebService::BadRequest, response_values(response)
      when 401
        raise PaylocityWebService::ClientError, response_values(response)
      when 403
        raise PaylocityWebService::Forbidden, response_values(response)
      when 404
        raise PaylocityWebService::NotFound, response_values(response)
      when 405
        raise PaylocityWebService::MethodNotAllowed, response_values(response)
      when 406
        raise PaylocityWebService::NotAcceptable, response_values(response)
      when 409
        raise PaylocityWebService::Conflict, response_values(response)
      when 415
        raise PaylocityWebService::UnsupportedMediaType, response_values(response)
      when 422
        raise PaylocityWebService::UnprocessableEntity, response_values(response)
      when 451
        raise PaylocityWebService::UnavailableForLegalReasons, response_values(response)
      when 400..499
        raise PaylocityWebService::ClientError, response_values(response)
      when 500
        raise PaylocityWebService::InternalServerError, response_values(response)
      when 501
        raise PaylocityWebService::NotImplemented, response_values(response)
      when 502
        raise PaylocityWebService::BadGateway, response_values(response)
      when 503
        raise PaylocityWebService::ServiceUnavailable, response_values(response)
      when 500..599
        raise PaylocityWebService::ServerError, response_values(response)
      end
    end

    private

    def self.response_values(response)
      return nil if response.nil?

      {
        status: response.status,
        headers: response.response_headers,
        body: response.body,
        request: {
          method: response.method,
          url_path: response.url.path,
          params: response.params,
          headers: response.request_headers,
          body: response.request_body
        }
      }
    end
  end

  # Raised on errors in the 400-499 range
  class ClientError < Error; end

  # Raised when returns a 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when returns a 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when returns a 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when returns a 404 HTTP status code
  class NotFound < ClientError; end

  # Raised when returns a 405 HTTP status code
  class MethodNotAllowed < ClientError; end

  # Raised when returns a 406 HTTP status code
  class NotAcceptable < ClientError; end

  # Raised when returns a 409 HTTP status code
  class Conflict < ClientError; end

  # Raised when returns a 414 HTTP status code
  class UnsupportedMediaType < ClientError; end

  # Raised when returns a 422 HTTP status code
  class UnprocessableEntity < ClientError; end

  # Raised when returns a 451 HTTP status code
  class UnavailableForLegalReasons < ClientError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when returns a 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when returns a 501 HTTP status code
  class NotImplemented < ServerError; end

  # Raised when returns a 502 HTTP status code
  class BadGateway < ServerError; end

  # Raised when returns a 503 HTTP status code
  class ServiceUnavailable < ServerError; end

  # Raised when client fails to provide valid Content-Type
  class MissingContentType < ArgumentError; end

  # Raised when client fails to provide a required key
  class MissingKey < ArgumentError; end

  # Raised when a method requires an application client_id
  # and secret but none is provided
  class ApplicationCredentialsRequired < StandardError; end
end
