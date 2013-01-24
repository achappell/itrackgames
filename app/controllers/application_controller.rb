class ApplicationController < ActionController::Base
  protect_from_forgery
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  unless Rails.env.production?
  ENV['TWITTER_KEY'] = 'xvqB61RpJ7jQyIrGNQ'
  ENV['TWITTER_SECRET'] = 'nmgnTjRnAi6JLs4nu6IXVMVoWSudG3vFPcy24yznoN8'
end
end
