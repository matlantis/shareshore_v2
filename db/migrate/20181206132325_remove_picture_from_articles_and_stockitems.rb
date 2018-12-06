class RemovePictureFromArticlesAndStockitems < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :picture
    remove_column :stockitems, :picture
  end
end
