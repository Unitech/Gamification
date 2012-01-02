class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      #t.string :email
      t.string :username
      t.string :website
      t.string :linkedin
      t.text :technologies_known
      t.string :technologies_want
      t.text :additional_informations
      t.string :phone_number
      t.integer :grade
      t.boolean :admin

      t.timestamps
    end
  end
end
