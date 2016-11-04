class RemoveAttributesFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :value_eur, :integer
    remove_column :articles, :deposit_eur, :integer
  end
end
