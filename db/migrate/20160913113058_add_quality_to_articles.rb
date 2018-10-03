class AddQualityToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :quality, :integer
  end
end
