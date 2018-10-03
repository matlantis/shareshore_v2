class ReorganiseRate < ActiveRecord::Migration[4.2]
  def change
    remove_column :templates, :rate_eur, :integer
    remove_column :templates, :rate_interval, :string
    add_column :templates, :rate, :string

    remove_column :articles, :rate_eur
    remove_column :articles, :rate_intervall
    add_column :articles, :rate, :string
    add_column :articles, :gratis, :boolean
  end
end
