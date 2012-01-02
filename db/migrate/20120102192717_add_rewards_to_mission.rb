class AddRewardsToMission < ActiveRecord::Migration
  def change
    change_table(:missions) do |t|
      t.integer :euros
      t.integer :epices
      t.integer :points
      
      t.integer  :category
    end
  end
end
