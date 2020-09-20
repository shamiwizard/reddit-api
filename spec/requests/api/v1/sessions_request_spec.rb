require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  describe 'POST #sign_in' do
    let(:user) { create(:user) }

    context 'when json correct' do
      it 'return http status success' do
        post '/api/v1/sign_in', params: {
          sign_in: {
            username: user.username,
            password: user.password
          }
        }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Signed In Successfully')
        expect(JSON.parse(response.body)['is_success']).to eq(true)
        expect(JSON.parse(response.body)['data']).not_to be_empty
        expect(JSON.parse(response.body)['data']).to have_key('user')
      end
    end

    context "when json don't have  username" do
      it 'return http status not authoraized' do
        post '/api/v1/sign_in', params: {
          sign_in: {
            username: '',
            password: user.password
          }
        }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Cannot get User')
        expect(JSON.parse(response.body)['is_success']).to eq(false)
        expect(JSON.parse(response.body)['data']).to be_empty
      end
    end

    context "when json don't have password" do
      it 'return http status not authoraized' do
        post '/api/v1/sign_in', params: {
          sign_in: {
            username: user.username,
            password: ''
          }
        }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['message']).to eq('Signed In Failed - Unauthorized')
        expect(JSON.parse(response.body)['is_success']).to eq(false)
        expect(JSON.parse(response.body)['data']).to be_empty
      end
    end
  end
end
