class AddFieldsToMission < ActiveRecord::Migration
  def change
    add_column :missions, :date_available, :boolean, :default => true
  end
end
