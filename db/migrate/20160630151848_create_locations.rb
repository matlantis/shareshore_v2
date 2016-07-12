class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street_and_no
      t.string :postcode
      t.string :city
      t.string :country
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
