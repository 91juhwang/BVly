class UrlsController < ApplicationController
  before_action :find_url, except: [:create, :index]
  def index
  end

  def create
    full_url = Url.url_to_external(url_params['full_url'])
    url = Url.find_or_create_by(full_url: full_url.downcase)
    redirect_to url_path(url.id)
  end

  def show
    @original_url = @found_url.full_url
    @encoded_url = @found_url.id.to_s(32)
  end

  def redirect
    decoded_url = params[:id].to_i(32)
    redirect_to Url.find(decoded_url).full_url
  end

  private

  def find_url
    @found_url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(:full_url)
  end
end
