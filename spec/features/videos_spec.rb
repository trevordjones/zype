require 'rails_helper'
describe 'videos#index', type: :feature do
  before do
    stub_video_request
    visit videos_path
  end

  it 'shows a list of video thumbnails and titles' do
    thumbnails = find_all('.video-thumbnail')
    expect(thumbnails.size).to eq(stubbed_videos['response'].size)
    thumbnails.each_with_index do |thumbnail, i|
      expect(thumbnail.has_content?(stubbed_videos['response'][i]['title'])).to be_truthy
      image_url = stubbed_videos['response'][i]['thumbnails'][0]['url']
      expect(thumbnail.has_css?("img[src*=#{image_url}]")).to be_truthy
    end
  end
end

describe 'videos#show', type: :feature do
  context 'when a user is not signed in' do
    before do
    end

    it 'shows the details screen of videos that do not require a subscription' do
    end

    it 'shows a subscription paywall of videos that do require a subscription' do
    end
  end

  context 'when a user is signed in' do
    before do
      # click the login button
      # fill in details
      # be sure to stub login first
      # visit videos path
    end

    it 'shows video details for all videos' do
    end
  end
end
