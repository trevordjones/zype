class VideosController < ApplicationController
  def index
    @app_key = Rails.application.secrets.app_key
    resp = HTTParty.get(Rails.application.secrets.video_url, query: { app_key: @app_key })
    @videos = resp.parsed_response['response']
  end

  def show
    @app_key = Rails.application.secrets.app_key
    resp = HTTParty.get(Rails.application.secrets.video_url + "/#{params[:id]}", query: { app_key: @app_key })
    @video = resp.parsed_response['response']
  end
end
