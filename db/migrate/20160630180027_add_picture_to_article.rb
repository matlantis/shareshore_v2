class AddPictureToArticle < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :picture, :string
  end
end
