class AddRessourcesToUser < ActiveRecord::Migration
  def change
    add_column :users, :cash, :integer
    add_column :users, :epices, :integer
    add_column :users, :points, :integer
  end
end
