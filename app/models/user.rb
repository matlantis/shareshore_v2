class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations, inverse_of: :user, dependent: :delete_all
  has_many :articles, inverse_of: :user, dependent: :delete_all
  
  #validates :role, inclusion: { in: %w(admin user) }
  validates :nickname, uniqueness: true,
            format: { with: /[a-zA-Z0-9\.\-_]+/ }
  validates :phoneno, format: { with: /[a-zA-Z0-9\- ]*/ }
  
  def fullname
    name = ""
    if firstname
      name += String(firstname) + " "
    end
    name += String(lastname)
  end
end
