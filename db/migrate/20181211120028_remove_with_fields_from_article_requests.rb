class RemoveWithFieldsFromArticleRequests < ActiveRecord::Migration[5.2]
  def change
    remove_columns :user_article_requests, :with_email, :with_name, :with_phoneno
  end
end
