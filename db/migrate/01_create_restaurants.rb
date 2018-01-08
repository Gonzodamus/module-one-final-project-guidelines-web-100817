class CreateRestaurants < ActiveRecord::Migration[4.2]

  def change
    create_table :restaurants do |t|
      t.string :restaurant_id
      t.string :name
      t.string :cuisine
      t.string :zipcode
      t.string :building
      t.string :street
      t.string :phone_number
    end
  end
end
