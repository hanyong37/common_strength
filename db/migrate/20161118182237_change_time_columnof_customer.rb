class ChangeTimeColumnofCustomer < ActiveRecord::Migration[5.0]
  def change
    rename_column :customers, :membership_remaining_times, :membership_total_times
  end
end
