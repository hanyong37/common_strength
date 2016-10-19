class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :mobile, :weixin, :membership_type, :store_id, :membership_remaining_times, :membership_duedate, :store_name
  has_many :trainings
end
