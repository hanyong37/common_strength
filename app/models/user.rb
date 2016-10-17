class User < ApplicationRecord
  has_secure_token
  has_secure_password

  before_create :generate_authentication_token
  validates :full_name, presence: true

  def generate_authentication_token
    loop do
      self.token = SecureRandom.base64(64)
      break if !User.find_by(token: token)
    end
  end

  def reset_auth_token!
    generate_authentication_token
    save
  end

end
