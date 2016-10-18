class Template < ActiveRecord::Base
  has_many :articles, inverse_of: :template, dependent: :nullify

  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :rate, presence: true, length: { minimum: 1, maximum: 50 }

end
