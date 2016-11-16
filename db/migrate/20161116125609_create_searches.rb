class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :pattern
      t.string :address
      t.float :radius
      t.boolean :use_location
      t.references :location, foreign_key: true
      t.float :latitude
      t.float :longitude
      
      t.timestamps null: false
    end
  end
end
