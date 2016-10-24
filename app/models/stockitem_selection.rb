class StockitemSelection < ActiveRecord::Base
  has_and_belongs_to_many :stockitems
end
