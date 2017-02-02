class AddHtmlTextToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :html, :string
  end
end
