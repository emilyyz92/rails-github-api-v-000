class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    session_code = params['rack.request.query_hash']['code']
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.body = "{client_id: #{CLIENT_ID},
                   client_secret: #{CLIENT_SECRET},
                   code: #{session_code},
                   accept: :json}"
     end
     access_token = JSON.parse(resp)['access_token']
     session[:token] = access_token
  end
end
