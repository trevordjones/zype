require 'rails_helper'

describe VideosController, type: :controller do
  let(:videos) { stubbed_videos }
  describe '#index' do
    before do
      stub_video_request(videos)
      get :index
    end

    it { is_expected.to render_template :index }
    it { expect(assigns(:videos)).to eq(videos['response']) }
  end
end
