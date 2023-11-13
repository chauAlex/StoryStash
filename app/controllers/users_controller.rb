# users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  # GET /users/1 ...
  def show
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User deleted.'
  end
end
