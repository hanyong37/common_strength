class AddIsLockedToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :is_locked, :boolean
  end
end
