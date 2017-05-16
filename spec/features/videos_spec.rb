require 'rails_helper'
describe 'videos#index', type: :feature do
  before do
    stub_videos_request
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
  before { stub_videos_request }
  context 'when a user is not signed in' do
    before { page.driver.submit :delete, sign_out_path, {} }

    context 'when a video is subscription only' do
      before do
        video = stubbed_video(true)
        stub_video_request(video)
        visit video_path(video['response']['_id'])
      end

      it 'shows a subscription paywall' do
        expect(page).to have_selector('#paywall', visible: true)
        expect(page).to_not have_selector('.details')
      end
    end

    context 'when a video is not subscription only' do
      before do
        video = stubbed_video(false)
        stub_video_request(video)
        visit video_path(video['response']['_id'])
      end

      it 'shows the details screen' do
        expect(page).to_not have_selector('#paywall')
        expect(page).to have_selector('.details')
      end
    end
  end

  context 'when a user is signed in' do
    before do
      stub_login
      visit root_path
      click_link 'Login'
      fill_in 'Email', with: 'email@test.com'
      fill_in 'Password', with: 'password'
      click_button 'Login'
      video = stubbed_video(true)
      stub_video_request(video)
      visit video_path(video['response']['_id'])
    end

    it 'shows video details for a subscriber only video' do
      expect(page).to_not have_selector('#paywall')
    end
  end
end
