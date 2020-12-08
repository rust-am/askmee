require 'openssl'
require 'uri'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  before_validation :downcase_username, :downcase_email

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :username, presence: true, uniqueness: true, length: {maximum: 40},
            format: {with: /\A[a-zA-Z0-9_]*\z/, message: "A-Z, a-z, 0-9, _ characters only available."}
  validates :password, confirmation: true, presence: true, on: :create
  validates :profile_color, format: {with: /\A#([a-fA-F0-9]{6}|[a-fA-F0-9]{3})\z/}

  attr_accessor :password


  before_save :encrypt_password

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  def downcase_username
    self.username = username.downcase if username.present?
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
