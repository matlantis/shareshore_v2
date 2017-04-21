class AddEnglishDetailsHintToStockitems < ActiveRecord::Migration[5.0]
  def up
    rename_column :stockitems, :details_hint, :details_hint_de
    add_column :stockitems, :details_hint_en, :string

    Stockitem.all.each do |t|
      t.details_hint_en = t.details_hint_de
      t.save
    end
  end

  def down
    rename_column :stockitems, :details_hint_de, :details_hint
    remove_column :stockitems, :details_hint_en, :string
  end
end
