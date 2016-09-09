class AddTemplateRefToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :template, index: true, foreign_key: true
  end
end
