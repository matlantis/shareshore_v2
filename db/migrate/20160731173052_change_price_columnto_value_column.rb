class ChangePriceColumntoValueColumn < ActiveRecord::Migration
  def change
    rename_column :articles, :price_eur, :value_eur
  end
end
