class UrlsController < ActionController::Base
  def index
  end

  def create

  end

  private

  def url_params
    params.require(:url).permit(:full_url)
  end
end
