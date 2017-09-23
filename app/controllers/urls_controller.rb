class UrlsController < ApplicationController
  def index
  end

  def create
    full_url = Url.url_to_external(url_params['full_url'])
    url_record = Url.find_or_create_by(full_url: full_url)
    @original_url = url_record.full_url
    @encoded_url = url_record.id.to_s(36)
    @urls = Url.all.order(:access_count).limit(100)
    respond_to { |format| format.js }
  end

  def show
  end

  def redirect
    decoded_url = params[:id].to_i(36)
    redirect_to Url.find(decoded_url).full_url
  end

  private

  def url_params
    params.require(:url).permit(:full_url)
  end
end
