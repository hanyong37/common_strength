class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :courses, :type_id
    add_index :courses, :store_id
    add_index :schedules, :course_id
    add_index :schedules, :store_id
    add_index :customers, :store_id
    add_index :operations, :user_id
    add_index :operations, :target_id
    add_index :operations, :customer_id
  end
end
