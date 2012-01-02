class CreateEntrMissionUsers < ActiveRecord::Migration
  def change
    create_table :entr_mission_users do |t|
      t.references :user
      t.references :mission
      t.integer    :state
      t.timestamps
    end
  end
end
