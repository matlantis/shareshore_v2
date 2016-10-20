class ReorganiseRate1 < ActiveRecord::Migration
  def change
    remove_column :articles, :rate
    remove_column :articles, :gratis
    add_column :articles, :rate_eur, :integer
    add_column :articles, :rate_intervall, :string
  end
end
