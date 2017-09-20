class WelcomeController < ActionController::Base
  def index
    @url = Url.new
  end
end
