class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :text
      #t.belongs_to :sender, index: true
      #t.belongs_to :receiver, index: true
      t.integer :sender_id
      t.index :sender_id
      t.integer :receiver_id
      t.index :receiver_id
      t.boolean :with_name
      t.boolean :with_phoneno
      t.boolean :with_email

      t.timestamps
    end
  end
end
