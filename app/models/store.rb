class Store < ApplicationRecord
  validates :name, presence: :true, uniqueness: :true
  has_many :customers, dependent: :restrict_with_error
  has_many :courses, dependent: :restrict_with_error
end
