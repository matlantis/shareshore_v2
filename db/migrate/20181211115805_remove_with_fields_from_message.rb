class RemoveWithFieldsFromMessage < ActiveRecord::Migration[5.2]
  def change
    remove_columns :messages, :with_email, :with_name, :with_phoneno
  end
end
