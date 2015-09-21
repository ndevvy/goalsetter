class GoalsController < ApplicationController

  before_action :must_be_logged_in
  before_action :must_be_goal_owner, only: [:edit, :destroy, :update, :complete_goal]


  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      flash[:messages] = ["Goal created!"]
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      flash[:messages] = ['Goal updated!']
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:messages] = ['Goal deleted!']
    redirect_to user_url(current_user)
  end

  def show
    @goal = Goal.find(params[:id])
    if !@goal
      flash[:errors] = ['Invalid goal']
      redirect_to users_url
    end
  end

  def complete_goal
    @goal = Goal.find(params[:id])
    @goal.completed = true
    @goal.save
    flash[:messages] = ["Goal completed! Yay! Good job!!!"]
    redirect_to(:back)
  end
  private

  def goal_params
    params.require(:goal).permit(:title, :text, :personal)
  end

  def must_be_goal_owner
    must_be_object_owner(Goal.find(params[:id]))
  end

end
