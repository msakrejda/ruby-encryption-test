class FernetEncrypted < Sequel::Model
  include Secret

  SECRET = '08vK4SSFX70g888sM8H2tZeEweJi6tPDYLYvWfTcA5g='

  def encrypt(value)
    Fernet.generate(SECRET, value)
  end

  def decrypt(value)
    Fernet.verifier(SECRET, value, enforce_ttl: false).message
  end
end
