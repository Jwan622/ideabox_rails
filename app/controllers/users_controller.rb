class UsersController < ApplicationController

  def show
    @user = User.find_by(params[:id])
    unless current_user && params[:id].to_i == current_user.id
      flash[:alert] = "Nice try asshole"
      redirect_to "/login" unless current_user
      redirect_to root_path
      authorize! :read, @user   #can the current user read protected user
      #in regards to the authorize! line if we fail, we hit the cancan rescue in the app controller. @user here is the protected user and gets implicitly passed to the Ability class.
    end
  end
end


=begin
rails new <project>
rails g migrations
rails g model maybe?
fixture is a way to create test, go into database when you run a test, just use factorygirl gem
-ian don't use generate much exception for migration
-rails g migration RemoveColumnFromUser
=end
