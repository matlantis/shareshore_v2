class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :details
      t.integer :price_eur
      t.string :rate
      t.boolean :gratis
      t.integer :deposit_eur
      t.references :location, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
