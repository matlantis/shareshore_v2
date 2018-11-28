class RemoveNameFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_columns :users, :firstname, :lastname, :showname
  end
end
