require 'openssl'
require 'uri'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_REGEX = /\A\w+\z/
  COLOR_REGEX = /\A#\h{3}{1,2}\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy
  before_validation :downcase_username, :downcase_email
  before_save :encrypt_password

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :username, presence: true, uniqueness: true, length: {maximum: 40}, format: {with: USERNAME_REGEX}
  validates :password, confirmation: true, presence: true, on: :create
  validates :profile_color, format: {with: COLOR_REGEX}

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    email&.downcase!
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def downcase_username
    username&.downcase!
  end

  def downcase_email
    email&.downcase!
  end
end
