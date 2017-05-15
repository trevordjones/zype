class VideosController < ApplicationController
  def index
    resp = HTTParty.get(Rails.application.secrets.video_url, query: { app_key: Rails.application.secrets.app_key} )
    @app_key = Rails.application.secrets.app_key
    @videos = resp.parsed_response['response']
  end
end
