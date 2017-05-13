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
end
