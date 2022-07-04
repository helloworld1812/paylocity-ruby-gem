require 'faraday'
require 'faraday_middleware'

require 'paylocity_web_service/authentication'
require 'paylocity_web_service/encryption'
require "paylocity_web_service/middleware/response/raise_error"

module PaylocityWebService
  # Network layer for API clients.
  module Connection
    include PaylocityWebService::Authentication

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @return [Sawyer::Resource]
    def get(url)
      request :get, url
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def post(url, options = {})
      request :post, url, options
    end

    # Make a HTTP PUT request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def put(url, options = {})
      request :put, url, options
    end

    # Make a HTTP PATCH request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def patch(url, options = {})
      request :patch, url, options
    end

    # Make a HTTP DELETE request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def delete(url, options = {})
      request :delete, url, options
    end

    # Make a HTTP HEAD request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def head(url, options = {})
      request :head, url, options
    end


    private

    def request(method, path, options = {})
      response = connection.send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = envelope_encrypt(options)
        end
      end

      response
    end

    def connection
      options = {
        headers: {
          'Accept' => "application/#{format}; charset=utf-8",
          'User-Agent' => user_agent,
          'Content-Type' => "application/#{format}"
        },
        proxy: proxy,
        url: endpoint,
      }.merge(connection_options)

      connection = Faraday::Connection.new(options) do |conn|
        conn.use Faraday::Request::Authorization, :Bearer, access_token
        conn.request :retry, max: 2
        conn.request :json
        conn.request :instrumentation, name: 'request.paylocity'

        # conn.use PaylocityWebService::Middleware::Response::RaiseError
        conn.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
      end

      connection
    end
  end
end
