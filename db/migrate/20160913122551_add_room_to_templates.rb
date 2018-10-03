class AddRoomToTemplates < ActiveRecord::Migration[4.2]
  def change
    add_column :templates, :room, :string
  end
end
