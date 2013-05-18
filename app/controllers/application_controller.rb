class ApplicationController < ActionController::Base
  protect_from_forgery
  private

  before_filter :after_token_authentication

  def after_token_authentication
    if params[:auth_token].present?
      @user = User.find_by_authentication_token(params[:authentication_key])
      sign_in @user if @user
    end
  end
end
