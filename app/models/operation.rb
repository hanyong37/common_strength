class Operation < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :customer
  belongs_to :user


  def customer_name
    self.customer.name
  end

  def user_name
    self.user.full_name
  end
end
