class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, alert: 'Please Sign in or Sign up to aceess this feature.'
    end
  end
end
