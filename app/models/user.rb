class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable , :authentication_keys => [:login]
  belongs_to :role
  attr_accessor :login

  def login=(login)
    @login = login
  end
  
  def login
    @login || self.user_id || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(user_id) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  
  def role_code
    self.role.code
  end

  def manager?
    role_code == "manager"
  end
  
  def director
    role_code == "director"
  end
  
  def accountant
    role_code == "accountant"
  end
end
