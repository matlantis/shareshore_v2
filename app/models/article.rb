# coding: utf-8
class Article < ActiveRecord::Base
  attr_accessor :to_be_created
  mount_uploader :picture, PictureUploader

  belongs_to :location
  belongs_to :user
  belongs_to :template

  # hack see https://github.com/alexreisner/geocoder/issues/26
  reverse_geocoded_by "locations.latitude", "locations.longitude"

  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :location, presence: true
  validates :user, presence: true
  validates :rate, presence: true, length: { minimum: 1, maximum: 50 }
  validates :quality, numericality: { only_integer: true, minimum: 1, maximum: 5 }

  after_initialize :init
  
  def init
    self.to_be_created = true
    self.rate ||= "1€/Tag"
    self.quality ||= 3
    self.gratis = false
  end
  
  def self.search(search)
    where("lower(title) LIKE ?", "%#{search.downcase}%") 
  end

  def fill_from_template(template)
    self.to_be_created = false
    self.title = template.title
    self.details = template.details_hint
    self.rate = template.rate
    self.picture = template.picture
    self.template_id = template.id
    self.quality = 3
    self.gratis = false
    self
  end
end
