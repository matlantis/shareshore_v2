class AddQualityToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :quality, :integer
  end
end
