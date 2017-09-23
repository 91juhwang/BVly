class WelcomeController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all.order(:access_count).limit(100).reverse
  end
end
