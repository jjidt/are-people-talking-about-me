class ApisController < ApplicationController

  def show
    key = params[:key]
    @user = User.find(ApiKey.find_by(access_token: params[:key]).user_id)
    @tweets = []
    @client.search(@user.name, :result_type => "recent").take(20).each do |tweet|
      @tweets << tweet.text
    end
    respond_to do |format|
      format.html { render :json => @tweets }
    end
  end
end
