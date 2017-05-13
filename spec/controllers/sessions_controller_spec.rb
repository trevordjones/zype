require 'rails_helper'

describe SessionsController, type: :controller do
  describe '#create' do

    context 'with valid credentials' do
      before do
        stub_login
        post :create, params: { email: 'email@test.com', password: 'password' }
      end

      it 'stores the access and refresh tokens' do
        %i(access_token refresh_token).each do |key|
          expect(controller.session[key]).to_not be_nil
        end
      end

      it 'stores an expires amount that is greater than current time' do
        expect(controller.session[:expires]).to_not be_nil
        expect(controller.session[:expires]).to be > Time.now.to_i
      end

      it 'redirects to videos_path and displays success message' do
        expect(response).to redirect_to(videos_path)
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'redirects to videos_path and displays error' do
        stub_invalid_login
        post :create, params: { email: 'email@test.com', password: 'badpassword' }
        expect(response).to redirect_to(videos_path)
        expect(flash[:error]).to be_present
      end
    end
  end
end
