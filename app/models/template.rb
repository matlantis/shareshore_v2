class Template < ActiveRecord::Base
  has_many :articles, inverse_of: :template, dependent: :nullify

  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :rate_eur, numericality: { greater_than_or_equal_to: 0 }
  validates :rate_interval, presence: true, length: { minimum: 1, maximum: 50 }

end
