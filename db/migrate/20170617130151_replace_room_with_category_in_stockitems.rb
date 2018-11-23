class ReplaceRoomWithCategoryInStockitems < ActiveRecord::Migration[5.0]
  def up
    add_reference :stockitems, :category, index: true, foreign_key: true
    # check if category with name_de 'room' already exists and create if not
    Stockitem.all.each do |a|
      cat = Category.find_by(name_de: a.room)
      if cat
        c = cat
      else
        c = Category.create(name_de: a.room, name_en: a.room)
      end
      # set category
      a.category_id = c.id
      a.save
    end
    remove_column :stockitems, :room
  end

  def down
    add_column :stockitems, room: :string
    # set room of each stockitem
    Stockitem.all.each do |a|
      a.room = a.category.name_de
      a.save
    end

    remove_reference :stockitems, :category, index: true, foreign_key: true
  end
end
