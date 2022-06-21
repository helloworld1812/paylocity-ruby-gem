module PaylocityWebService
  class Cache
    def self.read(key)
      return if store[key].nil?
      return if store[key][:expires_at].nil?
      return if store[key][:value].nil?
      return if store[key][:expires_at] < Time.now.to_i

      store[key][:value]
    end

    def self.write(key, value, options = {} )
      expires_in = options[:expires_in] || 3600
      expires_at = (Time.now.to_i + expires_in.to_i) - 60
      store[key] = { value: value, expires_at: expires_at}
    end

    def self.store
      @cache_store ||= {}
    end

    def self.clear
      @cache_store = {}
    end
  end
end
