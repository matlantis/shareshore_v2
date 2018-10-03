class AddTemplateRefToArticles < ActiveRecord::Migration[4.2]
  def change
    add_reference :articles, :template, index: true, foreign_key: true
  end
end
