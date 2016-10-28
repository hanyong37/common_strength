class AddTokenToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :token, :string
  end
end
