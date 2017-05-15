module ApiStubs
  def stub_login
    stub_request(:post, Rails.application.secrets.authentication_url)
      .with(body: stubbed_request)
      .to_return(body: stubbed_response.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def stub_invalid_login
    stub_request(:post, Rails.application.secrets.authentication_url)
      .with(body: invalid_request)
      .to_return(status: 401, body: stubbed_invalid_response.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def stubbed_request
    {
      client_id: Rails.application.secrets.client_id,
      client_secret: Rails.application.secrets.client_secret,
      username: 'email@test.com',
      password: 'password',
      grant_type: 'password'
    }
  end

  def invalid_request
    stubbed_request.except(:password).merge(password: 'badpassword')
  end

  def stubbed_response
    {
      "access_token" => SecureRandom.hex,
      "token_type" => "bearer",
      "expires_in" => 604_800,
      "refresh_token" => SecureRandom.hex,
      "scope" => "consumer",
      "created_at" => 1_494_695_764
    }
  end

  def stubbed_invalid_response
    {
      "error" => "invalid_grant",
      "error_description"=> "there was an error"
    }
  end

  def stub_videos_request(videos = nil)
    videos ||= stubbed_videos
    stub_request(:get, Rails.application.secrets.video_url)
      .with(query: { app_key: Rails.application.secrets.app_key })
      .to_return(body: videos.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def stub_video_request(video)
    stub_request(:get, Rails.application.secrets.video_url + "/#{video['response']['_id']}")
      .with(query: { app_key: Rails.application.secrets.app_key })
      .to_return(body: video.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def stubbed_videos
    response = []
    3.times do |n|
      response << {
        '_id' => SecureRandom.hex,
        'active' => true,
        'subscription_required' => [true, false].sample,
        'title' => "Video #{n}",
        'duration' => rand(10..500),
        'thumbnails' => [
          {
            'aspect_ratio' => 1.33,
            'height' => 90,
            'url' => 'image_url',
            'width' => 120
          }
        ]
      }
    end
    { 'response' => response }
  end

  def stubbed_video(subscription_required = false)
    {
      'response' => {
        '_id' => SecureRandom.hex,
        'active' => true,
        'subscription_required' => subscription_required,
        'title' => "Video Title"
      }
    }
  end
end
