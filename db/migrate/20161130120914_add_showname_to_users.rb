class AddShownameToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :showname, :boolean
  end
end
