class Location < ActiveRecord::Base
  has_many :articles, inverse_of: :location
  belongs_to :user

  geocoded_by :fulladdress   # can also be an IP address
  before_validation :geocode, :if => :address_changed?  # auto-fetch coordinates

  validates :user, presence: true
  validates :latitude, presence: { message: "The address could not be found" }
  validates :longitude, presence: { message: "The address could not be found" }
  
  def fulladdress
    [street_and_no, postcode, city, country].reject {|e| e.blank?}.join(", ")
  end

  def shortaddress
    [street_and_no, city].reject {|e| e.blank?}.join(", ")
  end

  def address_changed?
    attrs = %w(street_and_no postcode city country)
    attrs.any?{|a| send "#{a}_changed?"}
  end
end
