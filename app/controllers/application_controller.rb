class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user
  skip_before_action :authenticate_user

  private
  # https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/
  def authenticate_user
    redirect_uri = CGI.escape('http://localhost:3000/')
    href = "https://github.com/login/oauth/authorize?
    scope=user&client_id=#{ENV['CLIENT_ID']}&redirect_uri=#{redirect_uri}"
    redirect_to href unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
