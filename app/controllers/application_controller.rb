class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  CLIENT_ID = ENV['GITHUB_CLIENT_ID']
  CLIENT_SECRET = ENV['GITHUB_CLIENT_SECRET']

  private

  def authenticate_user
    href = "https://github.com/login/oauth/authorize?scope=user&client_id=#{CLIENT_ID}"
    redirect_uri = CGI.escape('http://localhost:3000/auth')
    redirect_to href unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
