class DesignationMaster < ActiveRecord::Base
  validates :name, :presence => true
end
