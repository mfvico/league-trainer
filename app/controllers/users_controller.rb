class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user_params=params.require(:user).permit(:first_name, :last_name, :summoner, :email)
    @user = User.new(user_params)
    @user.save
    redirect_to users_path
  end

end
