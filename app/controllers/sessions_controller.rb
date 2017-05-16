class SessionsController < ApplicationController
  def create
    resp = HTTParty.post(Rails.application.secrets.authentication_url, zype_options)
    if resp.code == 200
      flash[:success] = 'Successfully authenticated'
      %w(access_token refresh_token).each do |key|
        session[key.to_sym] = resp.parsed_response[key]
      end
      session[:email] = params[:email]
      session[:expires] = Time.now.to_i + resp.parsed_response['expires_in']
    else
      flash[:danger] = 'Username or password incorrect'
    end
    redirect_to request.referer || videos_path
  end

  def destroy
    %i(email access_token refresh_token expires).each do |key|
      session[key] = nil
    end
    flash[:success] = 'Signed out!'
    redirect_to videos_path
  end

  private

  def zype_options
    {
      body: {
        client_id: Rails.application.secrets.client_id,
        client_secret: Rails.application.secrets.client_secret,
        username: params[:email],
        password: params[:password],
        grant_type: 'password'
      }
    }
  end
end
