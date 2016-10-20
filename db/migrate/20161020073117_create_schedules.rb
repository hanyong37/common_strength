class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :course_id
      t.integer :store_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity
      t.boolean :is_published

      t.timestamps
    end
  end
end
