class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations, inverse_of: :user, dependent: :delete_all
  has_many :articles, inverse_of: :user, dependent: :delete_all

  accepts_nested_attributes_for :articles
  accepts_nested_attributes_for :locations, reject_if: :all_blank
  
  #validates :role, inclusion: { in: %w(admin user) }
  validates :nickname, uniqueness: true,
            format: { with: /\A[a-zA-Z0-9\.\-_]+\z/ }
  validates :phoneno, format: { with: /\A[a-zA-Z0-9\- ]*\z/ }

  validates :terms, acceptance: true
  
  def fullname
    name = ""
    if firstname
      name += String(firstname) + " "
    end
    name += String(lastname)
  end

  protected
  def confirmation_required?
    true # to disable confirmation stuff set to false
  end
end
