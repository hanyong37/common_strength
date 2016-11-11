class AddIndexesToTrainings < ActiveRecord::Migration[5.0]
  def change
    add_index :trainings, :schedule_id
    add_index :trainings, :customer_id
  end
end
