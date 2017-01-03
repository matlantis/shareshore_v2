class UserArticleRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :article

  after_initialize :init

  def init
    with_name = false # always hide
  end
end
