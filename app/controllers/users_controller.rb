class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @new_user = true
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    user_params=params.require(:user).permit(:first_name, :last_name, :summoner, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    @user.save
    redirect_to users_path
  end

  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :summoner, :email)
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

end
