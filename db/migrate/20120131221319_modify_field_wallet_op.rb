class ModifyFieldWalletOp < ActiveRecord::Migration
  def up
    rename_column :wallet_operations, :type, :historic_type
  end

  def down
    rename_column :wallet_operations, :historic_type, :type
  end
end
