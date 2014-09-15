class UsersController < ApplicationController
  before_filter :restrict_access, only: :show
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = []
    @client.search(@user.name, :result_type => "recent").take(20).each do |tweet|
      @tweets << tweet.text
    end
    respond_to do |format|
      format.html
      format.json { render :json => @tweets}
    end
  end

private
  def restrict_access
    if format_json?
      authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
      end
    end
  end

  def format_json?
    request.format.json?
  end
end
