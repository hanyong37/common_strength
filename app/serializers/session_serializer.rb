class SessionSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :token
  #link(:self) { admin_user_path(object) }
end
