module PaylocityWebService
  module Configuration
    VALID_OPTIONS_KEYS = [
      :client_id,
      :client_secret,
      :endpoint,
      :public_key,
      :company_id,
      :proxy,
      :ssl_verify_mode,
      :format,
      :connection_options,
      :user_agent
    ]

    # By default, don't set a user access token
    DEFAULT_ACCESS_TOKEN = nil

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an application ID
    DEFAULT_CLIENT_ID = nil

    # By default, don't set an application secret
    DEFAULT_CLIENT_SECRET = nil

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://apisandbox.paylocity.com'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default, the ssl_verify_mode is true
    DEFAULT_SSL_VERIFY_MODE = true

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "paylocity-ruby-gem #{PaylocityWebService::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # Sets all configuration options to their default values
    # when this module is extended.
    def self.extended(base)
      base.reset
    end

    # Set configuration options using a block
    def configure
      yield self
    end

    # Creates a hash of options and their values.
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset configuration options to default values
    def reset
      self.client_id          = DEFAULT_CLIENT_ID
      self.client_secret      = DEFAULT_CLIENT_SECRET
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.endpoint           = DEFAULT_ENDPOINT
      self.format             = DEFAULT_FORMAT
      self.proxy              = DEFAULT_PROXY
      self.user_agent         = DEFAULT_USER_AGENT
      self.ssl_verify_mode    = DEFAULT_SSL_VERIFY_MODE

      self
    end
  end
end
