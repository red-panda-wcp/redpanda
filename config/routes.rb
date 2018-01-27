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

  resources :carts
  resources :history_address
  resources :admin_users, only:[:index]
  resources :categories,only: [:new, :create, :index, :update, :edit, :destroy]

  resources :items,only: [:new, :create, :index, :show, :update, :edit, :destroy] do
    resources :discs
    resources :songs


  end
  root "items#index"
end