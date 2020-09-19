Rails.application.routes.draw do
  devise_for :users

  namespace :api, default: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'sign_up', to: 'registrations#create'
        post 'sign_in', to: 'sessions#create'
      end

      get 'user/index'
      get 'user/show'
      get 'user/create'
      get 'user/update'
      get 'user/destroy'
    end
  end
end
