class AddLentFieldsToArticle < ActiveRecord::Migration[5.1]
  def up
    add_column :articles, :lent_description, :string

    Article.all.each do |a|
      a.lent_description = ""
      a.save
    end
  end

  def down
    remove_column :articles, :lent_description, :string
  end
end
