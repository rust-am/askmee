require 'openssl'
require 'uri'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  before_validation :username_to_downcase

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  # нашел такое стандартное решение
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  validates :username, length: {maximum: 40}
  validates :username, format: {with: /\A[a-zA-Z0-9_]*\z/,
                                message: "A-Z, a-z, 0-9, _ characters only available."}

  attr_accessor :password

  validates :password, presence:true, on: :create
  # устаревший способ
  # validates_presence_of :password, on: :create
  validates :password, confirmation: true
  # устаревший способ
  # validates_confirmation_of :password

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

  def username_to_downcase
    username.downcase! if username.present?
  end
end
