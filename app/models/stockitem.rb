class Stockitem < ApplicationRecord
  has_many :articles, inverse_of: :stockitem, dependent: :nullify

  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :rate, presence: true, length: { minimum: 1, maximum: 50 }

  def fill_from_article(article)
    self.title = article.title
    self.details_hint = article.details
    #self.rate = article.rate
    self.room = ""
    self
  end

end
