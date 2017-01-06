class RenameSenderToUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_article_requests, :sender_id, :user_id
  end
end
