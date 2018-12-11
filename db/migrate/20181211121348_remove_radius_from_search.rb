class RemoveRadiusFromSearch < ActiveRecord::Migration[5.2]
  def change
    remove_column :searches, :radius
  end
end
