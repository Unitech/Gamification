class AddNumericStatusToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :numeric_status, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :posts, :numeric_status
  end
end
