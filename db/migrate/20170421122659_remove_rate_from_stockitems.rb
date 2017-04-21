class RemoveRateFromStockitems < ActiveRecord::Migration[5.0]
  def change
    remove_column :stockitems, :rate, :string
  end
end
