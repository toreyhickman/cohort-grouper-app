class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ensure_signin

  helper_method :signed_in?, :current_token

  def signed_in?
    current_token != nil
  end

  def current_token
    session[:github_token]
  end

  def ensure_signin
    redirect_to signin_path unless signed_in?
  end
end
