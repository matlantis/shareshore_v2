class CreateUserArticleRequests < ActiveRecord::Migration
  def change
    create_table :user_article_requests do |t|
      t.string :text
      t.references :article, index: true, foreign_key: true
      # sender and receiver needs specials treatment (both type user)
      t.integer :receiver_id
      t.integer :sender_id
      t.index :receiver_id
      t.index :sender_id
                                             
      t.timestamps null: false
    end
  end
end
