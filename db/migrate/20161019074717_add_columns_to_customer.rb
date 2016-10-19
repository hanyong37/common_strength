class AddColumnsToCustomer < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :store_id, :integer
    add_column :customers, :membership_type, :integer
    add_column :customers, :membership_duedate, :date
    add_column :customers, :membership_remaining_times, :integer
  end
  def down
    remove_column :customers, :store_id
    remove_column :customers, :membership_type
    remove_column :customers, :membership_duedate
    remove_column :customers, :membership_remaining_times
  end
end
