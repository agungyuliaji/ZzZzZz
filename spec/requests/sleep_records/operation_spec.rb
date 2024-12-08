require 'rails_helper'

RSpec.describe SleepRecords::OperationController, type: :controller do
  let(:user) { create(:user) }
  let(:user_id) { user.id }

  describe 'GET #sleep' do
    context 'when user is found' do
      before do
        allow(User).to receive(:find_by_id).and_return(user)
      end

      context 'when sleep operation is successful' do
        it 'returns a success message' do
          allow(user).to receive(:sleep!).and_return(true)

          get :sleep, params: { user_id: user_id }

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq({ 'message' => 'ok', 'data' => user.as_json })
        end
      end

      context 'when sleep operation fails' do
        it 'returns a failure message' do
          allow(user).to receive(:sleep!).and_return(false)
          allow(user).to receive(:errors).and_return({ base: ['Sleep operation failed'] })

          get :sleep, params: { user_id: user_id }

          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)).to eq({ 'message' => 'failed', 'errors' => { 'base' => ['Sleep operation failed'] } })
        end
      end
    end

    context 'when user is not found' do
      it 'returns a 404 not found message' do
        allow(User).to receive(:find_by_id).and_return(nil)

        get :sleep, params: { user_id: user_id }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'user not found' })
      end
    end
  end

  describe 'GET #wake_up' do
    context 'when user is found' do
      before do
        allow(User).to receive(:find_by_id).and_return(user)
      end

      context 'when wake up operation is successful' do
        it 'returns a success message' do
          allow(user).to receive(:wake_up!).and_return(true)

          get :wake_up, params: { user_id: user_id }

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq({ 'message' => 'ok', 'data' => user.as_json })
        end
      end

      context 'when wake up operation fails' do
        it 'returns a failure message' do
          allow(user).to receive(:wake_up!).and_return(false)
          allow(user).to receive(:errors).and_return({ base: ['Wake up operation failed'] })

          get :wake_up, params: { user_id: user_id }

          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)).to eq({ 'message' => 'failed', 'errors' => { 'base' => ['Wake up operation failed'] } })
        end
      end
    end

    context 'when user is not found' do
      it 'returns a 404 not found message' do
        allow(User).to receive(:find_by_id).and_return(nil)

        get :wake_up, params: { user_id: user_id }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'user not found' })
      end
    end
  end

  describe 'GET #reset' do
    context 'when user is found' do
      before do
        allow(User).to receive(:find_by_id).and_return(user)
      end

      context 'when reset operation is successful' do
        it 'returns a success message' do
          allow(user).to receive(:reset!).and_return(true)

          get :reset, params: { user_id: user_id }

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq({ 'message' => 'ok', 'data' => user.as_json })
        end
      end

      context 'when reset operation fails' do
        it 'returns a failure message' do
          allow(user).to receive(:reset!).and_return(false)
          allow(user).to receive(:errors).and_return({ base: ['Reset operation failed'] })

          get :reset, params: { user_id: user_id }

          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)).to eq({ 'message' => 'failed', 'errors' => { 'base' => ['Reset operation failed'] } })
        end
      end
    end

    context 'when user is not found' do
      it 'returns a 404 not found message' do
        allow(User).to receive(:find_by_id).and_return(nil)

        get :reset, params: { user_id: user_id }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'user not found' })
      end
    end
  end
end
