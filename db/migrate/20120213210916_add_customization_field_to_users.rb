class AddCustomizationFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_comments, :boolean, :default => true
    add_column :users, :mail_missions, :boolean, :default => true
  end
end
