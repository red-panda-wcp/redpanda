Rails.application.routes.draw do

  devise_for :admins,controllers: {
        registrations: 'admins/registrations',
        sessions: 'admins/sessions',
        passwords: 'users/passwords'
        }

  devise_for :users,controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords'
      }
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/users/show" => "users#show",as: :users
  delete "/users/destroy" =>"users#destroy"

  resources :carts
  resources :history_addresses, only:[:create]
  resources :admin_users, only:[:index, :show,:destroy]
  resources :categories,only: [:new, :create, :index, :update, :edit, :destroy]

  resources :items,only: [:new, :create, :index, :show, :update, :edit, :destroy] do
    resources :discs
    resources :songs
  end

  get "/admin_users/edit/:id" => "admin_users#edit", as: :edit_adminusers_to_users
  post "/admin_users/:id" => "admin_users#update", as: :adminusers_to_users
  root "items#index"
end