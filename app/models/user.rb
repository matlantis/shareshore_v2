class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations, inverse_of: :user
  has_many :articles, inverse_of: :user
  
  #validates :role, inclusion: { in: %w(admin user) }
  validates :nickname, uniqueness: true,
            format: { with: /[a-zA-Z0-9\.\-_]+/ }
  validates :phoneno, format: { with: /[a-zA-Z0-9\- ]*/ }
  
  def fullname
    if firstname
      name = firstname + " "
    end
    name += lastname
  end
end
