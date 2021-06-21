require 'openssl'

module PaylocityWebService
  module Encryption
    def envelope_encrypt(data)
      # 1 generate data encryption key and IV.
      aes = OpenSSL::Cipher::AES.new(256, :CBC)
      aes.encrypt

      key = aes.random_key
      iv  = aes.random_iv

      # 2. encrypt data use your data encryption key
      encrypted_data = aes.update(data.to_json) + aes.final
      encoded_data64 = Base64.strict_encode64(encrypted_data)

      # 3. encrypt your key through the public key issued by paylocity
      pub_key = OpenSSL::PKey::RSA.new(self.public_key)
      encrypted_key64 = Base64.strict_encode64(pub_key.public_encrypt(key))
      encoded_iv64   = Base64.strict_encode64(iv)

      # 4. put together.
      {
        secureContent: {
          key:      encrypted_key64,
          iv:       encoded_iv64,
          content:  encoded_data64
        }
      }
    end
  end
end
