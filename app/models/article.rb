class Article < ActiveRecord::Base
  attr_accessor :to_be_created
  mount_uploader :picture, PictureUploader

  belongs_to :location
  belongs_to :user
  has_one :template

  # hack see https://github.com/alexreisner/geocoder/issues/26
  reverse_geocoded_by "locations.latitude", "locations.longitude"

  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :location, presence: true
  validates :user, presence: true
  validates :rate_eur, numericality: { greater_than_or_equal_to: 0 }
  validates :rate_interval, presence: true, length: { minimum: 1, maximum: 50 }
  validates :quality, numericality: { only_integer: true, minimum: 1, maximum: 5 }
  
  def self.search(search)
    where("lower(title) LIKE ?", "%#{search.downcase}%") 
  end

end
