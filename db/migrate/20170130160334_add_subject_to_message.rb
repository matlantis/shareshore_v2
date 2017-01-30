class AddSubjectToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :subject, :string
  end
end
