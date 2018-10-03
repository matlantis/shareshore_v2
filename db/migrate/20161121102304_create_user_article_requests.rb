class CreateUserArticleRequests < ActiveRecord::Migration[4.2]
  def change
    create_table :user_article_requests do |t|
      t.string :text
      t.references :article, index: true, foreign_key: true
      # sender is a user, needs special treatment for this reason
      t.integer :sender_id
      t.index :sender_id
                                             
      t.timestamps null: false
    end
  end
end
