class AddShownameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :showname, :boolean
  end
end
