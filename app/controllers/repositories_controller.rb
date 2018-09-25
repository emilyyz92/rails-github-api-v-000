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
  end


end
