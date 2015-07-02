class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :email
      t.string :picture
      t.text :description
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
