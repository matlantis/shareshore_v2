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

  validates :terms, acceptance: true

  def init
    showemail ||= false
    showphone ||= false
    showname ||= false
  end
  
  def fullname
    [firstname, lastname].reject {|e| e.blank?}.join(" ")
  end

  protected
  def confirmation_required?
    true # to disable confirmation stuff set to false
  end

end
