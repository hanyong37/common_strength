class AddTimeIndexesToSchedules < ActiveRecord::Migration[5.0]
  def change
    add_index :schedules, :start_time
    add_index :schedules, :end_time
  end
end
