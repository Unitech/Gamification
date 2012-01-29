class AddDefaultValueToPostStatus < ActiveRecord::Migration
  def self.up
    change_column :posts, :status, :string, :default => 'draft', :null => false
  end

  def self.down
    change_column :posts, :status, :string
  end
end
