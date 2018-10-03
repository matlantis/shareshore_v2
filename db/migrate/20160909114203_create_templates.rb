class CreateTemplates < ActiveRecord::Migration[4.2]
  def change
    create_table :templates do |t|
      t.string :title
      t.text :details_hint
      t.integer :rate_eur
      t.string :rate_interval
      t.string :picture

      t.timestamps null: false
    end
  end
end
