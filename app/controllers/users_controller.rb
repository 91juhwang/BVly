class UsersController < ApplicationController
  before_action :top_hundred_records, only: [:index, :create]

  def show
    @url = Url.new
    @urls = recent_hundred_links
  end

  def create
    # full_url = Url.url_to_external(url_params['full_url'])
    # url_record = Url.find_or_create_by(full_url: full_url)
    # @original_url = url_record.full_url
    # @encoded_url = url_record.id.to_s(36)
    # respond_to { |format| format.js }
  end

  def redirect
    # decoded_url = params[:id].to_i(36)
    # found_url = Url.find(decoded_url)
    # found_url.update_attributes(access_count: Url.update_access_count(found_url))
    # redirect_to found_url.full_url
  end

  private

  def recent_hundred_links
    @urls = UserUrls.all.order(:created_at).limit(100)
  end

  def url_params
    params.require(:url).permit(:full_url)
  end
end
