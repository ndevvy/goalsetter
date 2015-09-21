class UsersController < ApplicationController

before_action :must_be_logged_in, only: [:index, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @outstanding_goals = @user.goals.where(completed: false)
    @completed_goals = @user.goals.where(completed: true)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
