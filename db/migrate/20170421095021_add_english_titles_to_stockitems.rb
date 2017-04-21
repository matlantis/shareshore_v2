class AddEnglishTitlesToStockitems < ActiveRecord::Migration[5.0]
  def up
    rename_column :stockitems, :title, :title_de
    add_column :stockitems, :title_en, :string

    Stockitem.all.each do |t|
      t.title_en = t.title_de
      t.save
    end
  end

  def down
    rename_column :stockitems, :title_de, :title
    remove_column :stockitems, :title_en, :string
  end
end
