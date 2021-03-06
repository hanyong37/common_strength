class Course < ApplicationRecord
  validates :name, presence: :true
  belongs_to :type, class_name: 'CourseType'
  belongs_to :store
  has_many :schedules, dependent: :restrict_with_error
  has_many :trainings, through: :schedules

  scope :by_store, ->(param) {where(store_id: param) if (param.present?)}
  scope :by_status, ->(param) {where(status: Course.statuses[param]) if (param.present?)}

  enum status:{'active':1, 'inactive':0}

  def store_name
    self.store.name
  end

  def type_name
    self.type.name
  end
end
