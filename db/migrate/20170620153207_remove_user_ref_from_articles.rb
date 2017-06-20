class RemoveUserRefFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_reference :articles, :user, index: true, foreign_key: true 
  end
end
