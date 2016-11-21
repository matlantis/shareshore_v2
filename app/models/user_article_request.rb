class UserArticleRequest < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :article

end
