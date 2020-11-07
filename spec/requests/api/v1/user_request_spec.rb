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
    let(:params) do
      {
        user: {
          first_name: 'Misha',
          email: 'test@email.com',
          photo: 'data:image/png;base64,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'
        }
      }
    end
    before do
      CarrierWave.configure do |config|
        config.enable_processing = false
      end

      put '/api/v1/user', params: params,
        headers: {
          'X-User-Token': user_authentication_token,
          'X-User-Usarname': user_username
        }
    end

    after do
       user.reload.remove_photo!
       user.save
    end

    context 'when username and token are correct' do
      it 'update last_name for user' do
        expect(user.reload.first_name).to eq('Misha')
      end

      it 'update email for user' do
        expect(user.reload.email).to eq('test@email.com')
      end

      it 'update photo for user' do
        expect(user.reload.photo.file.nil?).to be_falsy
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