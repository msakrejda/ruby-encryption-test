class Secret < Sequel::Model

  def generate_secret
    "postgres://#{rand_ch(15)}:#{rand_ch(15)}@#{host}:#{rand(1000) + 5432}/#{rand_ch(15)}"
  end

  def before_create
    # encrypt must be implemented by subclasses
    self.encrypted = encrypt(generate_secret)
    self.unencrypted = SecureRandom.base64(15)
  end

  def update_unencrypted
    self.update(unencrypted: SecureRandom.base64(15))
  end

  def decrypt_encrypted
    decrypt(encrypted)
  end

  def update_encrypted
    self.update(encrypted: encrypt(generate_secret))
  end

  private

  def rand_ch(count)
    SecureRandom.base64(count)
  end

  def host
    "ec2-#{rand(255)}-#{rand(255)}-#{rand(255)}-#{rand(255)}.compute-1.amazonaws.com"
  end

end
