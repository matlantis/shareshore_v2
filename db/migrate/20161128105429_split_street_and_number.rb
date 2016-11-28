class SplitStreetAndNumber < ActiveRecord::Migration
  def up
    rename_column :locations, :street_and_no, :street
    add_column :locations, :number, :string
    # extract the no from street and put it into number
    Location.all.each do |l|
      # guess every street and no has a house number
      l.number = l.street.split(" ")[-1]
      l.street = l.street.split(" ")[0..-2].join(" ")
      l.save
    end

    rename_column :houses, :street_and_no, :street
    add_column :houses, :number, :string
    # extract the no from street and put it into number
    House.all.each do |l|
      # guess every street and no has a house number
      l.number = l.street.split(" ")[-1]
      l.street = l.street.split(" ")[0..-2].join(" ")
      l.save
    end
  end

  def down
    # join number to street
    Location.all.each do |l|
      l.street = [l.street, l.number].join(" ")
      l.save
    end
    rename_column :locations, :street, :street_and_no
    remove_column :locations, :number

    # join number to street
    House.all.each do |l|
      l.street = [l.street, l.number].join(" ")
      l.save
    end
    rename_column :houses, :street, :street_and_no
    remove_column :houses, :number
  end
end
