class Customer < ApplicationRecord
  validates :name, :weixin, :mobile, presence: true, uniqueness: true
  validates :membership_type, presence: :true
  has_many :trainings, dependent: :restrict_with_error
  has_many :operations, dependent: :delete_all
  belongs_to :store

  enum membership_type: {
   time_card: 1,
   measured_card: 2
  }

  def store_name
    self.store.name
  end

end
