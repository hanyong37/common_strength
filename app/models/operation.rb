class Operation < ApplicationRecord
  belongs_to :customer
  belongs_to :user


  def customer_name
    self.customer.name
  end

  def user_name
    self.user.name
  end
end
