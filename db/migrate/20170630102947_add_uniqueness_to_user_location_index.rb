class AddUniquenessToUserLocationIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :locations, :user_id
    add_index :locations, :user_id, unique: true
  end
end
