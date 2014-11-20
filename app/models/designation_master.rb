class DesignationMaster < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :role
  scope :has_no_admin  , lambda{where(:managed_by  => nil )}
  def masterind(params)
    p "2222222222"
    p params
    
  end
end
