class Location < ActiveRecord::Base
  has_many :articles, inverse_of: :location, dependent: :delete_all
  belongs_to :user
  belongs_to :house

  geocoded_by :fulladdress   # can also be an IP address
  before_validation :re_geocode, :if => :address_changed?  # auto-fetch coordinates

  validates :user, presence: true
  validates :latitude, presence: { message: "The address could not be found" }
  validates :longitude, presence: { message: "The address could not be found" }

  after_validation :joinhouse
  after_save :clean_houses
  after_destroy :clean_houses
  
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

  def re_geocode
    self.longitude = nil
    self.latitude = nil
    geocode
    print "geocoded location"
  end

  def normalize_city
  end

  protected
  def joinhouse
    # find a house which matches the address
    #norm_city = normalize_city(city)
    #norm_postcode = normalize_postcode(postcode)
    #norm_country = normalize_country(country)
    #norm_street_and_no = normalize_street_and_no(street_and_no)
    #houses = House.where("LOWER(city) = ? AND postcode = ? AND country = ? AND street_and_no = ?", city, postcode, country, street_and_no)
    houses = House.near(self, 0.01) # should mean 10 meters
    if ( houses.length > 0)
      self.house = houses.first
    else # or create a new house with a normalized address
      #House.create({city: norm_city, postcode: norm_postcode, country: norm_country, street_ande_no: norm_street_and_no, longitude: longitude, latitude: latitude})
      house = House.create({city: city, postcode: postcode, country: country, street_and_no: street_and_no, longitude: longitude, latitude: latitude})
      self.house = house
    end
  end

  protected
  def clean_houses
    print "clean houses"
    House.all.each do |h|
      h.destroy if h.locations.count == 0
    end
  end
end
