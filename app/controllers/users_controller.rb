class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = []
    @client.search(@user.name, :result_type => "recent").take(20).each do |tweet|
      @tweets << tweet.text
    end
  end
end
