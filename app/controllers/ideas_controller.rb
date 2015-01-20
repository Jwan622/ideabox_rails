class IdeasController < ApplicationController
  # before_action :admin?, only[:new, :create]

  def index

  end

  def new
    @idea = Idea.new
    authorize!(:create, @idea)
    # @user = User.find(params[:user_id])
  end

  def create
    user_params_id.ideas.create(ideas_params)
    redirect_to user_path(user_params_id)
  end

  private

  # def admin?
  #   current_user.role == "admin"
  # end

  def user_params_id
    User.find(params[:user_id])
  end

  def ideas_params
    params.require(:ideas).permit(:name)
  end
end
# pretend User has a role attribute
