class Stockitem < ApplicationRecord
  has_many :articles, inverse_of: :stockitem, dependent: :nullify
  belongs_to :category, dependent: :destroy

  def fill_from_article(article)
    self.title_de = article.title
    self.details_hint_de = article.details
    self.category = Category.find_by(name_en: "")
    self
  end

end
