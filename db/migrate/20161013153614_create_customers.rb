class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :mobile
      t.string :weixin

      t.timestamps
    end
  end
end
