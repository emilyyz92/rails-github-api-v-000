class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    session_code = params['code']
    binding.pry
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.body = "{'client_id': #{CLIENT_ID},
                   'client_secret': #{CLIENT_SECRET},
                   'code': #{session_code},
                   'redirect_uri': #{root_path},
                   'state': #{STATE}}"
       req.headers['Accept'] = 'application/json'
     end
     access_token = JSON.parse(resp.body)['access_token']
     session[:token] = access_token
     redirect_to root_path
  end
end
