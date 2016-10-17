class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :description, :created_at
  link(:self) { admin_user_url(object) }
end
