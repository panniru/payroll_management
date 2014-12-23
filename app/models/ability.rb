class Ability  
  include CanCan::Ability  
  user ||= User.new
  def initialize(user) 
    alias_action :map, :to => :create
    alias_action :save_designation, :to => :create
    user ||= User.new
    return false if user == nil
    if user.manager? or user.director?
      can :manage, :all
    else
      can :manage, :all
    end
  end  
end  
