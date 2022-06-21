require 'json'
require 'base64'
require 'digest/md5'
require 'paylocity_web_service/cache'

module PaylocityWebService
  module Authentication
    def access_token
      token = cache_store.read(access_token_cache_key)

      if token.nil?
        refresh_token
      else
        token
      end
    end

    def refresh_token
      resp = Faraday.post(endpoint + '/IdentityServer/connect/token') do |req|
        req.body = {
          grant_type: 'client_credentials',
          scope:      'WebLinkAPI'
        }
        req.headers = {
          'Content-Type':   'application/x-www-form-urlencoded',
          'Authorization':  "Basic #{ basic_auth_token }"
        }
      end

      body = JSON.parse(resp.body)
      token, expires_in = body['access_token'], body['expires_in']
      cache_store.write(access_token_cache_key, token, expires_in: expires_in)
      token
    end

    def access_token_cache_key
      raise 'company_id is required' if company_id.nil?
      "PaylocityCompany/#{company_id}/AccessToken/#{endpoint}"
    end


    def cache_store
      if defined?(Rails)
        Rails.cache
      else
        PaylocityWebService::Cache
      end
    end

    def basic_auth_token
      secret_value = if client_secret.is_a?(Proc)
                       client_secret.call
                     else
                       client_secret
                     end
      Base64.strict_encode64("#{ client_id }:#{ secret_value }")
    end
  end
end
