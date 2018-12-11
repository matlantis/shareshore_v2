class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :location, inverse_of: :user, dependent: :destroy
  has_many :user_article_requests, inverse_of: :user, dependent: :destroy

  accepts_nested_attributes_for :location, reject_if: :all_blank

  after_initialize :init

  validates :nickname, uniqueness: true, length: { minimum: 1, maximum: 50 }
  validates :location, presence: true
  validates :phoneno, format: { with: /\A[a-zA-Z0-9\- ]*\z/ }
  validates :private_uuid, uniqueness: true, format: { with: /[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}/ }
  validates :public_uuid, uniqueness: true, format: { with: /[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}/ }
  validates :terms, acceptance: true

  def init
    self.private_uuid ||= SecureRandom.uuid
    self.public_uuid ||= SecureRandom.uuid
    self.showemail ||= false
    self.showphone ||= false
    self.location ||= Location.new
  end

  def articles
    Article.includes(:location).where(locations: {user_id: self.id})
  end

  protected
  def confirmation_required?
    true # to disable confirmation stuff set to false
  end
end
