class CreateStockitemSelections < ActiveRecord::Migration[4.2]
  def change
    create_table :stockitem_selections do |t|
    end

    create_table :stockitem_selections_stockitems, id: false do |t|
      t.belongs_to :stockitem_selection, index: true
      t.belongs_to :stockitem, index: true
    end
  end
end
