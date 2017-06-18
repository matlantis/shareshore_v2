class Stockitem < ApplicationRecord
  has_many :articles, inverse_of: :stockitem, dependent: :nullify
  belongs_to :category, dependent: :destroy
  #validates :title_de, presence: true, length: { minimum: 1, maximum: 50 }
  #validates :title_en, presence: true, length: { minimum: 1, maximum: 50 }

  def fill_from_article(article)
    self.title_de = article.title
    self.details_hint_de = article.details
    self.category = Category.find_by(name_en: "")
    self
  end

end
