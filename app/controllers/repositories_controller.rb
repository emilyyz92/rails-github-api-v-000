class RepositoriesController < ApplicationController

  def index
    #get the authenticated user: https://developer.github.com/v3/users/#get-the-authenticated-user
    resp_login = Faraday.get('https://api.github.com/user') do |req|
      req_auth(req)
    end
    repo_url = JSON.parse(resp_login.body)['repos_url']
    resp_repo = Faraday.get(repo_url) do |req|
      req_auth(req)
    end
    @login = JSON.parse(resp_login.body)['login']
    @repos = JSON.parse(resp_repo.body)
  end

  def create
    resp_create =
    Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = {'client_id': ENV['CLIENT_ID'],
                  'client_secret': ENV['CLIENT_SECRET'],
                  'access_token': session[:token],
                  'name': params[:name]
                 }
    end
    redirect_to root_path
  end


end
