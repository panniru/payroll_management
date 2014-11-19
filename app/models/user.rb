class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable 
  belongs_to :role

 
  
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
