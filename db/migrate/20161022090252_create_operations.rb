class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.integer :user_id
      t.string :target
      t.string :target_id
      t.string :description
      t.timestamps
    end
  end
end
