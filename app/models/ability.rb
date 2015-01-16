class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, User, id: user.id   #can read any User object if the current user id is the same.
  end
end
