class AddGratisToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :gratis, :boolean
  end
end
