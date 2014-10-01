class SessionsController < ApplicationController
  def new
  end

  def destroy
    session[:github_token] = nil
    flash[:notice] = "You've successfully logged out."
    redirect_to signin_path
  end

  def create
    auth = request.env["omniauth.auth"]
    github_token = auth.credentials.token
    username = auth.info.nickname

    user = GitHubUser.new(username: username, github_token: github_token)

    if user.devbootcamp_owner?(username)
      session[:github_token] = github_token
      redirect_to cohorts_path
    else
      flash[:notice] = "You're not a DevBootcamp employee."
      redirect_to signin_path
    end
  end

  def failure
    flash[:notice] = params[:message]
    redirect_to signin_path
  end
end
