class Article < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  belongs_to :location
  belongs_to :user

  # hack see https://github.com/alexreisner/geocoder/issues/26
  reverse_geocoded_by "locations.latitude", "locations.longitude"

  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :value_eur, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :deposit_eur, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :location, presence: true
  validates :user, presence: true
  validates :gratis, inclusion: { in: [true, false, nil] }
  validates :rate, presence: true, unless: 'gratis'

  def self.search(search)
    where("title LIKE ?", "%#{search}%") 
  end

end
