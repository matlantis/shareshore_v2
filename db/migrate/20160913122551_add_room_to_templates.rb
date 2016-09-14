class AddRoomToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :room, :string
  end
end
