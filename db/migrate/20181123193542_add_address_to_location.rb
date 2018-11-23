def country_name(l)
  country = ISO3166::Country[l.country]
  if country
    country.translations[I18n.locale.to_s] || country.name
  else
    l.country
  end
end

def street_and_no(l)
  [l.street, l.number].reject{|e| e.blank?}.join(" ")
end

def fulladdress(l)
  [street_and_no(l), l.postcode, l.city, country_name(l)].reject {|e| e.blank?}.join(", ")
end

class AddAddressToLocation < ActiveRecord::Migration[5.2]
  def up
    # locations
    add_column :locations, :address, :string
    # houses
    add_column :houses, :address, :string

    # merge street, number, postal, city into address
    Location.all.each do |l|
      l.address = fulladdress(l)
      l.save
    end

    remove_column :locations, :street
    remove_column :locations, :postcode
    remove_column :locations, :city
    remove_column :locations, :number

    # merge street, number, postal, city into address
    House.all.each do |l|
      l.address = fulladdress(l)
      l.save
    end

    remove_column :houses, :street
    remove_column :houses, :postcode
    remove_column :houses, :city
    remove_column :houses, :number
  end

  def down
    # locations
    add_column :locations, :street, :string
    add_column :locations, :postcode, :string
    add_column :locations, :city, :string
    add_column :locations, :number, :string

    # just paste the address line into the city
    Location.all.each do |l|
      l.city = l.address
      l.save
    end
    remove_column :locations, :address

    # houses
    add_column :houses, :street, :string
    add_column :houses, :postcode, :string
    add_column :houses, :city, :string
    add_column :houses, :number, :string

    # just paste the address line into the city
    House.all.each do |l|
      l.city = l.address
      l.save
    end
    remove_column :houses, :address
  end
end
