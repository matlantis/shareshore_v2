class UserArticleRequest < ApplicationRecord
  belongs_to :user, inverse_of: :user_article_requests
  belongs_to :article
end
