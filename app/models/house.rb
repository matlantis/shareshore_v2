class House < ApplicationRecord
  has_many :locations, dependent: :nullify
  reverse_geocoded_by :latitude, :longitude

  # self destroy if nobody there (seems not to work)
  after_validation :destroy, on: :update, if: :has_no_locations?

  def street_and_no
    [street, number].reject{|e| e.blank?}.join(" ")
  end
  
  def shortaddress
    [street_and_no, city].reject {|e| e.blank?}.join(", ")
  end

  def fulladdress
    [street_and_no, postcode, city, country].reject {|e| e.blank?}.join(", ")
  end

  private
  def has_no_locations?
    locations.count == 0
  end
end
