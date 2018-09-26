class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']

  def create
    session_code = params['code']
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.body = {'client_id': CLIENT_ID,
                   'client_secret': CLIENT_SECRET,
                   'code': session_code,
                   'scope': 'repo, user'
                 }
       req.headers['Accept'] = 'application/json'
     end
     binding.pry
     session[:token] = JSON.parse(resp.body)['access_token']
     session[:scope] = JSON.parse(resp.body)['scope'].split(',')
     redirect_to root_path
  end
end
