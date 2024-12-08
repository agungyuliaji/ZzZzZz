require 'rails_helper'

RSpec.describe SocialController, type: :controller do
  let(:user) { create(:user) }
  let(:target_user) { create(:user) }

  describe 'POST #follow' do
    context 'when user and target user exist' do
      before do
        post :follow, params: { user_id: user.id, target_user_id: target_user.id }
      end

      it 'returns a success message' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'ok' })
      end
    end

    context 'when user does not exist' do
      before do
        post :follow, params: { user_id: 999, target_user_id: target_user.id }
      end

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'user not found' })
      end
    end

    context 'when target user does not exist' do
      before do
        post :follow, params: { user_id: user.id, target_user_id: 999 }
      end

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'target user not found' })
      end
    end
  end

  describe 'POST #unfollow' do
    context 'when user and target user exist' do
      before do
        post :follow, params: { user_id: user.id, target_user_id: target_user.id }
        post :unfollow, params: { user_id: user.id, target_user_id: target_user.id }
      end

      it 'returns a success message' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'ok' })
      end
    end

    context 'when user does not exist' do
      before do
        post :unfollow, params: { user_id: 999, target_user_id: target_user.id }
      end

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'user not found' })
      end
    end

    context 'when target user does not exist' do
      before do
        post :unfollow, params: { user_id: user.id, target_user_id: 999 }
      end

      it 'returns a not found message' do
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'target user not found' })
      end
    end
  end
end
