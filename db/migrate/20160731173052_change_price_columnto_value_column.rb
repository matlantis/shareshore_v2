class ChangePriceColumntoValueColumn < ActiveRecord::Migration[4.2]
  def change
    rename_column :articles, :price_eur, :value_eur
  end
end
