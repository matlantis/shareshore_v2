class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :street_and_no
      t.string :city
      t.string :postcode
      t.string :country

      t.float :latitude
      t.float :longitude
      
      t.timestamps null: false
    end

    change_table :locations do |t|
      t.belongs_to :house, index: true
    end
  end
end
