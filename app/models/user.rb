class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :authentication_token, uniqueness: true, allow_nil: true

  def generate_authentication_token
    self.authentication_token = SecureRandom.hex(15)
  end
end
