# coding: utf-8
class Article < ApplicationRecord
  attr_accessor :to_be_created

  belongs_to :location
  belongs_to :stockitem, optional: true

  has_many :user_article_requests, inverse_of: :article, dependent: :destroy
  # hack see https://github.com/alexreisner/geocoder/issues/26
  reverse_geocoded_by "locations.latitude", "locations.longitude"

  validates :title, length: { minimum: 1, maximum: 50 }
  validates :rate, inclusion: ArticlesHelper::RateModel.list_models

  after_initialize :init

  def init
    self.to_be_created = true
    self.rate ||= ArticlesHelper::RateModel.list_models[0]
  end

  def fill_from_stockitem(stockitem)
    self.to_be_created = false
    self.title = stockitem["title_" + I18n.locale.to_s]
    self.details = stockitem["details_hint_" + I18n.locale.to_s]
    self.rate = ArticlesHelper::RateModel.list_models[0]
    self.stockitem_id = stockitem.id
    self
  end

  def user
    location.user
  end
end
