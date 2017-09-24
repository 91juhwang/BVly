class WelcomeController < ApplicationController
  def index
    redirect_to urls_path
  end
end