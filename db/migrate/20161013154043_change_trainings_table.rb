class ChangeTrainingsTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :trainings, :user_id, :customer_id
  end
end
