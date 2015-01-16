class UsersController < ApplicationController

  def show
    @user = User.find_by(params[:id])
    # authorize! :read, @user
  end
end
