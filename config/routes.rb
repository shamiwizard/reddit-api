Rails.application.routes.draw do
  devise_for :users

  namespace :api, default: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'sign_up', to: 'registrations#create'
        post 'sign_in', to: 'sessions#create'
      end

      resource :user, only: %i[update destroy show] do
        put 'update_photo', to: 'users#update_photo'
      end
    end
  end
end
