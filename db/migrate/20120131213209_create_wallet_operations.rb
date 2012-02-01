class CreateWalletOperations < ActiveRecord::Migration
  def change
    create_table :wallet_operations do |t|
      t.integer :type
      t.integer :euros
      t.integer :epices
      t.integer :points
      t.references :user

      t.timestamps
    end
    add_index :wallet_operations, :user_id
  end
end
