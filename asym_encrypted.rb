class AsymEncrypted < Secret
  def key
    @key ||= OpenSSL::PKey::RSA.new(File.read("mykey.pem"))
  end

  def encrypt(value)
    key.public_encrypt(value, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)
  end

  def decrypt(value)
    key.private_decrypt(value, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)
  end
end
