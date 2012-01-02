class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.integer  :amount
      t.string   :title
      t.text     :resume
      t.text     :description
      t.datetime :begin_date
      t.datetime :end_date
      t.integer  :state
      t.timestamps
    end
  end
end
