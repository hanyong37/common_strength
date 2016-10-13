class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.integer :type_id
      t.integer :store_id
      t.string  :name
      t.text    :description
      t.integer :status
      t.timestamps
    end
  end
end
