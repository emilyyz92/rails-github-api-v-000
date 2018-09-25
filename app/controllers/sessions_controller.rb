class SessionsController < ApplicationController

  CLIENT_ID = ENV['CLIENT_ID']
  CLIENT_SECRET = ENV['CLIENT_SECRET']

  def create
    session_code = params['code']
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      binding.pry
      req.body = {'client_id': CLIENT_ID,
                   'client_secret': CLIENT_SECRET,
                   'code': session_code
                 }
       req.headers['Accept'] = 'application/json'
     end
     access_token = JSON.parse(resp.body)['access_token']
     session[:token] = access_token
     redirect_to root_path
  end
end
