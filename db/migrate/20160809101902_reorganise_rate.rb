class ReorganiseRate < ActiveRecord::Migration
  def change
    remove_column :articles, :rate, :string
    remove_column :articles, :gratis, :boolean
    add_column :articles, :rate_eur, :integer
    add_column :articles, :rate_interval, :string
  end
end
