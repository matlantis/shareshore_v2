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

  after_initialize :init
  
  def init
    self.to_be_created = true
    self.rate_eur ||= 1
    self.rate_interval ||= "day"
    self.quality ||= 3
  end
  
  def self.search(search)
    where("lower(title) LIKE ?", "%#{search.downcase}%") 
  end

  def fill_from_template(template)
    self.to_be_created = false
    self.title = template.title
    self.details = template.details_hint
    self.rate_eur = template.rate_eur
    self.rate_interval = template.rate_interval
    self.picture = template.picture
    self.template_id = template.id
    self.quality = 3
    self
  end
end
