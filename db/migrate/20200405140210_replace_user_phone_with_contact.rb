class ReplaceUserPhoneWithContact < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :phoneno
    remove_column :users, :showphone

    add_column :users, :contact, :string
  end
end
