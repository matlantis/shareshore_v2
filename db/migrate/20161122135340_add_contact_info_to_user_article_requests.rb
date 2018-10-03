class AddContactInfoToUserArticleRequests < ActiveRecord::Migration[4.2]
  def change
    add_column :user_article_requests, :with_phoneno, :boolean
    add_column :user_article_requests, :with_email, :boolean
    add_column :user_article_requests, :with_name, :boolean
  end
end
