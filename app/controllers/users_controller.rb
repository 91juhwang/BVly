class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_urls = current_user.urls
    recent_hundred_links
    top_hundred_links
  end

  private

  def recent_hundred_links
    @recent_urls = current_user.urls.order(created_at: :desc).limit(30)
  end

  def top_hundred_links
    @urls = current_user.urls.order(access_count: :desc).limit(100)
  end

  def url_params
    params.require(:url).permit(:full_url)
  end
end
