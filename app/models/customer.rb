class Customer < ApplicationRecord
  validates :name, :weixin, :mobile, presence: true, uniqueness: true
  has_many :trainings, dependent: :restrict_with_error
  belongs_to :store
end
