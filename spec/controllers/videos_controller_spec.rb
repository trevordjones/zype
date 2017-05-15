require 'rails_helper'

describe VideosController, type: :controller do
  let(:videos) { stubbed_videos }

  describe '#index' do
    before do
      stub_videos_request(videos)
      get :index
    end

    it { is_expected.to render_template :index }
    it { expect(assigns(:videos)).to eq(videos['response']) }
  end

  describe '#show' do
    let(:video) { stubbed_video(false) }

    before do
      stub_video_request(video)
      get :show, params: { id: video['response']['_id'] }
    end

    it { is_expected.to render_template :show }
    it { expect(assigns(:video)).to eq(video['response']) }
  end
end
