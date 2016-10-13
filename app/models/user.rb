class User < ApplicationRecord
  has_secure_token
  has_secure_password
  has_many :trainings

  validates :full_name, presence: true
end
