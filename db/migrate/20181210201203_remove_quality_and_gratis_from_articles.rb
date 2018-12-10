class RemoveQualityAndGratisFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_columns :articles, :quality, :gratis
  end
end
