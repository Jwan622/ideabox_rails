class Ability
  include CanCan::Ability

  def initialize(user)  #user here is current_user
    user ||= User.new

    if user.admin?
      can :manage, Idea
    else
      can :read, Idea
    end
  end
end

#look up load and authorize resource cancan methods
