class SessionSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :token
  link(:self) { admin_user_url(object) }
end
