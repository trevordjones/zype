class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
    return session[:expires] > Time.now.to_i if session[:access_key].present?
    false
  end
end
