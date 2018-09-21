class RepositoriesController < ApplicationController

  def index
    #get the authenticated user: https://developer.github.com/v3/users/#get-the-authenticated-user
    resp_login = Faraday.get('https://api.github.com/user') do |req|
      req.params['client_id'] = CLIENT_ID
      req.params['client_secret'] = CLIENT_SECRET
      req.params[access_token] = session[:token]
    end
    @login = JSON.parse(resp_login)['login']
    repo_url = JSON.parse(resp_login)['repos_url']
    resp_repo = Faraday.get
  end

  def create
  end

end
