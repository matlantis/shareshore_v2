class Template < ActiveRecord::Base
  has_many :articles, inverse_of: :template, dependent: :nullify
end
