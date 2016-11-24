class Search < ActiveRecord::Base
  belongs_to :location

  geocoded_by :address
  before_validation :geocode, unless: :use_location

  validates :latitude, presence: { message: "The address could not be found" }, unless: :use_location
  validates :longitude, presence: { message: "The address could not be found" }, unless: :use_location
  
  validates :location, presence: true, if: :use_location
  validates :radius, numericality: { greater_than_or_equal_to: 0 }

  def init(request, user)
    self.use_location ||=  !user.nil? && user.locations.count > 0
    if self.use_location
      self.location ||= user.locations.first
    else
      unless self.address
        addr = Geocoder.address(request.remote_ip)
        if addr == "Reserved" # got that for remote_ip localhost
          addr = "Dresden, Germany"
        end
        if addr
          self.address = addr
        end
      end
    end
    self.radius ||= 1.2
  end

  def self.articles_per_page
    100
  end

  def self.locations_per_page
    20
  end
end
