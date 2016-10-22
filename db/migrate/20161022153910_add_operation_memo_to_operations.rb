class AddOperationMemoToOperations < ActiveRecord::Migration[5.0]
  def change
    add_column :operations, :operation_memo, :text
  end
end
