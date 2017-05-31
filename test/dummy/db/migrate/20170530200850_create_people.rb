class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.text :description
      t.integer :gross_income
      t.float :net_income
      t.decimal :taxed_amount
      t.datetime :birthdate
      t.date :birthday
      t.time :birthtime
      t.binary :picture
      t.boolean :active

      t.timestamps
    end
  end
end
