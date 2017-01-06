# coding: utf-8
class Article < ApplicationRecord
  attr_accessor :to_be_created
  mount_uploader :picture, PictureUploader

  belongs_to :location
  belongs_to :user
  belongs_to :stockitem, optional: true

  # hack see https://github.com/alexreisner/geocoder/issues/26
  reverse_geocoded_by "locations.latitude", "locations.longitude"

  validates :title, length: { minimum: 1, maximum: 50 }
  #validates :location, presence: true # auto in rails 5
  #validates :user, presence: true # auto in rails 5
  validates :rate, length: { minimum: 1, maximum: 50 }
  validates :quality, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  after_initialize :init

  def init
    self.to_be_created = true
    self.rate ||= "1€/Tag"
    self.quality ||= 3
    self.gratis ||= false
  end
  
  def self.search(search)
    where("lower(title) LIKE ?", "%#{search.downcase}%") 
  end

  def fill_from_stockitem(stockitem)
    self.to_be_created = false
    self.title = stockitem.title
    self.details = stockitem.details_hint
    self.rate = stockitem.rate
    self.picture = stockitem.picture
    self.stockitem_id = stockitem.id
    self.quality = 3
    self.gratis = false
    self
  end
end
