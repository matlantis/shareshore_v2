class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations, inverse_of: :user, dependent: :destroy
  has_many :articles, inverse_of: :user, dependent: :destroy
  has_many :user_article_requests, inverse_of: :user, dependent: :destroy

  accepts_nested_attributes_for :articles
  accepts_nested_attributes_for :locations, reject_if: :all_blank
  
  after_initialize :init
  
  #validates :role, inclusion: { in: %w(admin user) }
  validates :nickname, uniqueness: true, length: { minimum: 1, maximum: 50 }
            # format: { with: /\A[a-zA-Z0-9\.\-_]+\z/ }
  validates :phoneno, format: { with: /\A[a-zA-Z0-9\- ]*\z/ }
  validates :uuid_private, uniqueness: true, format: { with: /[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}/ }
  validates :uuid_public, uniqueness: true, format: { with: /[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}/ }
  validates :terms, acceptance: true

  def init
    uuid_private = SecureRandom.uuid
    uuid_public = SecureRandom.uuid
    showemail ||= false
    showphone ||= false
    showname ||= false
  end
  
  def fullname
    [firstname, lastname].reject {|e| e.blank?}.join(" ")
  end

  def phoneno_or_none
    (phoneno.blank?)? I18n.t("common.none_given") : phoneno
  end

  def email_or_none
    (email.blank?)? I18n.t("common.none_given") : email
  end

  def fullname_or_none
    (fullname.blank?)? I18n.t("common.none_given") : fullname
  end

  protected
  def confirmation_required?
    true # to disable confirmation stuff set to false
  end
end
