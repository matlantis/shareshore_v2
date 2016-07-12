class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :nickname, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :phoneno, :string
    add_column :users, :showemail, :boolean
    add_column :users, :showphone, :boolean
  end
end
