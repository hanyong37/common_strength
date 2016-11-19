class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :mobile, :is_weixin_connected, :membership_type, :store_id, :membership_remaining_times,:membership_total_times, :membership_duedate, :store_name, :is_locked, :weixin, :token
  #has_many :trainings
end
