class AddHowtoToSearch < ActiveRecord::Migration[5.0]
  def down
    remove_column :searches, :howto
  end

  def up
    add_column :searches, :howto, :string
    Search.all.each do |s|
      s.update({howto: "foot"})
      #s.save()
    end
  end
end
