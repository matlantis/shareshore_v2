class AddUuidsToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :private_uuid, :string
    add_column :users, :public_uuid, :string

    User.all.each do |u|
      u.update({private_uuid: SecureRandom.uuid, public_uuid: SecureRandom.uuid})
    end

  end

  def down
    add_column :users, :private_uuid, :string
    add_column :users, :public_uuid, :string
  end
end
