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
    binding.pry
    @login = JSON.parse(resp_login.body)['login']
    @repos = JSON.parse(resp_repo.body)
  end

  def create
    resp_create =
    Faraday.post('https://api.github.com/user/repos') do |req|
      req_auth(req)
      req.params['name'] = params[:name]
    end
    binding.pry
    if resp_create.success?
      redirect_to root_path
    else
      puts resp_create['status']
    end
  end


end
