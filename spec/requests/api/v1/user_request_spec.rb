require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user) { create(:user) }
  let(:user_authentication_token) { user.authentication_token }
  let(:user_username) { user.username }

  describe 'GET /show' do
    before do
      get '/api/v1/user', headers: {
        'X-User-Token': user_authentication_token,
        'X-User-Usarname': user_username
      }
    end

    context 'when data is correct' do
      it 'return ' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Member')
        expect(JSON.parse(response.body)['is_success']).to eq(true)
        expect(JSON.parse(response.body)['data']).not_to be_empty
        expect(JSON.parse(response.body)['data']).to have_key('user')
      end
    end

    context 'when user token in not correct' do
      let(:user_authentication_token) { '' }

      it 'return http status :found' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'when user username in not correct' do
      let(:user_username) { '' }

      it 'return http status :found' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'PUT /user' do
    let(:params) { { user: { first_name: 'Misha', email: 'test@email.com' } } }

    before do
      put '/api/v1/user', params: params,
        headers: {
          'X-User-Token': user_authentication_token,
          'X-User-Usarname': user_username
        }
    end

    context 'when username and token are correct' do
      it 'update last_name for user' do
        expect(user.reload.first_name).to eq('Misha')
      end

      it 'update email for user' do
        expect(user.reload.email).to eq('test@email.com')
      end
    end

    context 'when user token in not correct' do
      let(:params) { { user: { email: 'test@email.com' } } }
      let(:user_authentication_token) { '' }

      it 'return http status :found' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to('/users/sign_in')
      end

      it "don't update user's email" do
        expect(user.reload.email).to_not eq('test@email.com')
      end
    end

    context 'when username in not correct' do
      let(:params) { { user: { email: 'test@email.com' } } }
      let(:user_username) { '' }

      it 'return http status :found' do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to('/users/sign_in')
      end

      it "don't update user's email" do
        expect(user.reload.email).to_not eq('test@email.com')
      end
    end

    context 'when member update password' do
      context 'when password confirmation present' do
        let(:params) { { user: { password: 'password123', password_confirmation: 'password123' } } }

        it 'update user password' do
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['message']).to eq('Parameters are updated')
          expect(JSON.parse(response.body)['is_success']).to eq(true)
          expect(JSON.parse(response.body)['data']).not_to be_empty
          expect(JSON.parse(response.body)['data']).to have_key('user')
          expect(user.reload.valid_password?('password123')).to eq(true)
        end

        context 'when password confirmation incorrect' do
          let(:params) { { user: { password: 'password123', password_confirmation: 'password' } } }

          it "don't update password" do
            expect(response).to have_http_status(:unprocessable_entity)
            expect(user.reload.valid_password?('password123')).to eq(false)
          end
        end

        context "when passoword confirmation is empty" do
          let(:params) { { user: { password: 'password123', password_confirmation: '' } } }

          it "don't update password" do
            expect(JSON.parse(response.body)['message']).to eq('Something goes wrong')
            expect(response).to have_http_status(:unprocessable_entity)
            expect(user.reload.valid_password?('password123')).to eq(false)
          end
        end
      end
    end
  end

  describe 'DELETE /user' do
    before do
      delete '/api/v1/user', headers: {
        'X-User-Token': user_authentication_token,
        'X-User-Usarname': user_username
      }
    end

    context 'when token and username are correct' do
      it 'return http status :ok' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Member is destroyed')
        expect(JSON.parse(response.body)['is_success']).to eq(true)
      end

      it 'delete user' do
        expect(User.count).to eq(0)
      end
    end
  end
end