class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name, :nil => false
      t.text :description
      t.string :status
      t.integer :project_id, :nil => false
      t.timestamps
    end

    add_index :tasks, :project_id
  end

  def self.down
    drop_table :tasks
  end
end
