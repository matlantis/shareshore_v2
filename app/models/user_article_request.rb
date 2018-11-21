class ContactMethodValidator < ActiveModel::Validator
  def validate(request)
    if !request.with_phoneno && !request.with_email
      request.errors[:base] << I18n.t("user_article_requests.no_contact_method")
    end
  end
end

class UserArticleRequest < ApplicationRecord
  belongs_to :user, inverse_of: :user_article_requests
  belongs_to :article

  #validates_with ContactMethodValidator

  after_initialize :init

  def init
    self.with_name ||= false # always hide
    self.with_phoneno ||= false # always hide
    self.with_email ||= false # always hide
  end
end
