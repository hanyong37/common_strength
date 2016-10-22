class AddCustomerIdToOperations < ActiveRecord::Migration[5.0]
  def change
    add_column :operations, :customer_id, :integer
  end
end
