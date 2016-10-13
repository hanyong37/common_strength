class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :mobile, :weixin
  has_many :trainings
end
