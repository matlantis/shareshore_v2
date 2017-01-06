class UserArticleRequest < ApplicationRecord
  belongs_to :user, inverse_of: :user_article_requests
  belongs_to :article

  after_initialize :init

  def init
    with_name = false # always hide
  end
end
