module PaylocityWebService
  class Error < StandardError    
    attr_accessor :response

    # Returns the appropriate PaylocityWebService::Error subclass based
    # on status and response message
    #
    # @param [Hash] response HTTP response
    # @return [PaylocityWebService::Error]
    def self.from_response(response)
      status  = response[:status].to_i

      if klass = case status
      when 400
        PaylocityWebService::BadRequest
      when 401
        PaylocityWebService::ClientError
      when 403
        PaylocityWebService::Forbidden
      when 404
        PaylocityWebService::NotFound
      when 405
        PaylocityWebService::MethodNotAllowed
      when 406
        PaylocityWebService::NotAcceptable
      when 409
        PaylocityWebService::Conflict
      when 415
        PaylocityWebService::UnsupportedMediaType
      when 422
        PaylocityWebService::UnprocessableEntity
      when 451
        PaylocityWebService::UnavailableForLegalReasons
      when 400..499
        PaylocityWebService::ClientError
      when 500
        PaylocityWebService::InternalServerError
      when 501
        PaylocityWebService::NotImplemented
      when 502
        PaylocityWebService::BadGateway
      when 503
        PaylocityWebService::ServiceUnavailable
      when 500..599
        PaylocityWebService::ServerError
      end

      klass.new(response)
    end
  end

  private

  def initialize(response=nil)
    @response = response
    super(build_error_message)
  end

  def build_error_message
    return nil if response.nil?

    message = "Status: #{response&.status} \n"
    message << "Method: #{response&.method&.to_s.upcase} \n" 
    message << "URL: #{response&.url&.to_s} \n"
    message << "Body: \n"
    message << JSON.pretty_generate(response&.body)
    message

    # message = {
    #   status: response.status,
    #   headers: response.response_headers,
    #   body: response.body,
    #   request: {
    #     method: response.method,
    #     url_path: response.url.path,
    #     params: response.params,
    #     headers: response.request_headers,
    #     body: response.request_body
    #   }
    # }
    # JSON.pretty_generate(message)

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
