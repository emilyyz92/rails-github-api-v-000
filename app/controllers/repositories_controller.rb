class RepositoriesController < ApplicationController

  def index
    #get the authenticated user: https://developer.github.com/v3/users/#get-the-authenticated-user
    resp_login = Faraday.get('https://api.github.com/user') do |req|
      req_auth(req)
    end
    repo_url = JSON.parse(resp_login.body)['repos_url']
    binding.pry
    resp_repo = Faraday.get(repo_url) do |req|
      req_auth(req)
    end
    @login = JSON.parse(resp_login.body)['login']
    @repos = JSON.parse(resp_repo.body)
  end

  def create
  end

  private

  def req_auth(req)
    req.params['client_id'] = ENV['CLIENT_ID']
    req.params['client_secret'] = ENV['CLIENT_SECRET']
    req.params['access_token'] = session[:token]
  end

end
