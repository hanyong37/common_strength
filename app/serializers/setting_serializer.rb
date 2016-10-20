class SettingSerializer < ActiveModel::Serializer
  attributes :key, :value, :updated_at
end
