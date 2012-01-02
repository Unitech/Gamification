class AddUpdateToUsers < ActiveRecord::Migration
  def change

    change_table :users do |t|
      t.integer :missions_seen
      t.integer :comments_seen
    end

  end
end
