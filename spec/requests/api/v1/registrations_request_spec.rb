require 'rails_helper'

RSpec.describe 'Api::V1::Registrations', type: :request do
  let(:user) { attributes_for(:user) }

  describe 'POST /create' do
    context 'where json is correct' do
      it 'returns http success' do
        post '/api/v1/sign_up', params: { user: user }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Sign Up Successfuly')
        expect(JSON.parse(response.body)['is_success']).to eq(true)
        expect(JSON.parse(response.body)['data']).not_to be_empty
        expect(JSON.parse(response.body)['data']).to have_key('user')
      end
    end

    context 'when json dont have email' do
      it 'return http error' do
        user[:email] = ''
        post '/api/v1/sign_up', params: { user: user }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq('Sign Up Failded')
        expect(JSON.parse(response.body)['is_success']).to eq(false)
        expect(JSON.parse(response.body)['data']).to be_empty
      end
    end

    context 'when json is empty' do
      it 'return http bad request' do
        user = nil
        post '/api/v1/sign_up', params: { user: user }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('Missing Params')
        expect(JSON.parse(response.body)['is_success']).to eq(false)
        expect(JSON.parse(response.body)['data']).to be_empty
      end
    end
  end
end
