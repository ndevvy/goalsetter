class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def login_user!(user)
    session[:session_token] = user.session_token
  end

  def must_be_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def must_be_object_owner(object)
    unless object.user_id == current_user.id
      flash[:errors] = ["You don't own that"]
      redirect_to users_url
    end
  end

  def must_be_logged_out
    redirect_to user_url(current_user) if logged_in?
  end

end
