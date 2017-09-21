class UrlsController < ApplicationController
  def index
  end

  def create
    @url = Url.find_or_create_by(full_url: url_params['full_url'])
    redirect_to url_path(@url.id)
  end

  def show
    url = Url.find(params[:id])
    @shorten_url = url.id.to_s(32)
  end

  def redirect
    url_id = params[:url_id].to_i(32)
    original_url = Url.find(url_id).full_url
    # way to rediret without the host
    redirect_to "https://#{original_url}"
  end

  private

  def url_params
    params.require(:url).permit(:full_url)
  end
end
