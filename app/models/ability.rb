class Ability
  include CanCan::Ability

  def initialize(user)  #user here is current_user
    user ||= User.new
    can :read, User, id: user.id   #user.id is the id of current_user, id: checks against the id of the @user that we pass into the authorize! method. #can read any User object if the current user id is the same.
  end
end
