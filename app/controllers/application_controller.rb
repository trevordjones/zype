class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :user_signed_in?

  def user_signed_in?
    return session[:expires] > Time.now.to_i if session[:access_token].present?
    %i(email access_token refresh_token expires).each do |key|
      session[key] = nil
    end
    false
  end
end
