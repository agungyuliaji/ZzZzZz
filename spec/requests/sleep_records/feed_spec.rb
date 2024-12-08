require 'rails_helper'

RSpec.describe SleepRecords::FeedController, type: :controller do
  let!(:user) { create(:user) }
  let!(:followed_user) { create(:user) }
  let!(:sleep_record) { create(:sleep_record, user: followed_user) }

  before do
    user.follow(followed_user)
  end

  describe 'GET #my_records' do
    context 'when user exists' do
      before do
        get :my_records, params: { user_id: user.id }, format: :json
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end
    end

    context 'when user does not exist' do
      before do
        get :my_records, params: { user_id: -1 }, format: :json
      end

      it 'returns a 404 response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a user not found message' do
        expect(JSON.parse(response.body)['message']).to eq('user not found')
      end
    end
  end

  describe 'GET #following_records' do
    context 'when user exists' do
      before do
        get :following_records, params: { user_id: user.id }, format: :json
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end
    end

    context 'when user does not exist' do
      before do
        get :following_records, params: { user_id: -1 }, format: :json
      end

      it 'returns a 404 response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a user not found message' do
        expect(JSON.parse(response.body)['message']).to eq('user not found')
      end
    end
  end
end
