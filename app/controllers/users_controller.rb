# users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def incr_balance
    @user = User.find(params[:id])
    User.increment_counter(:balance, @user.id)

    redirect_to user_path
  end

  def decr_balance
    @user = User.find(params[:id])
    User.decrement_counter(:balance, @user.id)

    redirect_to user_path
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
