class Customer < ApplicationRecord
  validates :name, :weixin, :telphone, absence: false
  has_many :trainings
end
